import 'dart:async';
import 'dart:typed_data';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:flutter/services.dart';

import '../../../../core/utils/logger.dart';
import '../data/models/meeting_room_model.dart';

// --- Pro State Class ---
class ProAgoraState {
  final bool initialized;
  final bool localUserJoined;
  final List<int> remoteUids;
  final bool isMuted;
  final bool isVideoOff;
  final bool isFrontCamera;
  final String? channelName;
  final String? userRole; // "host" vs "participant"
  final bool isScreenSharing;
  final RtcEngine? engine;

  // Pro Features
  final int? pinnedUid;
  final Set<int> mutedRemoteUids;
  final Set<int> raisedHandUids; // Tracks users with hand raised
  final int? streamId; // Agora Data Stream ID
  final String? lastError; // For UI feedback

  ProAgoraState({
    this.initialized = false,
    this.localUserJoined = false,
    this.remoteUids = const [],
    this.isMuted = false,
    this.isVideoOff = false,
    this.isFrontCamera = true,
    this.channelName,
    this.userRole,
    this.isScreenSharing = false,
    this.engine,
    this.pinnedUid,
    this.mutedRemoteUids = const {},
    this.raisedHandUids = const {},
    this.streamId,
    this.lastError,
  });

  ProAgoraState copyWith({
    bool? initialized,
    bool? localUserJoined,
    List<int>? remoteUids,
    bool? isMuted,
    bool? isVideoOff,
    bool? isFrontCamera,
    String? channelName,
    String? userRole,
    bool? isScreenSharing,
    RtcEngine? engine,
    int? pinnedUid,
    Set<int>? mutedRemoteUids,
    Set<int>? raisedHandUids, // New
    int? streamId, // New
    String? lastError,
  }) {
    return ProAgoraState(
      initialized: initialized ?? this.initialized,
      localUserJoined: localUserJoined ?? this.localUserJoined,
      remoteUids: remoteUids ?? this.remoteUids,
      isMuted: isMuted ?? this.isMuted,
      isVideoOff: isVideoOff ?? this.isVideoOff,
      isFrontCamera: isFrontCamera ?? this.isFrontCamera,
      channelName: channelName ?? this.channelName,
      userRole: userRole ?? this.userRole,
      isScreenSharing: isScreenSharing ?? this.isScreenSharing,
      engine: engine ?? this.engine,
      pinnedUid: pinnedUid ?? this.pinnedUid,
      mutedRemoteUids: mutedRemoteUids ?? this.mutedRemoteUids,
      raisedHandUids: raisedHandUids ?? this.raisedHandUids,
      streamId: streamId ?? this.streamId,
      lastError: lastError,
    );
  }
}

// --- Pro Controller Class ---
class ProAgoraNotifier extends StateNotifier<ProAgoraState> {
  ProAgoraNotifier() : super(ProAgoraState());

  static const _channel = MethodChannel('com.geniuses_school/screen_share');

  RtcEngine? get engine => state.engine;

  Future<void> initialize(MeetingRoomData data) async {
    final appId = dotenv.env['AGORA_APP_ID'];
    if (appId == null || appId.isEmpty) {
      Logger.log("Agora App ID not found in .env");
      return;
    }

    // Request Permissions
    await [Permission.microphone, Permission.camera].request();

    // Enable WakeLock to keep screen on
    await WakelockPlus.enable();

    // Create Engine
    final engine = createAgoraRtcEngine();

    // Initialize actual Engine with config
    try {
      await engine.initialize(
        RtcEngineContext(
          appId: appId,

          channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
        ),
      );
    } catch (e) {
      Logger.log("Engine init error: $e");
      return;
    }

    await engine.enableVideo();
    await engine.startPreview();
    await engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);

