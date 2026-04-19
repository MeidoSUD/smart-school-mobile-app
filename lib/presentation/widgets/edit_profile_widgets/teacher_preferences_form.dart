import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../l10n/app_localizations.dart';

class TeacherPreferencesForm extends StatelessWidget {
  final bool teachSingleLesson;
  final TextEditingController singleLessonPriceController;
  final Function(bool) onTeachSingleChanged;

  const TeacherPreferencesForm({
    super.key,
    required this.teachSingleLesson,
    required this.singleLessonPriceController,
    required this.onTeachSingleChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.primaryColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.primaryColor.withOpacity(0.2),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.school_outlined, color: theme.primaryColor, size: 24),
              const SizedBox(width: 8),
              Text(
                AppLocalizations.of(context)!.lessonTypes,
                style: theme.textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.primaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Single Lesson Section
          _buildLessonTypeOption(
            context,
            title: AppLocalizations.of(context)!.individualLessons,
            subtitle: AppLocalizations.of(context)!.individualLessonsDesc,
            isSelected: teachSingleLesson,
            onTap: () => onTeachSingleChanged(!teachSingleLesson),
          ),

          AnimatedCrossFade(
            duration: const Duration(milliseconds: 300),
            crossFadeState: teachSingleLesson
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            firstChild: const SizedBox.shrink(),
            secondChild: Padding(
              padding: const EdgeInsets.only(top: 12),
              child: _buildPriceField(
                context,
                controller: singleLessonPriceController,
                label: AppLocalizations.of(context)!.hourlyRateSAR,
                enabled: teachSingleLesson,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLessonTypeOption(
    BuildContext context, {
    required String title,
    required String subtitle,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected
              ? theme.primaryColor.withOpacity(0.1)
              : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? theme.primaryColor : Colors.grey.shade300,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: isSelected ? theme.primaryColor : Colors.transparent,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: isSelected ? theme.primaryColor : Colors.grey.shade400,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? const Icon(Icons.check, color: Colors.white, size: 16)
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: theme.textTheme.bodySmall!.copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.person_outline, color: theme.primaryColor),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceField(
    BuildContext context, {
    required TextEditingController controller,
    required String label,
    required bool enabled,
  }) {
    final theme = Theme.of(context);

    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(Icons.attach_money, color: theme.primaryColor),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: theme.primaryColor, width: 2),
        ),
      ),
      validator: (v) {
        if (enabled && (v == null || v.isEmpty)) {
          return AppLocalizations.of(context)!.priceRequired;
        }
        if (enabled && v != null && v.isNotEmpty) {
          final price = double.tryParse(v);
          if (price != null && price > 500) {
            return AppLocalizations.of(context)!.invalid;
          }
        }
        return null;
      },
    );
  }
}
