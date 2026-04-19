import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

// ── Slide model ───────────────────────────────────────────────────────────────

/// A single banner slide.
/// Supply either [imageUrl] (network) or [imageAsset] (local asset).
class BannerSlide {
  final String? imageUrl;
  final String? imageAsset;
  final VoidCallback? onTap;

  const BannerSlide({this.imageUrl, this.imageAsset, this.onTap})
    : assert(
        imageUrl != null || imageAsset != null,
        'Provide imageUrl or imageAsset',
      );
}

// ── Widget ────────────────────────────────────────────────────────────────────

class BannerWidget extends StatefulWidget {
  /// Legacy constructor – local asset paths (backward-compatible).
  final List<String>? images;

  /// New – typed slides with network support & tap callbacks.
  final List<BannerSlide>? slides;

  final double height;
  final Duration autoPlayInterval;

  const BannerWidget({
    super.key,
    this.images,
    this.slides,
    this.height = 200,
    this.autoPlayInterval = const Duration(seconds: 4),
  }) : assert(images != null || slides != null, 'Provide images or slides');

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  late final PageController _pageController;
  int _currentPage = 0;
  Timer? _timer;

  List<BannerSlide> get _slides {
    if (widget.slides != null) return widget.slides!;
    return widget.images!.map((path) => BannerSlide(imageAsset: path)).toList();
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _startAutoPlay();
  }

  void _startAutoPlay() {
    _stopAutoPlay();
    _timer = Timer.periodic(widget.autoPlayInterval, (timer) {
      if (_pageController.hasClients && _slides.isNotEmpty) {
        final nextPage = (_currentPage + 1) % _slides.length;
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOutCubic,
        );
      }
    });
  }

  void _stopAutoPlay() => _timer?.cancel();

  void _nextPage() {
    if (_slides.isEmpty) return;
    _pageController.animateToPage(
      (_currentPage + 1) % _slides.length,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutQuint,
    );
  }

  void _previousPage() {
    if (_slides.isEmpty) return;
    _pageController.animateToPage(
      (_currentPage - 1 + _slides.length) % _slides.length,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutQuint,
    );
  }

  @override
  void dispose() {
    _stopAutoPlay();
    _pageController.dispose();
    super.dispose();
  }

  Widget _buildSlideImage(BannerSlide slide) {
    if (slide.imageUrl != null && slide.imageUrl!.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: slide.imageUrl!,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          color: Colors.grey.shade200,
          child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
        ),
        errorWidget: (context, url, error) => Container(
          color: Colors.grey.shade200,
          child: const Icon(Icons.broken_image, size: 40),
        ),
      );
    }
    return Image.asset(
      slide.imageAsset!,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => Container(
        color: Colors.grey.shade200,
        child: const Icon(Icons.broken_image, size: 40),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final slides = _slides;
    if (slides.isEmpty) return const SizedBox.shrink();
    final theme = Theme.of(context);

    return Column(
      children: [
        Container(
          height: widget.height,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: theme.primaryColor.withOpacity(0.15),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() => _currentPage = index);
                    },
                    itemCount: slides.length,
                    itemBuilder: (context, index) {
                      final slide = slides[index];
                      return GestureDetector(
                        onTap: slide.onTap,
                        child: _buildSlideImage(slide),
                      );
                    },
                  ),
                ),
              ),
              Positioned.fill(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _ArrowButton(
                      icon: Icons.chevron_left_rounded,
                      onTap: () {
                        _previousPage();
                        _startAutoPlay();
                      },
                    ),
                    _ArrowButton(
                      icon: Icons.chevron_right_rounded,
                      onTap: () {
                        _nextPage();
                        _startAutoPlay();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(slides.length, (index) {
            final isActive = _currentPage == index;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              height: 6,
              width: isActive ? 24 : 8,
              decoration: BoxDecoration(
                color: isActive
                    ? theme.primaryColor
                    : theme.primaryColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
            );
          }),
        ),
      ],
    );
  }
}

class _ArrowButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _ArrowButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.4),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.black87, size: 28),
        onPressed: onTap,
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
      ),
    );
  }
}
