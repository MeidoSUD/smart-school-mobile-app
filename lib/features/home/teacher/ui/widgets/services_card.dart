import 'package:flutter/material.dart';

import '../../../../../../data/models/user_profile_model.dart';
import '../../../../../l10n/app_localizations.dart';
import 'home_card.dart';

class ServicesCard extends StatelessWidget {
  final List<TeacherService>? services;

  const ServicesCard({super.key, required this.services});

  @override
  Widget build(BuildContext context) {
    if (services == null || services!.isEmpty) {
      return const SizedBox.shrink();
    }

    return HomeCard(
      title: AppLocalizations.of(context)!.myServices,
      icon: Icons.school_rounded,
      child: SizedBox(
        height: 90,
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          scrollDirection: Axis.horizontal,
          itemCount: services!.length,
          separatorBuilder: (context, index) => const SizedBox(width: 12),
          itemBuilder: (context, index) {
            final service = services![index];
            return _buildServiceCard(context, service);
          },
        ),
      ),
    );
  }

  Widget _buildServiceCard(BuildContext context, TeacherService service) {
    final theme = Theme.of(context);
    final color = theme.primaryColor; // Using primary color for consistency

    return Container(
      width: 80, // Reduced width
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.04), // Light background like Dashboard item
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.09), width: 0.8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon Section
          Container(
            padding: EdgeInsets.all(8),
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
            child: Icon(
              Icons.auto_stories_rounded,
              size: 15, // Icon size
              color: color,
            ),
          ),
          const SizedBox(height: 5),
          // Info Section
          Center(
            child: Text(
              service.nameAr ??
                  service.nameEn ??
                  AppLocalizations.of(context)!.service,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 10,
                height: 1.1,
                color: Colors.grey[800],
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
