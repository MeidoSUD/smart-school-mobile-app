import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';
import 'booking_selection_card.dart';

class ClassStep extends StatelessWidget {
  final List<Map<String, dynamic>> availableClasses;
  final Map<String, dynamic>? selectedClass;
  final Function(Map<String, dynamic>) onClassSelected;

  const ClassStep({
    super.key,
    required this.availableClasses,
    required this.selectedClass,
    required this.onClassSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          AppLocalizations.of(context)!.selectStudyLevel,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E293B),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          AppLocalizations.of(context)!.selectYourClass,
          style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),

        ...availableClasses.map(
          (cls) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: BookingSelectionCard(
              title: cls["title"] ?? "",
              icon: Icons.class_rounded,
              color: Colors.indigo.shade600,
              isSelected: selectedClass?["id"] == cls["id"],
              onTap: () => onClassSelected(cls),
            ),
          ),
        ),
      ],
    );
  }
}
