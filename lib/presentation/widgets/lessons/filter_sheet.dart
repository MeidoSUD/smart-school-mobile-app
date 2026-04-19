import 'package:flutter/material.dart';

import '../../../data/repositories/filters_repository.dart';
import '../../../l10n/app_localizations.dart';

class FilterSheet extends StatefulWidget {
  final int? selectedSubjectId;
  final int? selectedEducationLevelId;
  final int? selectedClassId;
  final int? selectedServiceId;
  final double? maxPrice;
  final double? minRating;
  final List<Map<String, dynamic>> subjects;
  final List<Map<String, dynamic>> educationLevels;
  final List<Map<String, dynamic>> classes;
  final List<Map<String, dynamic>> services;
  final FiltersRepository filtersRepository;
  final Function(Map<String, dynamic>) onFiltersChanged;

  const FilterSheet({
    super.key,
    required this.selectedSubjectId,
    required this.selectedEducationLevelId,
    required this.selectedClassId,
    required this.selectedServiceId,
    required this.maxPrice,
    required this.minRating,
    required this.subjects,
    required this.educationLevels,
    required this.classes,
    required this.services,
    required this.filtersRepository,
    required this.onFiltersChanged,
  });

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  int? selectedSubjectId;
  int? selectedEducationLevelId;
  int? selectedClassId;
  int? selectedServiceId;
  double? maxPrice;
  double? minRating;

  List<Map<String, dynamic>> availableClasses = [];
  List<Map<String, dynamic>> availableSubjects = [];

  @override
  void initState() {
    super.initState();
    selectedSubjectId = widget.selectedSubjectId;
    selectedEducationLevelId = widget.selectedEducationLevelId;
    selectedClassId = widget.selectedClassId;
    selectedServiceId = widget.selectedServiceId;
    maxPrice = widget.maxPrice;
    minRating = widget.minRating;
    availableClasses = widget.classes;
    availableSubjects = widget.subjects;

    if (selectedEducationLevelId != null) {
      _loadClassesByLevel(selectedEducationLevelId!);
    }
    if (selectedClassId != null) {
      _loadSubjectsByClass(selectedClassId!);
    }
  }

  Future<void> _loadClassesByLevel(int levelId) async {
    try {
      final classes = await widget.filtersRepository.getClassesByLevel(levelId);
      setState(() {
        availableClasses = classes;
      });
    } catch (e) {
      print("Error loading classes: $e");
    }
  }

  Future<void> _loadSubjectsByClass(int classId) async {
    try {
      final subjects = await widget.filtersRepository.getSubjectsByClass(
        classId,
      );
      setState(() {
        availableSubjects = subjects;
      });
    } catch (e) {
      print("Error loading subjects: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Container(
            height: 4,
            width: 40,
            margin: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Text(
                  AppLocalizations.of(context)!.filterTeachers,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: _resetFilters,
                  child: Text(
                    AppLocalizations.of(context)!.reset,
                    style: TextStyle(
                      color: Colors.red.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const Divider(),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _buildDropdownFilter(
                  context,
                  AppLocalizations.of(context)!.serviceType,
                  selectedServiceId,
                  widget.services,
                  (val) => setState(() => selectedServiceId = val),
                ),

                const SizedBox(height: 20),

                _buildDropdownFilter(
                  context,
                  AppLocalizations.of(context)!.educationalLevel,
                  selectedEducationLevelId,
                  widget.educationLevels,
                  (val) {
                    setState(() {
                      selectedEducationLevelId = val;
                      selectedClassId = null;
                      selectedSubjectId = null;
                      availableClasses = [];
                      availableSubjects = [];
                    });
                    if (val != null) {
                      _loadClassesByLevel(val);
                    }
                  },
                ),

                const SizedBox(height: 20),

                _buildDropdownFilter(
                  context,
                  AppLocalizations.of(context)!.schoolClass,
                  selectedClassId,
                  availableClasses,
                  (val) {
                    setState(() {
                      selectedClassId = val;
                      selectedSubjectId = null;
                      availableSubjects = [];
                    });
                    if (val != null) {
                      _loadSubjectsByClass(val);
                    }
                  },
                ),

                const SizedBox(height: 20),

                _buildDropdownFilter(
                  context,
                  AppLocalizations.of(context)!.specialization,
                  selectedSubjectId,
                  availableSubjects,
                  (val) => setState(() => selectedSubjectId = val),
                ),

                const SizedBox(height: 30),

                _buildSliderFilter(
                  AppLocalizations.of(context)!.maxPrice,
                  maxPrice ?? 100,
                  20,
                  200,
                  AppLocalizations.of(
                    context,
                  )!.priceIndicator((maxPrice ?? 100).toInt()),
                  (val) => setState(() => maxPrice = val),
                ),

                const SizedBox(height: 30),

                _buildSliderFilter(
                  AppLocalizations.of(context)!.minRatingLabel,
                  minRating ?? 0,
                  0,
                  5,
                  AppLocalizations.of(
                    context,
                  )!.ratingIndicator((minRating ?? 0).toStringAsFixed(1)),
                  (val) => setState(() => minRating = val),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _applyFilters,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  AppLocalizations.of(context)!.applyFilters,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownFilter(
    BuildContext context,
    String title,
    int? value,
    List<Map<String, dynamic>> items,
    Function(int?) onChanged,
  ) {
    final hasItems = items.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12),
            color: hasItems ? Colors.white : Colors.grey.shade100,
          ),
          child: DropdownButtonFormField<int>(
            initialValue: value,
            hint: Text(
              hasItems
                  ? "${AppLocalizations.of(context)!.choose} $title"
                  : AppLocalizations.of(context)!.noData,
              style: TextStyle(
                color: hasItems ? Colors.black54 : Colors.grey.shade400,
              ),
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
            items: hasItems
                ? items
                      .map(
                        (item) => DropdownMenuItem(
                          value: item['id'] as int,
                          child: Text(
                            item['name_ar'] ??
                                item['name'] ??
                                item['title'] ??
                                '',
                          ),
                        ),
                      )
                      .toList()
                : null,
            onChanged: hasItems ? onChanged : null,
          ),
        ),
      ],
    );
  }

  Widget _buildSliderFilter(
    String title,
    double value,
    double min,
    double max,
    String label,
    Function(double) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
        ),
        Slider(
          value: value,
          min: min,
          max: max,
          divisions: (max - min).toInt(),
          activeColor: Theme.of(context).primaryColor,
          onChanged: onChanged,
        ),
      ],
    );
  }

  void _resetFilters() {
    setState(() {
      selectedSubjectId = null;
      selectedEducationLevelId = null;
      selectedClassId = null;
      selectedServiceId = null;
      maxPrice = null;
      minRating = null;
      availableClasses = [];
      availableSubjects = [];
    });
  }

  void _applyFilters() {
    widget.onFiltersChanged({
      'subject': selectedSubjectId,
      'level': selectedEducationLevelId,
      'class': selectedClassId,
      'service': selectedServiceId,
      'price': maxPrice,
      'rating': minRating,
    });
    Navigator.pop(context);
  }
}
