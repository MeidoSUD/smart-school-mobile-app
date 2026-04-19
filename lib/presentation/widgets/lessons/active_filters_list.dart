import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';
import 'filter_chip_widget.dart';

class ActiveFiltersList extends StatelessWidget {
  final String? selectedSubjectCategory;
  final String? selectedEducationLevel;
  final String? selectedClass;
  final String? selectedService;
  final double? maxPrice;
  final double? minRating;
  final VoidCallback onClearAll;
  final Function(String) onClearFilter; // Pass the filter key to clear

  const ActiveFiltersList({
    super.key,
    this.selectedSubjectCategory,
    this.selectedEducationLevel,
    this.selectedClass,
    this.selectedService,
    this.maxPrice,
    this.minRating,
    required this.onClearAll,
    required this.onClearFilter,
  });

  @override
  Widget build(BuildContext context) {
    if (!_hasActiveFilters()) return const SizedBox.shrink();

    final filters = <Widget>[];

    if (selectedSubjectCategory != null) {
      filters.add(
        FilterChipWidget(
          label: selectedSubjectCategory!,
          onDeleted: () => onClearFilter('subject'),
        ),
      );
    }

    if (selectedEducationLevel != null) {
      filters.add(
        FilterChipWidget(
          label: selectedEducationLevel!,
          onDeleted: () => onClearFilter('level'),
        ),
      );
    }

    if (selectedClass != null) {
      filters.add(
        FilterChipWidget(
          label: selectedClass!,
          onDeleted: () => onClearFilter('class'),
        ),
      );
    }

    if (selectedService != null) {
      filters.add(
        FilterChipWidget(
          label: selectedService!,
          onDeleted: () => onClearFilter('service'),
        ),
      );
    }

    if (maxPrice != null) {
      filters.add(
        FilterChipWidget(
          label: AppLocalizations.of(
            context,
          )!.priceIndicator(maxPrice!.toInt()),
          onDeleted: () => onClearFilter('price'),
        ),
      );
    }

    if (minRating != null) {
      filters.add(
        FilterChipWidget(
          label: AppLocalizations.of(
            context,
          )!.ratingIndicator(minRating!.toStringAsFixed(1)),
          onDeleted: () => onClearFilter('rating'),
        ),
      );
    }

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                AppLocalizations.of(context)!.activeFilters,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade700,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: onClearAll,
                child: Text(
                  AppLocalizations.of(context)!.clearAll,
                  style: TextStyle(fontSize: 12, color: Colors.red.shade600),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(spacing: 8, runSpacing: 8, children: filters),
        ],
      ),
    );
  }

  bool _hasActiveFilters() {
    return selectedSubjectCategory != null ||
        selectedEducationLevel != null ||
        selectedClass != null ||
        selectedService != null ||
        maxPrice != null ||
        minRating != null;
  }
}
