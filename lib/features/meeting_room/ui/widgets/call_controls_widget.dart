import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controllers/agora_controller.dart';

class CallControlsWidget extends ConsumerWidget {
  const CallControlsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final agoraState = ref.watch(agoraProvider);
    final notifier = ref.read(agoraProvider.notifier);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      color: Colors.black45,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Mute Toggle
          _ControlButton(
            icon: agoraState.isMuted ? Icons.mic_off : Icons.mic,
            color: agoraState.isMuted ? Colors.red : Colors.white,
            onPressed: () => notifier.toggleMute(),
          ),

          // Video Toggle
          _ControlButton(
            icon: agoraState.isVideoOff ? Icons.videocam_off : Icons.videocam,
            color: agoraState.isVideoOff ? Colors.red : Colors.white,
            onPressed: () => notifier.toggleVideo(),
          ),

          // Switch Camera
          _ControlButton(
            icon: Icons.cameraswitch,
            color: Colors.white,
            onPressed: () => notifier.switchCamera(),
          ),

          // Screen Share (Host Only)
          if (agoraState.userRole == 'host')
            _ControlButton(
              icon: agoraState.isScreenSharing
                  ? Icons.stop_screen_share
                  : Icons.screen_share,
              color: agoraState.isScreenSharing ? Colors.red : Colors.white,
              onPressed: () => notifier.toggleScreenShare(),
            ),

          // End Call
          _ControlButton(
            icon: Icons.call_end,
            color: Colors.red,
            isCircle: true,
            onPressed: () {
              notifier.leaveChannel();
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}

class _ControlButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;
  final bool isCircle;

  const _ControlButton({
    required this.icon,
    required this.color,
    required this.onPressed,
    this.isCircle = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isCircle) {
      return Container(
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        child: IconButton(
          onPressed: onPressed,
          icon: Icon(icon, color: Colors.white),
          iconSize: 32,
        ),
      );
    }
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon, color: color),
      iconSize: 32,
    );
  }
}
