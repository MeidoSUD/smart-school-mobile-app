import 'package:geniuses_school/data/models/course_category_model.dart';
import 'package:geniuses_school/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class CourseFilterSheet extends StatefulWidget {
  final int? selectedCategoryId;
  final String? selectedLevel;
  final double? maxPrice;
  final List<CourseCategory> categories;
  final List<String> levels;
  final Function(Map<String, dynamic>) onFiltersChanged;

  const CourseFilterSheet({
    super.key,
    required this.selectedCategoryId,
    required this.selectedLevel,
    required this.maxPrice,
    required this.categories,
    required this.levels,
    required this.onFiltersChanged,
  });

  @override
  State<CourseFilterSheet> createState() => _CourseFilterSheetState();
}

class _CourseFilterSheetState extends State<CourseFilterSheet> {
  int? selectedCategoryId;
  String? selectedLevel;
  double? maxPrice;

  @override
  void initState() {
    super.initState();
    selectedCategoryId = widget.selectedCategoryId;
    selectedLevel = widget.selectedLevel;
    maxPrice = widget.maxPrice;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Handle
          Container(
            height: 4,
            width: 40,
            margin: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Text(
                  AppLocalizations.of(context)!.filterCourses,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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

          // Filters
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _buildCategoryDropdownFilter(
                  AppLocalizations.of(context)!.category,
                  selectedCategoryId,
                  widget.categories,
                  (val) => setState(() => selectedCategoryId = val),
                ),

                const SizedBox(height: 20),

                _buildDropdownFilter(
                  AppLocalizations.of(context)!.level,
                  selectedLevel,
                  widget.levels,
                  (val) => setState(() => selectedLevel = val),
                ),

                const SizedBox(height: 30),

                _buildSliderFilter(
                  AppLocalizations.of(context)!.maxPrice,
                  maxPrice ?? 1500,
                  500,
                  2000,
                  "≤ ${(maxPrice ?? 1500).toInt()} ${AppLocalizations.of(context)!.sar}",
                  (val) => setState(() => maxPrice = val),
                ),
              ],
            ),
          ),

          // Apply Button
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
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownFilter(
    String title,
    String? value,
    List<String> items,
    Function(String?) onChanged,
  ) {
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
          ),
          child: DropdownButtonFormField<String>(
            value: value,
            hint: Text(AppLocalizations.of(context)!.selectItem(title)),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
            items: items
                .map((item) => DropdownMenuItem(value: item, child: Text(item)))
                .toList(),
            onChanged: onChanged,
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
          divisions: ((max - min) / 100).toInt(),
          activeColor: Theme.of(context).primaryColor,
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildCategoryDropdownFilter(
    String title,
    int? value,
    List<CourseCategory> categories,
    Function(int?) onChanged,
  ) {
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
          ),
          child: DropdownButtonFormField<int>(
            value: value,
            hint: Text(AppLocalizations.of(context)!.selectItem(title)),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
            items: categories
                .map(
                  (category) => DropdownMenuItem(
                    value: category.id,
                    child: Text(category.nameAr),
                  ),
                )
                .toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  void _resetFilters() {
    setState(() {
      selectedCategoryId = null;
      selectedLevel = null;
      maxPrice = null;
    });
  }

  void _applyFilters() {
    widget.onFiltersChanged({
      'categoryId': selectedCategoryId,
      'level': selectedLevel,
      'price': maxPrice,
    });
    Navigator.pop(context);
  }
}
