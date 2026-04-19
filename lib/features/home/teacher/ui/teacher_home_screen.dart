import 'package:geniuses_school/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/services/tutorial_service.dart';
import '../../../../presentation/state/auth_provider.dart';
import '../../../../presentation/widgets/common/ads_banner_widget.dart';
import 'widgets/dashboard_card.dart';
import 'widgets/management_card.dart';
import 'widgets/orders_section.dart';

class TeacherHomeScreen extends ConsumerStatefulWidget {
  final GlobalKey helpKey;
  final GlobalKey notificationsKey;
  const TeacherHomeScreen({
    super.key,
    required this.helpKey,
    required this.notificationsKey,
  });

  @override
  ConsumerState<TeacherHomeScreen> createState() => TeacherHomeScreenState();
}

class TeacherHomeScreenState extends ConsumerState<TeacherHomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _pulseAnimation;
  late Animation<double> _fadeAnimation;
  final GlobalKey _overviewTitleKey = GlobalKey();
  final GlobalKey _serviceTitleKey = GlobalKey();
  final GlobalKey _ordersTitleKey = GlobalKey();
  final GlobalKey _accountStatusKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.08,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _fadeAnimation = Tween<double>(
      begin: 0.6,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAndShowTutorial();
    });
  }

  Future<void> _checkAndShowTutorial() async {
    if (await TutorialService.hasShownTutorial(
      TutorialService.teacherHomeTutorialId,
    )) {
      return;
    }
    if (!mounted) return;

    await TutorialService.startGuidedTour(
      context: context,
      tutorialId: TutorialService.teacherHomeTutorialId,
      tourSteps: [
        {
          'key': widget.helpKey,
          'title': 'مركز المساعدة',
          'description': 'اضغط هنا لإعادة عرض شرح الشاشة في أي وقت.',
        },
        {
          'key': widget.notificationsKey,
          'title': 'الإشعارات',
          'description': 'من هنا تتابع التنبيهات والطلبات الجديدة.',
        },
        {
          'key': _accountStatusKey,
          'title': 'حالة الحساب',
          'description':
              'من هنا تفعّل أو توقف ظهور ملفك للطلاب، وتتحكم في حالة حسابك.',
        },
        {
          'key': _overviewTitleKey,
          'title': 'نظرة عامة',
          'description': 'هنا يظهر ملخص الأرباح والتقييم والإحصائيات.',
        },
        {
          'key': _serviceTitleKey,
          'title': 'إدارة الخدمات',
          'description': 'من هنا تعدّل الأسعار والخدمات الخاصة بك.',
        },
        {
          'key': _ordersTitleKey,
          'title': 'الطلبات الجديدة',
          'description': 'هنا تجد أحدث الطلبات ويمكنك التقديم عليها مباشرة.',
        },
      ],
    );
  }

  Future<void> startTutorialManual(BuildContext context) async {
    await TutorialService.startGuidedTour(
      context: context,
      tutorialId: TutorialService.teacherHomeTutorialId,
      markAsShown: false,
      tourSteps: [
        {
          'key': widget.helpKey,
          'title': 'مركز المساعدة',
          'description': 'اضغط هنا لإعادة عرض شرح الشاشة في أي وقت.',
        },
        {
          'key': widget.notificationsKey,
          'title': 'الإشعارات',
          'description': 'من هنا تتابع التنبيهات والطلبات الجديدة.',
        },
        {
          'key': _accountStatusKey,
          'title': 'حالة الحساب',
          'description':
              'من هنا تفعّل أو توقف ظهور ملفك للطلاب، وتتحكم في حالة حسابك.',
        },
        {
          'key': _overviewTitleKey,
          'title': 'نظرة عامة',
          'description': 'هنا يظهر ملخص الأرباح والتقييم والإحصائيات.',
        },
        {
          'key': _serviceTitleKey,
          'title': 'إدارة الخدمات',
          'description': 'من هنا تعدّل الأسعار والخدمات الخاصة بك.',
        },
        {
          'key': _ordersTitleKey,
          'title': 'الطلبات الجديدة',
          'description': 'هنا تجد أحدث الطلبات ويمكنك التقديم عليها مباشرة.',
        },
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final user = authState.user;
    final profile = user?.profile;
    final isActive =
        (user?.is_active ?? false) || (user?.profile?.is_active ?? false);

    // Watch for "under review" status to show the dialog
    ref.listen(authProvider, (previous, next) {
      if (next.status == AuthStatus.error && next.message == 'under_review') {
        _showUnderReviewDialog();
      }
    });

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: CustomScrollView(
        slivers: [
          // Modern Minimized Status Header (Stable)
          SliverToBoxAdapter(
            child: Container(
              key: _accountStatusKey,
              margin: EdgeInsets.all(16.w),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Status Indicator Icon
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      if (isActive)
                        AnimatedBuilder(
                          animation: _pulseAnimation,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: _pulseAnimation.value,
                              child: Container(
                                width: 24.r,
                                height: 24.r,
                                decoration: BoxDecoration(
                                  color: const Color(
                                    0xFF10B981,
                                  ).withOpacity(0.2),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            );
                          },
                        ),
                      Container(
                        width: 10.r,
                        height: 10.r,
                        decoration: BoxDecoration(
                          color: isActive
                              ? const Color(0xFF10B981)
                              : Colors.grey[400],
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 12.w),
                  // Status Text
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isActive
                              ? (AppLocalizations.of(
                                      context,
                                    )?.profile_status_active ??
                                    'Active')
                              : (AppLocalizations.of(
                                      context,
                                    )?.profile_status_inactive ??
                                    'Inactive'),
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: isActive
                                ? const Color(0xFF10B981)
                                : Colors.grey[700],
                          ),
                        ),
                        Text(
                          isActive
                              ? (AppLocalizations.of(
                                      context,
                                    )?.profile_visible_to_students ??
                                    'Visible to students')
                              : (AppLocalizations.of(
                                      context,
                                    )?.profile_hidden_from_students ??
                                    'Hidden from students'),
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: Colors.grey[500],
                            height: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Modern Switch
                  Transform.scale(
                    scale: 0.8,
                    child: Switch(
                      value: isActive,
                      onChanged: (_) {
                        ref.read(authProvider.notifier).toggleActiveStatus();
                      },
                      activeThumbColor: const Color(0xFF10B981),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Motivational Message when Inactive (Non-sticky)
          if (!isActive)
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 0),
                child: AnimatedBuilder(
                  animation: _fadeAnimation,
                  builder: (context, child) {
                    final l10n = AppLocalizations.of(context);
                    return Opacity(
                      opacity: _fadeAnimation.value,
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.amber.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.amber.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.monetization_on_rounded,
                              color: Colors.amber[700],
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                l10n?.activate_to_start_earning ?? '',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.amber[900],
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 0),
              child: const AdsBannerWidget(),
            ),
          ),

          // Content
          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 0),
            sliver: SliverToBoxAdapter(
              child: Column(
                children: [
                  DashboardCard(
                    titleKey: _overviewTitleKey,
                    earnings: profile?.totalEarnings ?? 0.0,
                    rating: profile?.rating ?? 0.0,
                    serviceId: profile?.serviceId,
                    subjectsCount: profile?.subjects_count,
                    languagesCount: profile?.languages_count,
                    coursesCount: profile?.courses_count,
                  ),
                  ManagementCard(
                    titleKey: _serviceTitleKey,
                    serviceId: profile?.serviceId,
                    profile: profile,
                  ),
                  const SizedBox(height: 16),
                  OrdersSection(titleKey: _ordersTitleKey),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showUnderReviewDialog() {
    final l10n = AppLocalizations.of(context);
    if (l10n == null) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Icon(
              Icons.lock_clock_outlined,
              color: Theme.of(context).primaryColor,
              size: 28,
            ),
            const SizedBox(width: 10),
            Text(l10n.teacherUnderReview),
          ],
        ),
        content: Text(l10n.teacherUnderReviewMessage),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pushNamed(context, '/about');
            },
            child: Text(
              l10n.contactUs,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
