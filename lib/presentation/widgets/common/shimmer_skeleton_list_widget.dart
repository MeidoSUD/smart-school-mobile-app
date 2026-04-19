import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';


// const ShimmerSkeletonList(
//   type: SkeletonType.horizontalList,
//   itemWidth: 200,
//   isCard: true,
// );

enum SkeletonType { verticalList, horizontalList, grid }

class ShimmerSkeletonList extends StatelessWidget {
  final int itemCount;
  final SkeletonType type;
  final EdgeInsetsGeometry padding;
  final double itemHeight;
  final double itemWidth;
  final bool isCard;
  final int crossAxisCount;

  const ShimmerSkeletonList({
    super.key,
    this.itemCount = 5,
    this.type = SkeletonType.verticalList,
    this.padding = const EdgeInsets.all(16),
    this.itemHeight = 100,
    this.itemWidth = double.infinity,
    this.isCard = true,
    this.crossAxisCount = 2, // used in grid mode
  });

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case SkeletonType.grid:
        return _buildGridSkeleton();
      case SkeletonType.horizontalList:
        return _buildHorizontalSkeleton();
      default:
        return _buildVerticalSkeleton();
    }
  }

  // 🟢 Vertical List Skeleton
  Widget _buildVerticalSkeleton() {
    return ListView.builder(
      padding: padding,
      itemCount: itemCount,
      itemBuilder: (_, __) => _shimmerWrapper(
        child: isCard
            ? Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: _listItemSkeleton(),
                ),
              )
            : _listItemSkeleton(),
      ),
    );
  }

  // 🔵 Horizontal List Skeleton
  Widget _buildHorizontalSkeleton() {
    return SizedBox(
      height: itemHeight + 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: padding,
        itemCount: itemCount,
        itemBuilder: (_, __) => Padding(
          padding: const EdgeInsets.only(right: 12),
          child: SizedBox(
            width: itemWidth,
            child: _shimmerWrapper(
              child: isCard
                  ? Card(child: _listItemSkeleton())
                  : _listItemSkeleton(),
            ),
          ),
        ),
      ),
    );
  }

  // 🟣 Grid Skeleton (e.g., products or courses)
  Widget _buildGridSkeleton() {
    return GridView.builder(
      padding: padding,
      itemCount: itemCount,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.8,
      ),
      itemBuilder: (_, __) => _shimmerWrapper(
        child: isCard
            ? Card(
                clipBehavior: Clip.antiAlias,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: itemHeight * 0.6,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(height: 12, width: 80, color: Colors.white),
                          const SizedBox(height: 6),
                          Container(height: 10, width: 60, color: Colors.white),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : Container(
                height: itemHeight,
                width: itemWidth,
                color: Colors.white,
              ),
      ),
    );
  }

  // 🧱 Common shimmer wrapper
  Widget _shimmerWrapper({required Widget child}) {
    return Shimmer(
      duration: const Duration(seconds: 2),
      color: Colors.grey.shade300,
      colorOpacity: 0.3,
      enabled: true,
      direction: const ShimmerDirection.fromLTRB(),
      child: child,
    );
  }

  // 🔸 Common list item skeleton design
  Widget _listItemSkeleton() {
    return Row(
      children: [
        Container(width: 50, height: 50, color: Colors.white),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(height: 12, width: 100, color: Colors.white),
              const SizedBox(height: 8),
              Container(height: 10, width: 150, color: Colors.white),
            ],
          ),
        ),
      ],
    );
  }
}