    // Event Handlers
    engine.registerEventHandler(
      RtcEngineEventHandler(
        onError: (ErrorCodeType err, String msg) {
          Logger.log("Agora Error: $err, $msg");
        },
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          Logger.log("Local user joined: ${connection.localUid}");
          state = state.copyWith(localUserJoined: true);
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          Logger.log("Remote user joined: $remoteUid");
          // Add to remoteUids
          final updatedList = [...state.remoteUids, remoteUid];
          state = state.copyWith(remoteUids: updatedList);
        },
        onUserOffline:
            (
              RtcConnection connection,
              int remoteUid,
              UserOfflineReasonType reason,
            ) {
              Logger.log("Remote user offline: $remoteUid");
              final updatedList = state.remoteUids
                  .where((uid) => uid != remoteUid)
                  .toList();

              // If pinned user left, unpin
              final newPinned = state.pinnedUid == remoteUid
                  ? null
                  : state.pinnedUid;

              // Remove from muted list and hand raised list
              final newMuted = Set<int>.from(state.mutedRemoteUids)
                ..remove(remoteUid);
              final newRaised = Set<int>.from(state.raisedHandUids)
                ..remove(remoteUid);

              // We must manually construct state to handle nullable pinnedUid if it changed to null
              state = ProAgoraState(
                initialized: state.initialized,
                localUserJoined: state.localUserJoined,
                remoteUids: updatedList,
                isMuted: state.isMuted,
                isVideoOff: state.isVideoOff,
                isFrontCamera: state.isFrontCamera,
                channelName: state.channelName,
                userRole: state.userRole,
                isScreenSharing: state.isScreenSharing,
                engine: state.engine,
                pinnedUid: newPinned,
                mutedRemoteUids: newMuted,
                raisedHandUids: newRaised,
                streamId: state.streamId,
              );
            },
        onStreamMessage:
            (
              RtcConnection connection,
              int remoteUid,
              int streamId,
              Uint8List data,
              int length,
              int sentTs,
            ) {
              // Decode message
              try {
                final message = String.fromCharCodes(data);
                Logger.log("Received Stream Message from $remoteUid: $message");

                if (message == "hand_up") {
                  final newSet = Set<int>.from(state.raisedHandUids)
                    ..add(remoteUid);
                  state = state.copyWith(raisedHandUids: newSet);
                  _startHandTimer(remoteUid);
                } else if (message == "hand_down") {
                  final newSet = Set<int>.from(state.raisedHandUids)
                    ..remove(remoteUid);
                  state = state.copyWith(raisedHandUids: newSet);
                  _cancelHandTimer(remoteUid);
                }
              } catch (e) {
                Logger.log("Error decoding stream message: $e");
              }
            },
      ),
    );

    state = state.copyWith(initialized: true, engine: engine);

    // Create Data Stream for signaling
    try {
      final streamId = await engine.createDataStream(
        const DataStreamConfig(syncWithAudio: false, ordered: true),
      );
      state = state.copyWith(streamId: streamId);
      Logger.log("Data Stream Created: $streamId");
    } catch (e) {
      Logger.log("Error creating data stream: $e");
    }

    // Join Channel
    await joinChannel(data);
  }

  Future<void> joinChannel(MeetingRoomData data) async {
    final settings = data.agora;
    if (settings == null || state.engine == null) return;

    state = state.copyWith(
      channelName: settings.channel,
      userRole: settings.role,
    );

    await state.engine!.joinChannelWithUserAccount(
      token: settings.token ?? '',
      channelId: settings.channel ?? '',
      userAccount: settings.uid ?? '',
    );
  }

  Future<void> leaveChannel() async {
    // Disable WakeLock
    try {
      await WakelockPlus.disable();
    } catch (_) {}

    if (state.engine != null) {
      if (state.isScreenSharing) {
        try {
          await state.engine!.stopScreenCapture();
        } catch (_) {} // Ignore error if already stopped
        try {
          await _channel.invokeMethod('stopService');
        } catch (e) {
          Logger.log("Error stopping screen share service: $e");
        }
      }
      try {
        await state.engine!.leaveChannel();
      } catch (_) {}
      try {
        await state.engine!.release();
      } catch (_) {}

      if (mounted) {
        state = ProAgoraState(); // Reset state only if still mounted
      }
    }
  }

  Future<void> toggleMute() async {
    final newMute = !state.isMuted;
    await state.engine?.muteLocalAudioStream(newMute);
    state = state.copyWith(isMuted: newMute);
  }

  Future<void> toggleVideo() async {
    final newVideoOff = !state.isVideoOff;
    await state.engine?.muteLocalVideoStream(newVideoOff);
    state = state.copyWith(isVideoOff: newVideoOff);
  }

  Future<void> switchCamera() async {
    await state.engine?.switchCamera();
    state = state.copyWith(isFrontCamera: !state.isFrontCamera);
  }

  Future<void> toggleScreenShare() async {
    final engine = state.engine;
    if (engine == null) return;

    try {
      if (!state.isScreenSharing) {
        // Step 1: Unpublish everything (Clean Slate)
        Logger.log("ScreenShare Step 1: Unpublishing all video...");
        await engine.updateChannelMediaOptions(
          const ChannelMediaOptions(
            publishCameraTrack: false,
            publishScreenCaptureVideo: false,
            publishMicrophoneTrack: true,
            clientRoleType: ClientRoleType.clientRoleBroadcaster,
          ),
        );

        // Step 2: Stop Camera Preview
        Logger.log("ScreenShare Step 2: Stopping preview...");
        await engine.stopPreview();

        // Step 3: Start Screen Capture
        Logger.log("ScreenShare Step 3: Starting capture...");
        try {
          await engine.startScreenCapture(
            const ScreenCaptureParameters2(
              captureVideo: true,
              captureAudio: false,
            ),
          );
        } catch (e) {
          Logger.log("StartCapture failed ($e), trying to stop and restart...");
          await engine.stopScreenCapture();
          await engine.startScreenCapture(
            const ScreenCaptureParameters2(
              captureVideo: true,
              captureAudio: false,
            ),
          );
        }

        // Critical: Start LOCAL PREVIEW for the screen source
        await engine.startPreview(
          sourceType: VideoSourceType.videoSourceScreen,
        );

        // Step 4: Publish Screen Track
        Logger.log("ScreenShare Step 4: Publishing screen...");
        await engine.updateChannelMediaOptions(
          const ChannelMediaOptions(
            publishScreenCaptureVideo: true,
            publishScreenCaptureAudio: false,
            publishCameraTrack: false,
            publishMicrophoneTrack: true,
            clientRoleType: ClientRoleType.clientRoleBroadcaster,
          ),
        );

        // Wait a bit for the surface to be ready (reduced delay)
        await Future.delayed(const Duration(milliseconds: 500));

        state = state.copyWith(
          isScreenSharing: true,
          isVideoOff: true, // Camera is effectively off
        );

        // Start native service for Android 14+ compliance
        try {
          await _channel.invokeMethod('startService');
        } catch (e) {
          Logger.log("Error starting screen share service: $e");
        }
      } else {
        // Stop Screen Share
        await engine.stopScreenCapture();
        try {
          await _channel.invokeMethod('stopService');
        } catch (e) {
          Logger.log("Error stopping screen share service: $e");
        }
        // Stop screen preview
        try {
          await engine.stopPreview(
            sourceType: VideoSourceType.videoSourceScreen,
          );
        } catch (_) {}

        await engine.updateChannelMediaOptions(
          const ChannelMediaOptions(
            publishCameraTrack: true,
            publishMicrophoneTrack: true,
            publishScreenCaptureVideo: false,
            publishScreenCaptureAudio: false,
            clientRoleType: ClientRoleType.clientRoleBroadcaster,
          ),
        );

        // Restart camera preview
        await engine.startPreview(
          sourceType: VideoSourceType.videoSourceCamera,
        );

        state = state.copyWith(isScreenSharing: false, isVideoOff: false);
      }
    } catch (e) {
      Logger.log("ToggleScreenShare Error: $e");
      state = state.copyWith(lastError: "Screen Share Error: $e");
    }
  }

  // --- Pro Features Methods ---

  void togglePin(int uid) {
    if (state.pinnedUid == uid) {
      // Unpin: Reconstruct state with null pinnedUid
      state = ProAgoraState(
        initialized: state.initialized,
        localUserJoined: state.localUserJoined,
        remoteUids: state.remoteUids,
        isMuted: state.isMuted,
        isVideoOff: state.isVideoOff,
        isFrontCamera: state.isFrontCamera,
        channelName: state.channelName,
        userRole: state.userRole,
        isScreenSharing: state.isScreenSharing,
        engine: state.engine,
        pinnedUid: null, // Set to null
        mutedRemoteUids: state.mutedRemoteUids,
      );
    } else {
      // Pin new user
      state = state.copyWith(pinnedUid: uid);
    }
  }

  Future<void> toggleRemoteAudio(int uid) async {
    final isCurrentlyMuted = state.mutedRemoteUids.contains(uid);
    final shouldMute = !isCurrentlyMuted;

    // Use Agora API to mute/unmute playback of this specific remote user
    await state.engine?.muteRemoteAudioStream(uid: uid, mute: shouldMute);

    final newMutedSet = Set<int>.from(state.mutedRemoteUids);
    if (shouldMute) {
      newMutedSet.add(uid);
    } else {
      newMutedSet.remove(uid);
    }

    state = state.copyWith(mutedRemoteUids: newMutedSet);
  }

  Future<void> toggleMuteAllRemote() async {
    final allMuted =
        state.mutedRemoteUids.length == state.remoteUids.length &&
        state.remoteUids.isNotEmpty;
    final shouldMute = !allMuted;

    // Iterate and mute/unmute
    for (final uid in state.remoteUids) {
      await state.engine?.muteRemoteAudioStream(uid: uid, mute: shouldMute);
    }

    if (shouldMute) {
      // Add all to set
      state = state.copyWith(mutedRemoteUids: Set.from(state.remoteUids));
    } else {
      // Clear set
      state = state.copyWith(mutedRemoteUids: {});
    }
  }

  // Timers for auto-lowering hands
  final Map<int, Timer> _handTimers = {};

  void _startHandTimer(int uid) {
    _handTimers[uid]?.cancel();
    _handTimers[uid] = Timer(const Duration(seconds: 30), () {
      // Time's up: lower the hand
      if (state.raisedHandUids.contains(uid)) {
        final newSet = Set<int>.from(state.raisedHandUids)..remove(uid);
        state = state.copyWith(raisedHandUids: newSet);
        if (uid == 0 && state.engine != null && state.streamId != null) {
          // If it was me, send "hand_down" signal to others so they know I timed out
          try {
            const action = "hand_down";
            state.engine!.sendStreamMessage(
              streamId: state.streamId!,
              data: Uint8List.fromList(action.codeUnits),
              length: action.length,
            );
          } catch (_) {}
        }
      }
      _handTimers.remove(uid);
    });
  }

  void _cancelHandTimer(int uid) {
    _handTimers[uid]?.cancel();
    _handTimers.remove(uid);
  }

  Future<void> toggleHandRaise() async {
    final streamId = state.streamId;
    final engine = state.engine;

    if (streamId == null || engine == null) {
      Logger.log("Cannot raise hand: Stream not initialized");
      return;
    }

    final isRaised = state.raisedHandUids.contains(0); // 0 is me
    final action = isRaised ? "hand_down" : "hand_up";

    try {
      await engine.sendStreamMessage(
        streamId: streamId,
        data: Uint8List.fromList(action.codeUnits),
        length: action.length,
      );

      // Update local state immediately
      final newSet = Set<int>.from(state.raisedHandUids);
      if (isRaised) {
        newSet.remove(0);
        _cancelHandTimer(0);
      } else {
        newSet.add(0);
        _startHandTimer(0);
      }
      state = state.copyWith(raisedHandUids: newSet);
    } catch (e) {
      Logger.log("Failed to send hand signal: $e");
      state = state.copyWith(lastError: "Failed to raise hand");
    }
  }

  // Allow host to lower a student's hand (locally acknowledge)
  void lowerRemoteHand(int uid) {
    final newSet = Set<int>.from(state.raisedHandUids)..remove(uid);
    state = state.copyWith(raisedHandUids: newSet);
    _cancelHandTimer(uid);
  }

  @override
  void dispose() {
    for (final timer in _handTimers.values) {
      timer.cancel();
    }
    _handTimers.clear();
    leaveChannel();
    super.dispose();
  }
}

final proAgoraProvider = StateNotifierProvider<ProAgoraNotifier, ProAgoraState>(
  (ref) {
    return ProAgoraNotifier();
  },
);
