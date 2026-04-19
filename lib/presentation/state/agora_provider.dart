import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:geniuses_school/core/utils/logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

// Replace with your Agora App ID
const String agoraAppId = '5870d09ab8e6439299531bb092fc6cbf';

final agoraProvider = StateNotifierProvider<AgoraController, AgoraState>(
  (ref) => AgoraController(),
);

class AgoraState {
  final bool isJoined;
  final int? localUid;
  final List<int> remoteUids;
  final String? classroomId;
  final String role; // 'teacher' or 'student'
  final Map<int, int> audioLevels;

  AgoraState({
    this.isJoined = false,
    this.localUid,
    this.remoteUids = const [],
    this.classroomId,
    this.role = 'student',
    this.audioLevels = const {},
  });

  AgoraState copyWith({
    bool? isJoined,
    int? localUid,
    List<int>? remoteUids,
    String? classroomId,
    String? role,
    Map<int, int>? audioLevels,
  }) {
    return AgoraState(
      isJoined: isJoined ?? this.isJoined,
      localUid: localUid ?? this.localUid,
      remoteUids: remoteUids ?? this.remoteUids,
      classroomId: classroomId ?? this.classroomId,
      role: role ?? this.role,
      audioLevels: audioLevels ?? this.audioLevels,
    );
  }
}

class AgoraController extends StateNotifier<AgoraState> {
  late RtcEngine _engine;

  AgoraController() : super(AgoraState()) {
    _initAgora();
  }

  Future<void> _initAgora() async {
    Logger.log('🔧 Initializing Agora...');

    // Request permissions FIRST
    await _requestPermissions();

    _engine = createAgoraRtcEngine();
    await _engine.initialize(const RtcEngineContext(appId: agoraAppId));
    Logger.log('✅ Agora initialized');

    // Enable video and audio
    await _engine.enableVideo();
    Logger.log('✅ Video enabled');
    await _engine.enableAudio();
    Logger.log('✅ Audio enabled');

    await _engine.enableAudioVolumeIndication(
      interval: 200, // Update every 200ms
      smooth: 3,
      reportVad: true,
    );
    await _engine.startPreview();
    Logger.log('✅ Preview started');

    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (connection, elapsed) {
          Logger.log(
            '✅ JOIN SUCCESS - Channel: ${connection.channelId}, Local UID: ${connection.localUid}',
          );
          state = state.copyWith(isJoined: true, localUid: connection.localUid);
        },
        onUserJoined: (connection, remoteUid, elapsed) {
          Logger.log('✅ REMOTE USER JOINED: $remoteUid');
          state = state.copyWith(remoteUids: [...state.remoteUids, remoteUid]);
        },
        onUserOffline: (connection, remoteUid, reason) {
          Logger.log('❌ USER LEFT: $remoteUid, reason: $reason');
          state = state.copyWith(
            remoteUids: state.remoteUids
                .where((id) => id != remoteUid)
                .toList(),
          );
        },
        // ADD THIS - Audio volume callback
        onAudioVolumeIndication:
            (connection, speakers, speakerNumber, totalVolume) {
              final updated = <int, int>{};

              for (var speaker in speakers) {
                // Agora rule:
                // uid = 0 → local user
                final uid = speaker.uid == 0
                    ? (state.localUid ?? 0)
                    : (speaker.uid ?? 0);

                updated[uid] = speaker.volume ?? 0;
              }

              // Merge into existing map
              final merged = Map<int, int>.from(state.audioLevels);

              // 1. Update changed users (those currently speaking)
              updated.forEach((uid, vol) {
                merged[uid] = vol;
              });

              // 2. Fade users who were NOT updated this frame
              const fadeStep = 10; // Decrease volume by 10 per frame (200ms)
              for (var uid in merged.keys.toList()) {
                if (!updated.containsKey(uid)) {
                  final currentVolume = merged[uid] ?? 0;
                  // Decrease the volume, but ensure it doesn't go below 0
                  merged[uid] = (currentVolume - fadeStep).clamp(0, 255);

                  // OPTIONAL: Clean up the map if volume is 0
                  if (merged[uid] == 0) {
                    merged.remove(uid);
                  }
                }
              }

              state = state.copyWith(audioLevels: merged);
            },

        onLeaveChannel: (connection, stats) {
          Logger.log('👋 Left channel');
        },
        onError: (err, msg) {
          Logger.log('❌ ERROR: $err - $msg');
        },
        onRemoteVideoStateChanged: (connection, remoteUid, state, reason, elapsed) {
          Logger.log(
            '📹 Remote video state - UID: $remoteUid, State: $state, Reason: $reason',
          );
        },
        onLocalVideoStateChanged: (source, state, error) {
          Logger.log('📹 Local video state - State: $state, Error: $error');
        },
      ),
    );
  }

  Future<void> _requestPermissions() async {
    Logger.log('📸 Requesting permissions...');

    // Request camera permission
    var cameraStatus = await Permission.camera.request();
    Logger.log('Camera: $cameraStatus');

    // Request microphone permission
    var micStatus = await Permission.microphone.request();
    Logger.log('Microphone: $micStatus');

    if (!cameraStatus.isGranted) {
      Logger.log('⚠️ Camera permission denied!');
    }
    if (!micStatus.isGranted) {
      Logger.log('⚠️ Microphone permission denied!');
    }
  }

  Future<void> joinChannel({
    required String token,
    required String channelName,
    required int uid,
    required String role,
  }) async {
    Logger.log('🚀 Attempting to join channel...');
    Logger.log('   Channel: $channelName');
    Logger.log('   UID: $uid');
    Logger.log('   Token: ${token.substring(0, 20)}...');

    state = state.copyWith(classroomId: channelName, role: role);

    try {
      await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
      Logger.log('✅ Set as BROADCASTER (role: $role)');

      await _engine.joinChannel(
        token: token,
        channelId: channelName,
        uid: uid,
        options: const ChannelMediaOptions(
          channelProfile: ChannelProfileType.channelProfileCommunication,
          clientRoleType: ClientRoleType.clientRoleBroadcaster,
          publishMicrophoneTrack: true,
          publishCameraTrack: true,
          autoSubscribeAudio: true,
          autoSubscribeVideo: true,
        ),
      );
      Logger.log('✅ Join channel called successfully');
    } catch (e) {
      Logger.log('❌ Failed to join channel: $e');
    }
  }

  Future<void> leaveChannel() async {
    await _engine.leaveChannel();
    state = state.copyWith(
      isJoined: false,
      remoteUids: [],
      localUid: null,
      classroomId: null,
    );
  }

  RtcEngine get engine => _engine;
}
