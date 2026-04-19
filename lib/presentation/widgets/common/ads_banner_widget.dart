import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_assets.dart';
import '../../state/ads_provider.dart';
import '../../state/auth_provider.dart';
import 'banner_widget.dart';

class AdsBannerWidget extends ConsumerWidget {
  const AdsBannerWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final adsState = ref.watch(adsProvider);
    final user = ref.watch(authProvider).user;
    final roleId = user?.role_id;

    return adsState.ads.when(
      data: (ads) {
        if (ads.isEmpty) {
          return const BannerWidget(images: [AppAssets.adsBannerDefault]);
        }

        // Filter ads based on user role if platform is specified
        final filteredAds = ads.where((ad) {
          final platform = ad.platform?.toLowerCase();
          if (platform == null || platform.isEmpty || platform == 'all') {
            return true;
          }
          if (roleId == 3 && platform == 'teacher') {
            return true;
          }
          if (roleId == 4 && platform == 'student') {
            return true;
          }
          // If no role but billboard is for visitors?
          if (roleId == null && platform == 'visitor') {
            return true;
          }
          return false;
        }).toList();

        final displayAds = filteredAds.isNotEmpty ? filteredAds : ads;

        final slides = displayAds
            .map(
              (ad) => BannerSlide(
                imageUrl: ad.imageUrl,
                onTap: ad.linkUrl != null
                    ? () {
                        // TODO: Handle navigation to linkUrl if needed
                      }
                    : null,
              ),
            )
            .toList();

        return BannerWidget(slides: slides);
      },
      loading: () => const BannerWidget(images: [AppAssets.adsBannerDefault]),
      error: (error, stack) =>
          const BannerWidget(images: [AppAssets.adsBannerDefault]),
    );
  }
}
