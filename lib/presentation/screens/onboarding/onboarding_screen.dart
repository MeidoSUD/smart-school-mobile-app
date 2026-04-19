import 'package:geniuses_school/core/constants/app_assets.dart';
import 'package:geniuses_school/core/services/appsflyer_service.dart';
import 'package:geniuses_school/core/services/att_service.dart';
import 'package:geniuses_school/core/utils/logger.dart';
import 'package:geniuses_school/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  final storage = const FlutterSecureStorage();
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  List<Map<String, dynamic>> _pages = [];

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );
    _fadeController.forward();

    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page?.round() ?? 0;
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final l10n = AppLocalizations.of(context)!;
    _pages = [
      {
        "image": AppAssets.onboarding6,
        "title": l10n.onboardingTitle1,
        "description": l10n.onboardingDesc1,
        "buttonText": l10n.onboardingBtn1,
        "gradient": const [Color(0xFF5170ff), Color(0xFF7B8CFF)],
      },
      {
        "image": AppAssets.onboarding7,
        "title": l10n.onboardingTitle2,
        "description": l10n.onboardingDesc2,
        "buttonText": l10n.onboardingBtn2,
        "gradient": const [Color(0xFF5170ff), Color(0xFF6B7FFF)],
      },
      {
        "image": AppAssets.onboarding8,
        "title": l10n.onboardingTitle3,
        "description": l10n.onboardingDesc3,
        "buttonText": l10n.onboardingBtn3,
        "gradient": const [Color(0xFF5170ff), Color(0xFF5B6FEF)],
      },
    ];
  }

  @override
  void dispose() {
    _pageController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  Future<void> _completeOnboarding() async {
    await storage.write(key: 'onboarding_done', value: 'true');
    if (mounted) {
      await _initAnalytics();
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    }
  }

  Future<void> _initAnalytics() async {
    try {
      // Request App Tracking Transparency authorization
      await ATTService.requestTrackingAuthorization();
      
      // Initialize AppsFlyer after ATT
      await AppsflyerService().init();
      Logger.log("Analytics initialized successfully");
    } catch (e) {
      Logger.log("Analytics initialization error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = 1.sw >= 600;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white,
              _pages.isNotEmpty
                  ? _pages[_currentPage]["gradient"][1].withOpacity(0.1)
                  : Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Logo Header
              _buildLogoHeader(context, isTablet),

              // Page Content
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _pages.length,
                  onPageChanged: (index) {
                    _fadeController.reset();
                    _fadeController.forward();
                  },
                  itemBuilder: (context, index) {
                    return FadeTransition(
                      opacity: _fadeAnimation,
                      child: _buildPageContent(
                        context,
                        _pages[index],
                        isTablet,
                      ),
                    );
                  },
                ),
              ),

              // Page Indicator
              _buildPageIndicator(context),

              const SizedBox(height: 20),

              // Bottom Navigation
              _buildBottomNavigation(context, isTablet, l10n),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogoHeader(BuildContext context, bool isTablet) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF5170ff).withOpacity(0.2),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Image.asset(
              AppAssets.logoArabic,
              height: 50.h,
              width: 100.w,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageContent(
    BuildContext context,
    Map<String, dynamic> page,
    bool isTablet,
  ) {
    return Container(
      constraints: BoxConstraints(maxWidth: isTablet ? 600 : double.infinity),
      margin: isTablet
          ? EdgeInsets.symmetric(horizontal: 32.w)
          : EdgeInsets.zero,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Illustration
          Container(
            height: MediaQuery.of(context).size.height * 0.35,
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Hero(
              tag: page["image"],
              child: Image.asset(page["image"], fit: BoxFit.contain),
            ),
          ),

          const SizedBox(height: 40),

          // Content Card
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              children: [
                // Title with gradient
                ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: page["gradient"],
                  ).createShader(bounds),
                  child: Text(
                    page["title"],
                    style: TextStyle(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                const SizedBox(height: 16),

                // Description
                Text(
                  page["description"],
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.grey.shade700,
                    height: 1.6,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageIndicator(BuildContext context) {
    return AnimatedSmoothIndicator(
      activeIndex: _currentPage,
      count: _pages.length,
      effect: ExpandingDotsEffect(
        activeDotColor: const Color(0xFF5170ff),
        dotColor: const Color(0xFF5170ff).withOpacity(0.2),
        dotHeight: 12,
        dotWidth: 12,
        expansionFactor: 4,
        spacing: 8,
      ),
    );
  }

  Widget _buildBottomNavigation(
    BuildContext context,
    bool isTablet,
    AppLocalizations l10n,
  ) {
    final isLastPage = _currentPage == _pages.length - 1;

    return Container(
      constraints: BoxConstraints(maxWidth: isTablet ? 600 : double.infinity),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Skip Button
          if (!isLastPage)
            TextButton(
              onPressed: _completeOnboarding,
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    l10n.skip,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.grey.shade600,
                    size: 20,
                  ),
                ],
              ),
            )
          else
            const SizedBox.shrink(),

          // Next/Start Button
          Expanded(
            flex: isLastPage ? 1 : 0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: _pages.isNotEmpty
                      ? _pages[_currentPage]["gradient"]
                      : [Colors.blue, Colors.blueAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF5170ff).withOpacity(0.4),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: () {
                  if (isLastPage) {
                    _completeOnboarding();
                  } else {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Row(
                  mainAxisSize: isLastPage
                      ? MainAxisSize.max
                      : MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _pages.isNotEmpty
                          ? _pages[_currentPage]["buttonText"]
                          : "",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        isLastPage ? Icons.check : Icons.arrow_forward,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
