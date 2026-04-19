import 'package:geniuses_school/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import 'booking_selection_card.dart';

class SubjectStep extends StatelessWidget {
  final List<dynamic> subjects;
  final Map<String, dynamic>? selectedSubject;
  final Function(Map<String, dynamic>) onSubjectSelected;

  const SubjectStep({
    super.key,
    required this.subjects,
    required this.selectedSubject,
    required this.onSubjectSelected,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          loc.chooseSubject,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E293B),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          loc.chooseSubjectInstruction,
          style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),

        ...subjects.map(
          (subject) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: BookingSelectionCard(
              title:
                  "${subject["title"]}${subject["class_title"] != null ? " - ${subject["class_title"]}" : ""}${subject["class_level_title"] != null ? " - ${subject["class_level_title"]}" : ""}",
              icon: Icons.menu_book_rounded,
              color: Colors.purple.shade600,
              isSelected: selectedSubject?["id"] == subject["id"],
              onTap: () => onSubjectSelected(subject),
            ),
          ),
        ),
      ],
    );
  }
}
