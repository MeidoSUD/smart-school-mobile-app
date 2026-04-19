import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class CourseCategoryShimmerWidget extends StatelessWidget {
  final double width;
  final double height;

  const CourseCategoryShimmerWidget({
    super.key,
    this.width = 100,
    this.height = 80,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Shimmer(
        duration: const Duration(seconds: 2),
        interval: const Duration(milliseconds: 500),
        color: Colors.grey.shade300,
        colorOpacity: 0.3,
        enabled: true,
        direction: const ShimmerDirection.fromLTRB(),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                theme.primaryColorDark.withOpacity(0.3),
                theme.primaryColor.withOpacity(0.3),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}

