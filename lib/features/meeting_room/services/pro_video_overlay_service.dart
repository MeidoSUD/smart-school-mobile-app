import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/pro_agora_controller.dart';
import '../data/models/meeting_room_model.dart';
import '../ui/pro_meeting_room_screen.dart';

class ProVideoOverlayService {
  static final ProVideoOverlayService _instance =
      ProVideoOverlayService._internal();
  factory ProVideoOverlayService() => _instance;
  ProVideoOverlayService._internal();

  OverlayEntry? _overlayEntry;

  void showMiniPlayer(BuildContext context, MeetingRoomData? data) {
    if (_overlayEntry != null) return; // Already showing

    final overlayState = Overlay.of(context);
    _overlayEntry = OverlayEntry(
      builder: (context) => _MiniPlayerWidget(
        onMaximize: () {
          hideMiniPlayer();
          if (data != null) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ProMeetingRoomScreen(data: data),
              ),
            );
          }
        },
        onClose: () {
          hideMiniPlayer();
          // Also need to stop the engine nicely via provider if possible
          // But since we are outside the widget tree that holds the ref easily,
          // usually the mini player handles the "End Call" button which calls the provider.
        },
      ),
    );

    overlayState.insert(_overlayEntry!);
  }

  void hideMiniPlayer() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  bool get isOverlayShown => _overlayEntry != null;
}

class _MiniPlayerWidget extends ConsumerStatefulWidget {
  final VoidCallback onMaximize;
  final VoidCallback onClose;

  const _MiniPlayerWidget({required this.onMaximize, required this.onClose});

  @override
  ConsumerState<_MiniPlayerWidget> createState() => _MiniPlayerWidgetState();
}

class _MiniPlayerWidgetState extends ConsumerState<_MiniPlayerWidget> {
  Offset position = const Offset(20, 100);

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(proAgoraProvider);
    final notifier = ref.read(proAgoraProvider.notifier);

    // If call ended (engine null or not init), close overlay
    if (!state.initialized || state.engine == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.onClose();
      });
      return const SizedBox.shrink();
    }

    return Positioned(
      left: position.dx,
      top: position.dy,
      child: Draggable(
        feedback: Material(
          color: Colors.transparent,
          child: _buildContent(state, notifier, opacity: 0.7),
        ),
        childWhenDragging: Container(), // Hide original when dragging
        onDraggableCanceled: (velocity, offset) {
          setState(() {
            position = offset;
          });
        },
        child: Material(
          color: Colors.transparent,
          child: _buildContent(state, notifier),
        ),
      ),
    );
  }

  Widget _buildContent(
    ProAgoraState state,
    ProAgoraNotifier notifier, {
    double opacity = 1.0,
  }) {
    // Logic: Show Remote User (Focused) if available, else Local
    final remoteUid =
        state.pinnedUid ??
        (state.remoteUids.isNotEmpty ? state.remoteUids.first : null);

    // If no remote users, show local
    final targetUid = remoteUid ?? 0;

    return Opacity(
      opacity: opacity,
      child: Container(
        width: 120,
        height: 160,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 10),
          ],
          border: Border.all(color: Colors.white24),
        ),
        child: Stack(
          children: [
            // Video
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: targetUid == 0
                  ? (state.isVideoOff && !state.isScreenSharing
                        ? const Center(
                            child: Icon(
                              Icons.videocam_off,
                              color: Colors.white,
                            ),
                          )
                        : AgoraVideoView(
                            key: ValueKey(state.isScreenSharing),
                            controller: VideoViewController(
                              rtcEngine: state.engine!,
                              canvas: VideoCanvas(
                                uid: 0,
                                sourceType: state.isScreenSharing
                                    ? VideoSourceType.videoSourceScreen
                                    : VideoSourceType.videoSourceCamera,
                              ),
                            ),
                          ))
                  : AgoraVideoView(
                      controller: VideoViewController.remote(
                        rtcEngine: state.engine!,
                        canvas: VideoCanvas(uid: targetUid),
                        connection: RtcConnection(
                          channelId: state.channelName ?? '',
                        ),
                      ),
                    ),
            ),

            // Tap to Maximize
            Positioned.fill(
              child: GestureDetector(
                onTap: widget.onMaximize,
                onDoubleTap: widget.onMaximize,
              ),
            ),

            // Controls (Mute / Video)
            Positioned(
              bottom: 8,
              left: 4,
              right: 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Mute
                  GestureDetector(
                    onTap: () => notifier.toggleMute(),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: state.isMuted ? Colors.red : Colors.black54,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        state.isMuted ? Icons.mic_off : Icons.mic,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),

                  // Video
                  GestureDetector(
                    onTap: () => notifier.toggleVideo(),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: state.isVideoOff ? Colors.red : Colors.black54,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        state.isVideoOff ? Icons.videocam_off : Icons.videocam,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),

                  // Share (Host Only)
                  if (state.userRole == 'host')
                    GestureDetector(
                      onTap: () => notifier.toggleScreenShare(),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: state.isScreenSharing
                              ? Colors.red
                              : Colors.black54,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          state.isScreenSharing
                              ? Icons.stop_screen_share
                              : Icons.screen_share,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // Close Button (Small X)
            Positioned(
              top: 4,
              right: 4,
              child: GestureDetector(
                onTap: () {
                  notifier.leaveChannel();
                  widget.onClose();
                },
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.close, color: Colors.white, size: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
