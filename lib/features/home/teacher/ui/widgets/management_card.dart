import 'package:geniuses_school/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../data/models/user_profile_model.dart';
import 'home_card.dart';

class ManagementCard extends StatelessWidget {
  final GlobalKey? titleKey;
  final int? serviceId;
  final UserProfileModel? profile;

  const ManagementCard({
    super.key,
    this.titleKey,
    this.serviceId,
    this.profile,
  });

  @override
  Widget build(BuildContext context) {
    if (serviceId == null) return const SizedBox.shrink();
    final l10n = AppLocalizations.of(context);

    return HomeCard(
      title: l10n?.serviceManagement ?? '',
      icon: Icons.settings_suggest_rounded,
      titleKey: titleKey,
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          // Service ID 3: School/Academic
          if (serviceId == 3) ...[
            _buildActionItem(
              context,
              title: l10n?.manageStagesAndSubjects ?? '',
              icon: Icons.layers_rounded,
              onTap: () {
                // TODO: Navigate to Stages Management
                Navigator.pushNamed(context, '/levels-manage');
              },
            ),
            const SizedBox(height: 12),
          ],

          // Service ID 2: Courses
          if (serviceId == 4) ...[
            _buildActionItem(
              context,
              title: l10n?.manageCourses ?? '',
              icon: Icons.workspace_premium_rounded,
              onTap: () {
                // TODO: Navigate to Courses Management
                Navigator.pushNamed(context, '/courses-manage');
              },
            ),
          ],

          // Service ID 1: Languages
          if (serviceId == 2) ...[
            _buildActionItem(
              context,
              title: l10n?.manageLanguages ?? '',
              icon: Icons.language_rounded,
              onTap: () {
                // TODO: Navigate to Languages Management
              },
            ),
            const SizedBox(height: 12),
          ],

          // Service ID 1 or 3: Schedule
          if (serviceId == 1 || serviceId == 3) ...[
            _buildActionItem(
              context,
              title: l10n?.mySchedule ?? '',
              icon: Icons.calendar_month_rounded,
              onTap: () {
                // TODO: Navigate to Schedule
                Navigator.pushNamed(context, '/schedule-manage');
              },
            ),
            const SizedBox(height: 12),
          ],

          // Shared Price Display for Service ID 2 and 3
          if (serviceId == 2 || serviceId == 3) ...[
            _buildPriceItem(
              context,
              title: l10n?.individualLessons ?? '',
              price: profile?.individual_hour_price ?? 0.0,
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/edit-profile',
                  arguments: {'scrollTo': 'pricing'},
                );
              },
            ),
            const SizedBox(height: 12),
          ],

          // Bank Account Management - Visible for all teachers
          _buildActionItem(
            context,
            title: l10n?.manageBankAccount ?? '',
            icon: Icons.account_balance_rounded,
            onTap: () {
              Navigator.pushNamed(context, '/payment-manage');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionItem(
    BuildContext context, {
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: primaryColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: primaryColor.withOpacity(0.09), width: 0.8),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: primaryColor.withOpacity(0.22),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Icon(icon, color: primaryColor, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                  color: Colors.black87,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16.sp,
              color: primaryColor.withOpacity(0.5),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceItem(
    BuildContext context, {
    required String title,
    required double price,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: primaryColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: primaryColor.withOpacity(0.09), width: 0.8),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: primaryColor.withOpacity(0.22),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Icon(
                Icons.attach_money_rounded,
                color: primaryColor,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    "${price.toStringAsFixed(2)} ${AppLocalizations.of(context)?.currency ?? ''}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.edit_rounded,
              size: 16.sp,
              color: primaryColor.withOpacity(0.5),
            ),
          ],
        ),
      ),
    );
  }
}
