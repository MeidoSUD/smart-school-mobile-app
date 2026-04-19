import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/agora_controller.dart';
import '../data/models/meeting_room_model.dart';
import 'widgets/call_controls_widget.dart';
import 'widgets/video_grid_widget.dart';

class MeetingRoomScreen extends ConsumerStatefulWidget {
  final MeetingRoomData data;

  const MeetingRoomScreen({super.key, required this.data});

  @override
  ConsumerState<MeetingRoomScreen> createState() => _MeetingRoomScreenState();
}

class _MeetingRoomScreenState extends ConsumerState<MeetingRoomScreen> {
  @override
  void initState() {
    super.initState();
    // Initialize Agora Engine with the passed data
    // We use postFrameCallback to ensure provider is ready if needed,
    // but usually read in initState is safe for methods.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(agoraProvider.notifier).initialize(widget.data);
    });
  }

  bool _canPop = false;

  void _handleExit() async {
    // Perform cleanup
    ref.read(agoraProvider.notifier).leaveChannel();
    if (mounted) {
      setState(() {
        _canPop = true;
      });
      // Delay pop to ensure state updates
      Future.microtask(() => Navigator.of(context).pop());
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _canPop,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _handleExit();
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Stack(
            children: [
              // Video Grid
              const Positioned.fill(child: VideoGridWidget()),

              // Controls
              const Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: CallControlsWidget(),
              ),

              // Back Button (Top Left)
              // Positioned(
              //   top: 16,
              //   left: 16,
              //   child: IconButton(
              //     icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              //     onPressed: () {
              //       // Trigger the PopScope
              //       Navigator.of(context).maybePop();
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
