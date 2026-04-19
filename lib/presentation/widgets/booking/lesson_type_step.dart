import 'package:geniuses_school/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import 'lesson_type_option.dart';

class LessonTypeStep extends StatelessWidget {
  final Map<String, dynamic> teacher;
  final String? selectedLessonType;
  final Function(String) onLessonTypeSelected;

  const LessonTypeStep({
    super.key,
    required this.teacher,
    required this.selectedLessonType,
    required this.onLessonTypeSelected,
  });

  @override
  Widget build(BuildContext context) {
    final teachIndividual = teacher["teach_individual"] == 1;
    final teachGroup = teacher["teach_group"] == 1;
    final loc = AppLocalizations.of(context)!;

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          loc.chooseLessonType,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E293B),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          loc.chooseLessonTypeInstruction,
          style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),

        if (teachIndividual)
          LessonTypeOption(
            title: loc.typeSingle,
            subtitle: loc.individualLessonSubtitle,
            icon: Icons.person_outline,
            price: teacher["individual_hour_price"]?.toInt() ?? 0,
            color: Theme.of(context).primaryColor,
            isSelected: selectedLessonType == "single",
            onTap: () => onLessonTypeSelected("single"),
          ),

        if (teachIndividual && teachGroup) const SizedBox(height: 16),

        if (teachGroup)
          LessonTypeOption(
            title: loc.typeGroup,
            subtitle: loc.groupLessonSubtitle(
              (teacher["min_group_size"] ?? 0).toString(),
              (teacher["max_group_size"] ?? 0).toString(),
            ),
            icon: Icons.groups_outlined,
            price: teacher["group_hour_price"]?.toInt() ?? 0,
            color: Colors.green.shade600,
            isSelected: selectedLessonType == "group",
            onTap: () => onLessonTypeSelected("group"),
          ),
      ],
    );
  }
}
