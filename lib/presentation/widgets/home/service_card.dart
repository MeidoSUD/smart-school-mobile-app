import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ServiceCard extends StatelessWidget {
  final String title;
  final String description;

  /// Network image URL returned from the API.
  /// Falls back to [iconAsset] when null or empty.
  final String? iconUrl;

  /// Local asset path used as a fallback when [iconUrl] is unavailable.
  final String? iconAsset;

  final VoidCallback onTap;

  const ServiceCard({
    super.key,
    required this.title,
    required this.description,
    this.iconUrl,
    this.iconAsset,
    required this.onTap,
  }) : assert(
         iconUrl != null || iconAsset != null,
         'Provide either iconUrl or iconAsset',
       );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final boxHeight = constraints.maxHeight;
        // Make icon size proportional to the card height (e.g., 35%)
        final iconSize = boxHeight * 0.35;

        return InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16.r),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 10.r,
                  offset: Offset(0, 4.h),
                ),
              ],
            ),
            padding: EdgeInsets.all(12.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon
                Container(
                  height: iconSize,
                  width: iconSize,
                  padding: EdgeInsets.all(iconSize * 0.2),
                  decoration: BoxDecoration(
                    color: theme.primaryColor.withOpacity(0.06),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: _buildIcon(iconSize),
                ),
                SizedBox(height: boxHeight * 0.06), // ~6% spacing
                // Title
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 1.sw > 600 ? 10.sp : 12.sp,
                    height: 1.2,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                SizedBox(height: boxHeight * 0.02), // ~2% spacing
                // Description
                Expanded(
                  child: Text(
                    description,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.grey[600],
                      fontSize: 1.sw > 600 ? 8.sp : 10.sp,
                      height: 1.2,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildIcon(double iconSize) {
    if (iconUrl != null && iconUrl!.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: iconUrl!,
        fit: BoxFit.contain,
        placeholder: (context, url) => Center(
          child: SizedBox(
            width: iconSize * 0.3,
            height: iconSize * 0.3,
            child: const CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
        errorWidget: (context, url, error) => _fallbackIcon(),
      );
    }
    return _fallbackIcon();
  }

  Widget _fallbackIcon() {
    if (iconAsset != null && iconAsset!.isNotEmpty) {
      return Image.asset(iconAsset!, fit: BoxFit.contain);
    }
    return const Icon(Icons.miscellaneous_services_outlined, size: 28);
  }
}
