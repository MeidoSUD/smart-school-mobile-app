import 'package:geniuses_school/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import 'booking_selection_card.dart';

class LevelStep extends StatelessWidget {
  final List<dynamic> levels;
  final Map<String, dynamic>? selectedLevel;
  final Function(Map<String, dynamic>) onLevelSelected;

  const LevelStep({
    super.key,
    required this.levels,
    required this.selectedLevel,
    required this.onLevelSelected,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          loc.chooseLevel,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E293B),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          loc.chooseLevelInstruction,
          style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),

        ...levels.map(
          (level) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: BookingSelectionCard(
              title: level["title"] ?? "",
              icon: Icons.school_rounded,
              color: Colors.blue.shade600,
              isSelected: selectedLevel?["id"] == level["id"],
              onTap: () => onLevelSelected(level),
            ),
          ),
        ),
      ],
    );
  }
}
