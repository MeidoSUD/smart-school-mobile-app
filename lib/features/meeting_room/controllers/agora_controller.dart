import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/utils/logger.dart';
import '../data/models/meeting_room_model.dart';

// --- State Class ---
class AgoraState {
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

  AgoraState({
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
  });

  AgoraState copyWith({
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
  }) {
    return AgoraState(
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
    );
  }
}

// --- Controller Class ---
class AgoraNotifier extends StateNotifier<AgoraState> {
  AgoraNotifier() : super(AgoraState());

  static const _channel = MethodChannel('com.geniuses_school/screen_share');

  RtcEngine? get engine => state.engine;

  Future<void> initialize(MeetingRoomData data) async {
    final appId = dotenv.env['AGORA_APP_ID'];
    if (appId == null || appId.isEmpty) {
      Logger.log("Agora App ID found in .env");
      // For safety during dev if .env fails, maybe fallback or throw?
      // Assuming user sets it.
    }

    // Request Permissions
    await [Permission.microphone, Permission.camera].request();

    // Create Engine
    final engine = createAgoraRtcEngine();

    // Initialize actual Engine with config
    try {
      await engine.initialize(
        RtcEngineContext(
          appId: appId ?? '',
          channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
        ),
      );
    } catch (e) {
      Logger.log("Engine init error: $e");
      // If init fails, we might want to return or show error
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
          state = state.copyWith(remoteUids: [...state.remoteUids, remoteUid]);
        },
        onUserOffline:
            (
              RtcConnection connection,
              int remoteUid,
              UserOfflineReasonType reason,
            ) {
              Logger.log("Remote user offline: $remoteUid");
              state = state.copyWith(
                remoteUids: state.remoteUids
                    .where((uid) => uid != remoteUid)
                    .toList(),
              );
            },
      ),
    );

    state = state.copyWith(initialized: true, engine: engine);

    // Join Channel
    await joinChannel(data);
  }

  Future<void> joinChannel(MeetingRoomData data) async {
    final settings = data.agora;
    if (settings == null || state.engine == null) return;

    // Use joinChannelWithUserAccount if uid is String, normally Agora returns int uid in 'uid' field for token generation?
    // The API returns "uid": "student_4" (String).
    // BUT 'joinChannel' takes 'int uid'.
    // We MUST use 'joinChannelWithUserAccount' if we want to use the String UID.
    // OR we ignore the string UID for *joining* (let Agora assign one or parse it if it's int-parsable).
    // "student_4" is NOT int-parsable.
    // So 'joinChannelWithUserAccount' is correct.

    // Update channel name and role in state
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
    if (state.engine != null) {
      // Ensure screen share is stopped if active
      if (state.isScreenSharing) {
        await state.engine!.stopScreenCapture();
        try {
          await _channel.invokeMethod('stopService');
        } catch (e) {
          Logger.log("Error stopping screen share service: $e");
        }
      }

      await state.engine!.leaveChannel();
      await state.engine!.release();
      state = AgoraState(); // Reset state
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
        // Start Screen Share
        await engine.startScreenCapture(
          const ScreenCaptureParameters2(
            captureVideo: true,
            captureAudio: true,
          ),
        );
        await engine.updateChannelMediaOptions(
          const ChannelMediaOptions(
            publishCameraTrack: false,
            publishMicrophoneTrack: true,
            publishScreenCaptureVideo: true,
            publishScreenCaptureAudio: true,
            clientRoleType: ClientRoleType.clientRoleBroadcaster,
          ),
        );
        state = state.copyWith(
          isScreenSharing: true,
          isVideoOff: true,
        ); // Camera is technically off

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
        await engine.updateChannelMediaOptions(
          const ChannelMediaOptions(
            publishCameraTrack: true,
            publishMicrophoneTrack: true,
            publishScreenCaptureVideo: false,
            publishScreenCaptureAudio: false,
            clientRoleType: ClientRoleType.clientRoleBroadcaster,
          ),
        );
        await engine.startPreview();
        state = state.copyWith(isScreenSharing: false, isVideoOff: false);
      }
    } catch (e) {
      Logger.log("ToggleScreenShare Error: $e");
    }
  }

  @override
  void dispose() {
    leaveChannel();
    super.dispose();
  }
}

final agoraProvider =
    StateNotifierProvider.autoDispose<AgoraNotifier, AgoraState>((ref) {
      return AgoraNotifier();
    });
