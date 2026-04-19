import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../l10n/app_localizations.dart';
import '../../controllers/agora_controller.dart';

class VideoGridWidget extends ConsumerWidget {
  const VideoGridWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final agoraState = ref.watch(agoraProvider);
    final engine = ref.read(agoraProvider.notifier).engine;

    if (!agoraState.initialized || engine == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final localUserJoined = agoraState.localUserJoined;
    final remoteUids = agoraState.remoteUids;

    // Layout: Single view if 1 user, Grid if more.
    // For simplicity, let's put Local user as a small floating box if there are remote users,
    // or fill screen if alone.
    // Actually, usually in meeting apps:
    // 0 remote -> Local Full Screen
    // 1 remote -> Remote Full Screen + Local Small Box
    // 2+ -> Grid

    // Let's implement a simple Grid for now as requested "Clean Screen".
    // Or a classic helper method.

    final allUsers = [
      if (localUserJoined) 0, // 0 is local for AgoraVideoView
      ...remoteUids,
    ];

    if (allUsers.isEmpty) {
      return Center(
        child: Text(AppLocalizations.of(context)!.waitingForConnection),
      );
    }

    return GridView.builder(
      itemCount: allUsers.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.0,
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 4.0,
      ),
      itemBuilder: (context, index) {
        final uid = allUsers[index];
        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white24),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: uid == 0
                ? AgoraVideoView(
                    controller: VideoViewController(
                      rtcEngine: engine,
                      canvas: VideoCanvas(
                        uid: 0,
                        sourceType: agoraState.isScreenSharing
                            ? VideoSourceType.videoSourceScreen
                            : VideoSourceType.videoSourceCamera,
                      ),
                    ),
                  )
                : AgoraVideoView(
                    controller: VideoViewController.remote(
                      rtcEngine: engine,
                      canvas: VideoCanvas(uid: uid),
                      connection: RtcConnection(
                        channelId: agoraState.channelName ?? '',
                        // The engine handles connection, but `VideoViewController.remote` implementation
                        // might defaults to current connection if we don't specify, OR we need the channel ID.
                        // The API docs say `connection` is mandatory for remote.
                        // Issue: We stored 'channel' in the controller but not easily accessible here without passing it?
                        // Let's add `channelId` to AgoraState or pass it through.
                        // Ideally, AgoraState should hold the current channel Name.
                      ),
                    ),
                  ),
          ),
        );
      },
    );
  }
}
