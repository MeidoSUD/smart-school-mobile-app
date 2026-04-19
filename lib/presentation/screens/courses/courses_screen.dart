import 'package:geniuses_school/core/utils/logger.dart';
import 'package:geniuses_school/data/models/course_category_model.dart';
import 'package:geniuses_school/data/models/course_model.dart';
import 'package:geniuses_school/data/repositories/course_repository.dart';
import 'package:geniuses_school/l10n/app_localizations.dart';
import 'package:geniuses_school/data/models/level_model.dart';
import 'package:geniuses_school/presentation/widgets/courses/course_card.dart';
import 'package:geniuses_school/presentation/widgets/courses/course_card_widget.dart';
import 'package:geniuses_school/presentation/widgets/courses/course_details_sheet.dart';
import 'package:geniuses_school/presentation/widgets/courses/course_filter_chip.dart';
import 'package:geniuses_school/presentation/widgets/courses/course_filter_sheet.dart';
import 'package:geniuses_school/presentation/widgets/courses/course_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CoursesScreen extends ConsumerStatefulWidget {
  final int? categoryId;

  const CoursesScreen({super.key, this.categoryId});

  @override
  ConsumerState<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends ConsumerState<CoursesScreen> {
  final CourseRepository _courseRepository = CourseRepository();
  List<Course> _courses = [];
  List<CourseCategory> _categories = [];
  List<LevelModel> _educationLevels = [];
  bool _isLoading = true;
  bool _isLoadingCategories = true;
  String? _errorMessage;

  int? selectedCategoryId;
  double? maxPrice;
  int? selectedLevelId;
  String searchQuery = "";
  bool _isInit = true;

  final List<String> levels = ["مبتدئ", "متوسط", "متقدم"];

  @override
  void initState() {
    super.initState();
    if (widget.categoryId != null) {
      selectedCategoryId = widget.categoryId;
    }
    _loadCourses();
    _loadCategories();
    _loadLevels();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      final routeArgs = ModalRoute.of(context)?.settings.arguments;
      if (routeArgs != null && routeArgs is Map<String, dynamic>) {
        final categoryId = routeArgs['categoryId'] as int?;
        if (categoryId != null) {
          selectedCategoryId = categoryId;
          _loadCourses(categoryId: categoryId);
        }
      }
      _isInit = false;
    }
  }

  Future<void> _loadCategories() async {
    try {
      final categories = await _courseRepository.getCourseCategories();
      setState(() {
        _categories = categories;
        _isLoadingCategories = false;
      });
    } catch (e) {
      Logger.log("Error loading categories: $e");
      setState(() {
        _isLoadingCategories = false;
      });
    }
  }

  Future<void> _loadLevels() async {
    try {
      final levels = await _courseRepository.getEducationLevels();
      setState(() {
        _educationLevels = levels;
      });
    } catch (e) {
      Logger.log("Error loading levels: $e");
    }
  }

  Future<void> _loadCourses({
    int? categoryId,
    int? levelId,
    double? price,
    bool showLoading = true,
  }) async {
    final effectiveCategoryId = categoryId ?? selectedCategoryId;
    final effectiveLevelId = levelId ?? selectedLevelId;
    final effectivePrice = price ?? maxPrice;

    if (showLoading) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });
    }

    try {
      final courses = await _courseRepository.getCourses(
        categoryId: effectiveCategoryId,
        levelId: effectiveLevelId,
        price: effectivePrice,
      );
      if (mounted) {
        setState(() {
          _courses = courses;
          _isLoading = false;
        });
      }
    } catch (e) {
      Logger.log("Error loading courses: $e");
      if (mounted) {
        setState(() {
          _errorMessage = e.toString().replaceAll('Exception: ', '');
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context)!;

    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: theme.primaryColor,
          elevation: 0,
          title: Text(
            loc.trainingCourses,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_errorMessage != null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: theme.primaryColor,
          elevation: 0,
          title: Text(
            loc.trainingCourses,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64, color: Colors.red.shade300),
              const SizedBox(height: 16),
              Text(
                loc.errorLoadingCourses,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _errorMessage ?? "",
                style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => _loadCourses(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.primaryColor,
                  foregroundColor: Colors.white,
                ),
                child: Text(loc.retry),
              ),
            ],
          ),
        ),
      );
    }

    final filteredCourses = _courses.where((course) {
      if (searchQuery.isNotEmpty) {
        final q = searchQuery.toLowerCase();
        final title = course.title.toLowerCase();
        final description = course.description.toLowerCase();
        final teacher = course.teacherName.toLowerCase();
        final category = course.category.toLowerCase();

        if (!(title.contains(q) ||
            description.contains(q) ||
            teacher.contains(q) ||
            category.contains(q))) {
          return false;
        }
      }
      return true;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.primaryColor,
        elevation: 0,
        foregroundColor: Colors.white,
        title: Column(
          children: [
            Text(
              loc.trainingCourses,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              loc.coursesAvailableCount(filteredCourses.length),
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(left: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: Icon(Icons.tune_rounded, color: theme.primaryColor),
              onPressed: () => _openFilterSheet(context),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: CourseSearchBar(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
          if (_hasActiveFilters()) _buildActiveFilters(),
          Expanded(
            child: filteredCourses.isEmpty
                ? _buildEmptyState()
                : RefreshIndicator(
                    onRefresh: () => _loadCourses(),
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: filteredCourses.length,
                      itemBuilder: (context, index) {
                        return CourseCardWidget(
                          course: filteredCourses[index],
                          onTap: () =>
                              _showCourseDetails(filteredCourses[index]),
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  bool _hasActiveFilters() {
    return selectedCategoryId != null ||
        maxPrice != null ||
        selectedLevelId != null;
  }

  Widget _buildActiveFilters() {
    final filters = <Widget>[];

    if (selectedCategoryId != null) {
      final category = _categories.firstWhere(
        (cat) => cat.id == selectedCategoryId,
        orElse: () => CourseCategory(
          id: selectedCategoryId!,
          nameAr: 'تصنيف',
          nameEn: 'Category',
        ),
      );
      filters.add(
        CourseFilterChip(
          label: category.nameAr,
          onDeleted: () {
            setState(() => selectedCategoryId = null);
            _loadCourses(showLoading: false);
          },
        ),
      );
    }

    if (selectedLevelId != null) {
      final level = _educationLevels.firstWhere(
        (l) => l.id == selectedLevelId,
        orElse: () => LevelModel(id: selectedLevelId!, name: 'مستوى'),
      );
      filters.add(
        CourseFilterChip(
          label: level.name,
          onDeleted: () {
            setState(() => selectedLevelId = null);
            _loadCourses(showLoading: false);
          },
        ),
      );
    }

    if (maxPrice != null) {
      filters.add(
        CourseFilterChip(
          label: "≤ ${maxPrice!.toInt()} ريال",
          onDeleted: () {
            setState(() => maxPrice = null);
            _loadCourses(showLoading: false);
          },
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
                "${AppLocalizations.of(context)!.activeFilters}:",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade700,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: _clearAllFilters,
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

  void _clearAllFilters() {
    setState(() {
      selectedCategoryId = null;
      maxPrice = null;
      selectedLevelId = null;
    });
    _loadCourses(showLoading: false);
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.school_outlined,
              size: 60,
              color: Colors.grey.shade400,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            AppLocalizations.of(context)!.noCoursesFound,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            AppLocalizations.of(context)!.tryAdjustingSearch,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }

  void _showCourseDetails(Course course) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => CourseDetailsSheet(course: course),
    );
  }

  void _openFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => CourseFilterSheet(
        selectedCategoryId: selectedCategoryId,
        selectedLevel: selectedLevelId != null
            ? _educationLevels
                  .firstWhere(
                    (l) => l.id == selectedLevelId,
                    orElse: () => LevelModel(id: 0, name: ''),
                  )
                  .name
            : null,
        maxPrice: maxPrice,
        categories: _categories,
        levels: _educationLevels.map((l) => l.name).toList(),
        onFiltersChanged: (filters) {
          final levelName = filters['level'] as String?;
          final levelId = levelName != null
              ? _educationLevels
                    .firstWhere(
                      (l) => l.name == levelName,
                      orElse: () => LevelModel(id: 0, name: ''),
                    )
                    .id
              : null;

          setState(() {
            selectedCategoryId = filters['categoryId'] as int?;
            selectedLevelId = levelId != 0 ? levelId : null;
            maxPrice = filters['price'] as double?;
          });
          _loadCourses(showLoading: false);
        },
      ),
    );
  }
}
