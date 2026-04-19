import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/pro_agora_controller.dart';
import '../data/models/meeting_room_model.dart';
import '../services/pro_video_overlay_service.dart';
import 'widgets/pro_call_controls_widget.dart';
import 'widgets/pro_video_layout_widget.dart';

class ProMeetingRoomScreen extends ConsumerStatefulWidget {
  final MeetingRoomData data;

  const ProMeetingRoomScreen({super.key, required this.data});

  @override
  ConsumerState<ProMeetingRoomScreen> createState() =>
      _ProMeetingRoomScreenState();
}

class _ProMeetingRoomScreenState extends ConsumerState<ProMeetingRoomScreen> {
  @override
  void initState() {
    super.initState();
    // Initialize Pro Agora Controller
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(proAgoraProvider.notifier).initialize(widget.data);
    });
  }

  final bool _canPop = false;

  @override
  Widget build(BuildContext context) {
    // Listen for errors
    ref.listen(proAgoraProvider, (previous, next) {
      if (next.lastError != null && next.lastError != previous?.lastError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.lastError!), backgroundColor: Colors.red),
        );
      }
    });

    return PopScope(
      canPop: _canPop,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;

        // If user presses back: Minimize to PIP
        // 1. Show Overlay
        ProVideoOverlayService().showMiniPlayer(context, widget.data);

        // 2. Pop this screen
        if (context.mounted) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF111111), // Dark BG
        body: SafeArea(
          child: Stack(
            children: [
              // 1. Video Layout (Main Content)
              const Positioned.fill(child: ProVideoLayoutWidget()),

              // 2. Top Bar (Back Button + Channel Info)
              Positioned(
                top: 16,
                left: 16,
                right: 16,
                child: Row(
                  children: [
                    // Minimize / Back Button
                    CircleAvatar(
                      backgroundColor: Colors.black45,
                      child: IconButton(
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          // Minimise button also triggers PIP
                          ProVideoOverlayService().showMiniPlayer(
                            context,
                            widget.data,
                          );
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Channel Info Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black45,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.videocam,
                            color: Colors.greenAccent,
                            size: 16,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            widget.data.agora?.channel ?? "Meeting Room",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // 3. Bottom Controls
              const Align(
                alignment: Alignment.bottomCenter,
                child: ProCallControlsWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
