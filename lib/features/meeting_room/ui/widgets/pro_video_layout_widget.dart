import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controllers/pro_agora_controller.dart';

class ProVideoLayoutWidget extends ConsumerWidget {
  const ProVideoLayoutWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(proAgoraProvider);
    final notifier = ref.read(proAgoraProvider.notifier);
    final engine = state.engine;

    if (!state.initialized || engine == null) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: Colors.white),
            SizedBox(height: 16),
            Text(
              "Initializing Engine...",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      );
    }

    final localUid = 0; // Agora constant for local user
    final remoteUids = state.remoteUids;
    final allUsers = [if (state.initialized) localUid, ...remoteUids];

    if (allUsers.isEmpty) {
      return const Center(
        child: Text(
          "Waiting for others...",
          style: TextStyle(color: Colors.white54),
        ),
      );
    }

    // Determine Layout Mode
    // 1. Pinned User exists -> Focus Mode
    // 2. Only 1 remote user -> Focus Mode (1-on-1 default)
    // 3. Otherwise -> Grid Mode

    int? focusedUid;
    if (state.pinnedUid != null) {
      focusedUid = state.pinnedUid;
    } else if (remoteUids.length == 1) {
      focusedUid = remoteUids.first;
    }

    if (focusedUid != null) {
      return _buildFocusLayout(context, engine, state, focusedUid, notifier);
    } else {
      return _buildGridLayout(context, engine, state, allUsers, notifier);
    }
  }

  Widget _buildGridLayout(
    BuildContext context,
    RtcEngine engine,
    ProAgoraState state,
    List<int> allUsers,
    ProAgoraNotifier notifier,
  ) {
    return GridView.builder(
      padding: const EdgeInsets.all(4),
      itemCount: allUsers.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8, // Slightly taller for portrait video
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
      ),
      itemBuilder: (context, index) {
        final uid = allUsers[index];
        return _buildVideoTile(context, engine, state, uid, notifier);
      },
    );
  }

  Widget _buildFocusLayout(
    BuildContext context,
    RtcEngine engine,
    ProAgoraState state,
    int focusedUid,
    ProAgoraNotifier notifier,
  ) {
    // 0 is always local
    // If focusedUid is local (0), it means I pinned myself? (Rare, but possible)

    return Stack(
      children: [
        // 1. Full Screen Background Layer (Focused User)
        Positioned.fill(
          child: _buildVideoTile(
            context,
            engine,
            state,
            focusedUid,
            notifier,
            isFocused: true,
          ),
        ),

        // 1.5 Gradient Overlay for Controls Visibility
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          height: 200,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Colors.black.withOpacity(0.8), Colors.transparent],
              ),
            ),
          ),
        ),

        // 2. Floating PIP (Local User)
        if (focusedUid != 0) _DraggableLocalPip(engine: engine, state: state),

        // 3. Remote Participants Strip
        if (state.remoteUids.length > 1)
          Positioned(
            bottom: 110, // Above controls
            left: 0,
            right: 0,
            height: 100,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: state.remoteUids.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final uid = state.remoteUids[index];
                if (uid == focusedUid)
                  return const SizedBox.shrink(); // Skip pinned

                return GestureDetector(
                  onTap: () => notifier.togglePin(uid),
                  child: Container(
                    width: 80,
                    height: 100,
                    decoration: BoxDecoration(
                      border: state.pinnedUid == uid
                          ? Border.all(color: Colors.blueAccent, width: 2)
                          : Border.all(color: Colors.white24, width: 1),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(11),
                      child: AgoraVideoView(
                        controller: VideoViewController.remote(
                          rtcEngine: engine,
                          canvas: VideoCanvas(uid: uid),
                          connection: RtcConnection(
                            channelId: state.channelName ?? '',
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }

  Widget _buildVideoTile(
    BuildContext context,
    RtcEngine engine,
    ProAgoraState state,
    int uid,
    ProAgoraNotifier notifier, {
    bool isFocused = false,
    bool isSmall = false,
  }) {
    final isLocal = (uid == 0);
    final isMuted = isLocal
        ? state.isMuted
        : state.mutedRemoteUids.contains(uid);
    final isPinned = (state.pinnedUid == uid);

    return Container(
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(isFocused ? 0 : 12),
        border: isPinned
            ? Border.all(color: Colors.blueAccent, width: 2)
            : null,
        boxShadow: isSmall
            ? [const BoxShadow(color: Colors.black45, blurRadius: 4)]
            : null,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(isFocused ? 0 : 12),
        child: Stack(
          children: [
            // Video View
            if (isLocal)
              if (state.isVideoOff && !state.isScreenSharing)
                const Center(
                  child: Icon(
                    Icons.videocam_off,
                    color: Colors.white54,
                    size: 48,
                  ),
                )
              else
                AgoraVideoView(
                  key: ValueKey(
                    state.isScreenSharing,
                  ), // Force rebuild when switching source
                  controller: VideoViewController(
                    rtcEngine: engine,
                    canvas: VideoCanvas(
                      uid: 0,
                      sourceType: state.isScreenSharing
                          ? VideoSourceType.videoSourceScreen
                          : VideoSourceType.videoSourceCamera,
                    ),
                  ),
                )
            else
              AgoraVideoView(
                controller: VideoViewController.remote(
                  rtcEngine: engine,
                  canvas: VideoCanvas(uid: uid),
                  connection: RtcConnection(channelId: state.channelName ?? ''),
                ),
              ),

            // Overlays (Name, Icons)
            Positioned(
              bottom: 8,
              left: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  spacing: 5,
                  children: [
                    if (isMuted)
                      const Padding(
                        padding: EdgeInsets.only(right: 0.0),
                        child: Icon(Icons.mic_off, color: Colors.red, size: 14),
                      ),
                    Text(
                      isLocal ? "Me" : "User $uid",
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),

            // Raised Hand Overlay (Top Right)
            if (state.raisedHandUids.contains(uid))
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: Colors.amber,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.back_hand,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
              ),

            // Interaction overlay (Tap to Pin/Menu)
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    // Simple tap to pin/unpin for now
                    notifier.togglePin(uid);
                  },
                  onLongPress: () {
                    // Show options (Remote Mute)
                    if (!isLocal)
                      _showUserOptions(context, uid, notifier, state);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showUserOptions(
    BuildContext context,
    int uid,
    ProAgoraNotifier notifier,
    ProAgoraState state,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1E1E1E),
      builder: (_) {
        final isRemoteMuted = state.mutedRemoteUids.contains(uid);
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(
                  isRemoteMuted ? Icons.volume_up : Icons.volume_off,
                  color: Colors.white,
                ),
                title: Text(
                  isRemoteMuted ? 'Unmute Audio' : 'Mute Audio',
                  style: const TextStyle(color: Colors.white),
                ),
                onTap: () {
                  notifier.toggleRemoteAudio(uid);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.push_pin, color: Colors.white),
                title: const Text(
                  'Pin/Unpin User',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  notifier.togglePin(uid);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class _DraggableLocalPip extends StatefulWidget {
  final RtcEngine engine;
  final ProAgoraState state;

  const _DraggableLocalPip({required this.engine, required this.state});

  @override
  State<_DraggableLocalPip> createState() => _DraggableLocalPipState();
}

class _DraggableLocalPipState extends State<_DraggableLocalPip> {
  Offset position = const Offset(20, 50); // Default top-left

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: Draggable(
        feedback: _buildPipContent(opacity: 0.7),
        childWhenDragging: Container(),
        onDraggableCanceled: (velocity, offset) {
          setState(() {
            // Constrain within screen bounds could be added here
            position = offset;
          });
        },
        child: _buildPipContent(),
      ),
    );
  }

  Widget _buildPipContent({double opacity = 1.0}) {
    return Opacity(
      opacity: opacity,
      child: Container(
        width: 110,
        height: 160,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.2), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: widget.state.isVideoOff
              ? const Center(
                  child: Icon(Icons.videocam_off, color: Colors.white54),
                )
              : AgoraVideoView(
                  key: ValueKey(widget.state.isScreenSharing),
                  controller: VideoViewController(
                    rtcEngine: widget.engine,
                    canvas: VideoCanvas(
                      uid: 0,
                      sourceType: widget.state.isScreenSharing
                          ? VideoSourceType.videoSourceScreen
                          : VideoSourceType.videoSourceCamera,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
