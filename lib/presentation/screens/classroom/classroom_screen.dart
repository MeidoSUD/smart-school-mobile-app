import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:geniuses_school/l10n/app_localizations.dart';
import 'package:geniuses_school/presentation/state/agora_provider.dart';
import 'package:geniuses_school/presentation/state/classroom_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClassroomScreen extends ConsumerStatefulWidget {
  final int userId;
  final bool isTeacher;

  const ClassroomScreen({
    super.key,
    required this.userId,
    this.isTeacher = false,
  });

  @override
  ConsumerState<ClassroomScreen> createState() => _ClassroomScreenState();
}

class _ClassroomScreenState extends ConsumerState<ClassroomScreen> {
  bool _isMicMuted = false;
  bool _isVideoOff = false;
  bool _isSpeakerOn = true;

  @override
  Widget build(BuildContext context) {
    final classroomState = ref.watch(classroomProvider);
    final classroomNotifier = ref.read(classroomProvider.notifier);
    final agoraState = ref.watch(agoraProvider);
    final agoraController = ref.read(agoraProvider.notifier);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: theme.primaryColor,
        title: Row(
          children: [
            Icon(
              widget.isTeacher ? Icons.school : Icons.person,
              color: Colors.white,
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.isTeacher
                      ? AppLocalizations.of(context)!.teaching
                      : AppLocalizations.of(context)!.learning,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                if (classroomState.classroomId != null)
                  Text(
                    '${AppLocalizations.of(context)!.room}: ${classroomState.classroomId}',
                    style: const TextStyle(fontSize: 12, color: Colors.white70),
                  ),
              ],
            ),
          ],
        ),
        actions: [
          if (classroomState.isJoined)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Chip(
                avatar: const Icon(Icons.circle, color: Colors.green, size: 12),
                label: Text(
                  '${agoraState.remoteUids.length + 1} ${AppLocalizations.of(context)!.users}',
                  style: const TextStyle(fontSize: 12, color: Colors.white),
                ),
                backgroundColor: Colors.black26,
              ),
            ),
        ],
      ),
      body: classroomState.isLoading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: theme.primaryColor),
                  const SizedBox(height: 16),
                  Text(
                    AppLocalizations.of(context)!.connectingToClassroom,
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            )
          : classroomState.error != null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${classroomState.error}',
                    style: const TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back),
                    label: Text(AppLocalizations.of(context)!.goBack),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.primaryColor,
                    ),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                // Video Grid
                Expanded(
                  child: Container(
                    color: Colors.black,
                    child: _buildVideoGrid(
                      agoraState,
                      agoraController,
                      classroomState,
                      theme,
                    ),
                  ),
                ),

                // Control Panel
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[850],
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 24,
                  ),
                  child: classroomState.isJoined
                      ? _buildControlButtons(
                          agoraController,
                          classroomNotifier,
                          theme,
                        )
                      : _buildJoinButton(classroomNotifier, theme),
                ),
              ],
            ),
    );
  }

  Widget _buildVideoGrid(
    AgoraState agoraState,
    AgoraController agoraController,
    ClassroomState classroomState,
    ThemeData theme,
  ) {
    final allParticipants = <Widget>[];

    // Add local video
    if (agoraState.isJoined && agoraState.localUid != null) {
      allParticipants.add(
        _buildVideoTile(
          isLocal: true,
          uid: agoraState.localUid!,
          controller: VideoViewController(
            rtcEngine: agoraController.engine,
            canvas: VideoCanvas(uid: 0),
          ),
          label: AppLocalizations.of(context)!.youRole(
            widget.isTeacher
                ? AppLocalizations.of(context)!.teacher
                : AppLocalizations.of(context)!.student,
          ),
          theme: theme,
        ),
      );
    }

    // Add remote videos
    for (var uid in agoraState.remoteUids) {
      allParticipants.add(
        _buildVideoTile(
          isLocal: false,
          uid: uid,
          controller: VideoViewController.remote(
            rtcEngine: agoraController.engine,
            canvas: VideoCanvas(uid: uid),
            connection: RtcConnection(channelId: classroomState.classroomId!),
          ),
          label: '${AppLocalizations.of(context)!.student} $uid',
          theme: theme,
        ),
      );
    }

    if (allParticipants.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.videocam_off, size: 64, color: Colors.grey[600]),
            const SizedBox(height: 16),
            Text(
              AppLocalizations.of(context)!.noVideoStreams,
              style: TextStyle(color: Colors.grey[400], fontSize: 16),
            ),
          ],
        ),
      );
    }

    // Responsive grid layout
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: allParticipants.length == 1 ? 1 : 2,
        childAspectRatio: 16 / 9,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: allParticipants.length,
      itemBuilder: (context, index) => allParticipants[index],
    );
  }

  Widget _buildVideoTile({
    required bool isLocal,
    required int uid,
    required dynamic controller,
    required String label,
    required ThemeData theme,
  }) {
    return Consumer(
      builder: (context, ref, child) {
        final agoraState = ref.watch(agoraProvider);
        final audioLevel = agoraState.audioLevels[uid] ?? 0;
        final isSpeaking = audioLevel > 10; // Threshold for speaking detection

        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSpeaking
                  ? Colors.greenAccent
                  : (isLocal ? theme.primaryColor : Colors.grey[700]!),
              width: isSpeaking ? 3 : (isLocal ? 2 : 1),
            ),
            boxShadow: isSpeaking
                ? [
                    BoxShadow(
                      color: Colors.greenAccent.withOpacity(0.6),
                      blurRadius: 15,
                      spreadRadius: 2,
                    ),
                  ]
                : [],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(11),
            child: Stack(
              children: [
                // Video view
                if (_isVideoOff && isLocal)
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: theme.primaryColor,
                          child: const Icon(
                            Icons.person,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          AppLocalizations.of(context)!.cameraOff,
                          style: TextStyle(color: Colors.grey[400]),
                        ),
                      ],
                    ),
                  )
                else
                  AgoraVideoView(controller: controller),

                // Overlay info with speaking indicator
                Positioned(
                  bottom: 8,
                  left: 8,
                  right: 8,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: isSpeaking
                          ? Colors.green.withOpacity(0.8)
                          : Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _isMicMuted && isLocal ? Icons.mic_off : Icons.mic,
                          size: 16,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 6),
                        Flexible(
                          child: Text(
                            label,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (isSpeaking) ...[
                          const SizedBox(width: 6),
                          Icon(Icons.graphic_eq, size: 16, color: Colors.white),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildControlButtons(
    AgoraController agoraController,
    ClassroomNotifier classroomNotifier,
    ThemeData theme,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Microphone toggle
        _buildControlButton(
          icon: _isMicMuted ? Icons.mic_off : Icons.mic,
          label: _isMicMuted
              ? AppLocalizations.of(context)!.unmute
              : AppLocalizations.of(context)!.mute,
          isActive: !_isMicMuted,
          onPressed: () {
            setState(() => _isMicMuted = !_isMicMuted);
            agoraController.engine.muteLocalAudioStream(_isMicMuted);
          },
          theme: theme,
        ),

        // Video toggle
        _buildControlButton(
          icon: _isVideoOff ? Icons.videocam_off : Icons.videocam,
          label: _isVideoOff
              ? AppLocalizations.of(context)!.startVideo
              : AppLocalizations.of(context)!.stopVideo,
          isActive: !_isVideoOff,
          onPressed: () {
            setState(() => _isVideoOff = !_isVideoOff);
            agoraController.engine.muteLocalVideoStream(_isVideoOff);
          },
          theme: theme,
        ),

        // Speaker toggle
        _buildControlButton(
          icon: _isSpeakerOn ? Icons.volume_up : Icons.volume_off,
          label: _isSpeakerOn
              ? AppLocalizations.of(context)!.speakerOn
              : AppLocalizations.of(context)!.speakerOff,
          isActive: _isSpeakerOn,
          onPressed: () {
            setState(() => _isSpeakerOn = !_isSpeakerOn);
            agoraController.engine.setEnableSpeakerphone(_isSpeakerOn);
          },
          theme: theme,
        ),

        // Leave button
        _buildControlButton(
          icon: Icons.call_end,
          label: AppLocalizations.of(context)!.leave,
          isActive: false,
          isDestructive: true,
          onPressed: () async {
            await classroomNotifier.leaveAgora();
            if (mounted) Navigator.pop(context);
          },
          theme: theme,
        ),
      ],
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required String label,
    required bool isActive,
    required VoidCallback onPressed,
    required ThemeData theme,
    bool isDestructive = false,
  }) {
    final bgColor = isDestructive
        ? Colors.red
        : isActive
        ? theme.primaryColor
        : Colors.grey[700];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
          color: bgColor,
          borderRadius: BorderRadius.circular(30),
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(30),
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Icon(icon, color: Colors.white, size: 28),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 11),
        ),
      ],
    );
  }

  Widget _buildJoinButton(
    ClassroomNotifier classroomNotifier,
    ThemeData theme,
  ) {
    return Center(
      child: ElevatedButton.icon(
        onPressed: () async {
          await classroomNotifier.agoraJoin(); // REMOVE the userId parameter
        },
        icon: const Icon(Icons.video_call, size: 28),
        label: Text(
          AppLocalizations.of(context)!.joinClassroom,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: theme.primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 4,
        ),
      ),
    );
  }
}
