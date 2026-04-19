import 'package:geniuses_school/core/routes/app_routes.dart';
import 'package:geniuses_school/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/utils/format_helper.dart';
import 'home_card.dart';

class DashboardCard extends StatelessWidget {
  final GlobalKey? titleKey;
  final double earnings;
  final double rating;
  final int? serviceId;
  final int? subjectsCount;
  final int? languagesCount;
  final int? coursesCount;

  const DashboardCard({
    super.key,
    this.titleKey,
    required this.earnings,
    required this.rating,
    this.serviceId,
    this.subjectsCount,
    this.languagesCount,
    this.coursesCount,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return HomeCard(
      title: l10n?.overview ?? '',
      icon: Icons.dashboard_rounded,
      titleKey: titleKey,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Featured Earnings Card
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.profitManage);
            },
            borderRadius: BorderRadius.circular(16),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [const Color(0xFF0D9488), const Color(0xFF0F766E)],
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF0D9488).withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.account_balance_wallet_rounded,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          l10n?.wallet ?? '',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(
                          l10n?.total_earnings ?? '',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        FormatHelper.formatCurrency(earnings),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32.sp,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.5,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        l10n?.currency ?? '',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Stats Grid
          Row(
            children: [
              if (serviceId == 3 || serviceId == 1) ...[
                Expanded(
                  child: _buildModernStatCard(
                    context,
                    icon: Icons.menu_book_rounded,
                    gradient: const LinearGradient(
                      colors: [Color(0xFF4F46E5), Color(0xFF4338CA)],
                    ),
                    title: l10n?.lessons ?? '',
                    value: (subjectsCount ?? 0).toString(),
                  ),
                ),
                const SizedBox(width: 12),
              ],
              if (serviceId == 1) ...[
                Expanded(
                  child: _buildModernStatCard(
                    context,
                    icon: Icons.language_rounded,
                    gradient: const LinearGradient(
                      colors: [Color(0xFFDB2777), Color(0xFFC026D3)],
                    ),
                    title: l10n?.languages ?? '',
                    value: (languagesCount ?? 0).toString(),
                  ),
                ),
                const SizedBox(width: 12),
              ],
              if (serviceId == 2) ...[
                Expanded(
                  child: _buildModernStatCard(
                    context,
                    icon: Icons.workspace_premium_rounded,
                    gradient: const LinearGradient(
                      colors: [Color(0xFF7C3AED), Color(0xFF6D28D9)],
                    ),
                    title: l10n?.courses ?? '',
                    value: (coursesCount ?? 0).toString(),
                  ),
                ),
                const SizedBox(width: 12),
              ],
              Expanded(
                child: _buildModernStatCard(
                  context,
                  icon: Icons.star_rounded,
                  gradient: const LinearGradient(
                    colors: [Color(0xFFF59E0B), Color(0xFFD97706)],
                  ),
                  title: l10n?.rating ?? '',
                  value: rating.toStringAsFixed(1),
                  showStar: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildModernStatCard(
    BuildContext context, {
    required IconData icon,
    required Gradient gradient,
    required String title,
    required String value,
    bool showStar = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withOpacity(0.1), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: gradient,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: gradient.colors.first.withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  value,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.5,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (showStar) ...[
                SizedBox(width: 4.w),
                Icon(
                  Icons.star_rounded,
                  size: 16.sp,
                  color: const Color(0xFFF59E0B),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
