import 'package:geniuses_school/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controllers/pro_agora_controller.dart';

class ProCallControlsWidget extends ConsumerWidget {
  const ProCallControlsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(proAgoraProvider);
    final notifier = ref.read(proAgoraProvider.notifier);

    return Container(
      margin: const EdgeInsets.only(bottom: 24, left: 16, right: 16),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6), // Glassmorphism base
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: Colors.white12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // 1. Mute
            _ProControlButton(
              icon: state.isMuted ? Icons.mic_off : Icons.mic,
              label: AppLocalizations.of(context)!.mute,
              isActive: !state.isMuted,
              activeColor: Colors.white,
              inactiveColor: Colors.redAccent,
              onPressed: () => notifier.toggleMute(),
            ),

            const SizedBox(width: 4),

            // 2. Video
            _ProControlButton(
              icon: state.isVideoOff ? Icons.videocam_off : Icons.videocam,
              label: AppLocalizations.of(context)!.video,
              isActive: !state.isVideoOff,
              activeColor: Colors.white,
              inactiveColor: Colors.redAccent,
              onPressed: () => notifier.toggleVideo(),
            ),

            const SizedBox(width: 4),

            // 2.5 Raise Hand (Students Only)
            if (state.userRole != 'host')
              _ProControlButton(
                icon: state.raisedHandUids.contains(0)
                    ? Icons.back_hand
                    : Icons.back_hand_outlined,
                label: AppLocalizations.of(context)!.hand,
                isActive: state.raisedHandUids.contains(0),
                activeColor: Colors.amber, // Gold color for hand
                inactiveColor: Colors.white,
                onPressed: () => notifier.toggleHandRaise(),
              ),

            if (state.userRole != 'host') const SizedBox(width: 4),

            // 3. Screen Share (Host Only)
            if (state.userRole == 'host')
              Padding(
                padding: const EdgeInsets.only(right: 4),
                child: _ProControlButton(
                  icon: state.isScreenSharing
                      ? Icons.stop_screen_share
                      : Icons.screen_share,
                  label: AppLocalizations.of(context)!.shareScreen,
                  isActive: state.isScreenSharing,
                  activeColor: Colors.redAccent,
                  inactiveColor: Colors.white,
                  onPressed: () => notifier.toggleScreenShare(),
                ),
              ),

            // 3.5 Mute All (Host Only)
            if (state.userRole == 'host')
              Padding(
                padding: const EdgeInsets.only(right: 4),
                child: _ProControlButton(
                  icon:
                      state.mutedRemoteUids.isNotEmpty &&
                          state.mutedRemoteUids.length ==
                              state.remoteUids.length
                      ? Icons.mic_off
                      : Icons.mic_off_outlined,
                  label: AppLocalizations.of(context)!.muteAll,
                  isActive:
                      state.mutedRemoteUids.isNotEmpty &&
                      state.mutedRemoteUids.length == state.remoteUids.length,
                  activeColor: Colors.redAccent,
                  inactiveColor: Colors.white,
                  onPressed: () => notifier.toggleMuteAllRemote(),
                ),
              ),
            const SizedBox(width: 4),
            // 4. Switch Camera
            _ProControlButton(
              icon: Icons.flip_camera_ios,
              label: AppLocalizations.of(context)!.flipCamera,
              isActive: true,
              activeColor: Colors.white,
              inactiveColor: Colors.white,
              onPressed: () => notifier.switchCamera(),
            ),

            const SizedBox(width: 12),

            // 5. End Call (Big Red Button)
            Container(
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.redAccent,
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: IconButton(
                icon: const Icon(Icons.call_end, color: Colors.white),
                iconSize: 28, // Slightly smaller
                padding: const EdgeInsets.all(12),
                onPressed: () {
                  notifier.leaveChannel();
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProControlButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final Color activeColor;
  final Color inactiveColor;
  final VoidCallback onPressed;

  const _ProControlButton({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.activeColor,
    required this.inactiveColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final color = isActive ? activeColor : inactiveColor;
    final bgColor = isActive
        ? Colors.white.withOpacity(0.1)
        : Colors.white.withOpacity(0.05);

    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(12), // Slightly smaller radius
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 8,
        ), // Compacter padding
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 22), // Smaller icon
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(color: color, fontSize: 9),
            ), // Smaller text
          ],
        ),
      ),
    );
  }
}
