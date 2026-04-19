import 'package:geniuses_school/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/utils/format_helper.dart';
import 'home_card.dart';

class DashboardCard extends StatelessWidget {
  final double earnings;
  final double rating;
  final int? serviceId;
  final int? subjectsCount;
  final int? languagesCount;
  final int? coursesCount;

  const DashboardCard({
    super.key,
    required this.earnings,
    required this.rating,
    this.serviceId,
    this.subjectsCount,
    this.languagesCount,
    this.coursesCount,
  });

  @override
  Widget build(BuildContext context) {
    return HomeCard(
      title: AppLocalizations.of(context)!.overview,
      icon: Icons.dashboard_rounded,
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Row(
            children: [
              // Earnings Section
              Expanded(
                flex: 4,
                child: _buildInfoItem(
                  context,
                  icon: Icons.account_balance_wallet_rounded,
                  color: Colors.teal,
                  title: AppLocalizations.of(context)!.wallet,
                  value: FormatHelper.formatCurrency(earnings),
                  unit: AppLocalizations.of(context)!.currency,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              if (serviceId == 3 || serviceId == 1) ...[
                // Total Lessons
                Expanded(
                  child: _buildInfoItem(
                    context,
                    icon: Icons.menu_book_rounded,
                    color: Colors.indigo,
                    title: AppLocalizations.of(context)!.lessons,
                    value: (subjectsCount ?? 0).toString(),
                  ),
                ),
                _buildVerticalDivider(),
              ],
              if (serviceId == 1) ...[
                // Total Languages
                Expanded(
                  child: _buildInfoItem(
                    context,
                    icon: Icons.language_rounded,
                    color: Colors.pink,
                    title: AppLocalizations.of(context)!.languages,
                    value: (languagesCount ?? 0).toString(),
                  ),
                ),
                _buildVerticalDivider(),
              ],
              if (serviceId == 2) ...[
                // Total Courses
                Expanded(
                  child: _buildInfoItem(
                    context,
                    icon: Icons.workspace_premium_rounded,
                    color: Colors.deepPurple,
                    title: AppLocalizations.of(context)!.courses,
                    value: (coursesCount ?? 0).toString(),
                  ),
                ),
                _buildVerticalDivider(),
              ],

              // Rating Section
              Expanded(
                child: _buildInfoItem(
                  context,
                  icon: Icons.star_rounded,
                  color: Colors.amber,
                  title: AppLocalizations.of(context)!.rating,
                  value: rating.toString(),
                  isRating: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
      width: 1,
      height: 36,
      margin: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.grey.withOpacity(0.1),
            Colors.grey.withOpacity(0.4),
            Colors.grey.withOpacity(0.1),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(
    BuildContext context, {
    required IconData icon,
    required Color color,
    required String title,
    required String value,
    String? unit,
    bool isRating = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.04),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.09), width: 0.8),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.22),
                  blurRadius: 4,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Icon(icon, color: color, size: 16),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Flexible(
                      child: Text(
                        value,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                          fontWeight: FontWeight.w800,

                          height: 1.1,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (unit != null) ...[
                      const SizedBox(width: 2),
                      Text(
                        unit,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                    if (isRating) ...[
                      const SizedBox(width: 2),
                      Icon(Icons.star, size: 10, color: Colors.amber),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
