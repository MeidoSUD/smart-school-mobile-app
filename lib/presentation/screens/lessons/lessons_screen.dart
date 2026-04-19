import 'package:geniuses_school/core/utils/logger.dart';
import 'package:geniuses_school/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import '../../../data/models/teacher_model.dart';
import '../../../data/repositories/filters_repository.dart';
import '../../../data/repositories/teachers_repository.dart';
import '../../widgets/common/ballsWidget.dart';
import '../../widgets/lessons/active_filters_list.dart';
import '../../widgets/lessons/filter_sheet.dart';
import '../../widgets/lessons/search_bar_widget_legacy.dart';
import '../../widgets/lessons/teacher_map_card.dart';

class LessonsScreen extends StatefulWidget {
  final String? initialService;
  final String? initialSubject;
  const LessonsScreen({super.key, this.initialService, this.initialSubject});

  @override
  State<LessonsScreen> createState() => _LessonsScreenState();
}

class _LessonsScreenState extends State<LessonsScreen> {
  final TeachersRepository _teachersRepository = TeachersRepository();
  final FiltersRepository _filtersRepository = FiltersRepository();
  List<TeacherModel> _teachers = [];
  List<Map<String, dynamic>> _convertedTeachers = [];
  bool _isLoading = true;
  String? _error;

  int? selectedSubjectId;
  int? selectedEducationLevelId;
  int? selectedClassId;
  int? selectedServiceId;
  double? maxPrice;
  double? minRating;
  String searchQuery = "";

  List<Map<String, dynamic>> subjects = [];
  List<Map<String, dynamic>> educationLevels = [];
  List<Map<String, dynamic>> classes = [];
  List<Map<String, dynamic>> services = [];

  late Map<String, dynamic> args;
  late String? routedService;
  late String? routedSubject;

  bool _isInit = true;

  @override
  void initState() {
    super.initState();
    _loadFiltersData();
  }

  Future<void> _loadFiltersData() async {
    try {
      Logger.log("Loading filters data...");
      final fetchedServices = await _filtersRepository.getServices();
      Logger.log("Services loaded: ${fetchedServices.length}");

      final fetchedLevels = await _filtersRepository.getEducationLevels();
      Logger.log("Levels loaded: ${fetchedLevels.length}");

      setState(() {
        services = fetchedServices;
        educationLevels = fetchedLevels;
      });

      Logger.log("Filters data loaded successfully");
    } catch (e, stackTrace) {
      Logger.log("Error loading filters data: $e");
      Logger.log("Stack trace: $stackTrace");
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInit) return;
    _isInit = false;

    final routeArgs = ModalRoute.of(context)?.settings.arguments;

    if (routeArgs != null && routeArgs is Map<String, dynamic>) {
      args = routeArgs;

      // Reset filters to ensure no stale data
      selectedServiceId = null;
      selectedSubjectId = null;
      selectedEducationLevelId = null;
      selectedClassId = null;
      maxPrice = null;
      minRating = null;
      searchQuery = "";

      final serviceVal = args['service'];
      Logger.log("service ----> $serviceVal");
      if (serviceVal != null) {
        selectedServiceId = int.tryParse(serviceVal.toString());
      }

      final subjectVal = args['subject'];
      Logger.log("subject ----> $subjectVal");
      if (subjectVal != null) {
        selectedSubjectId = int.tryParse(subjectVal.toString());
      }
    } else {
      args = {};
      Logger.log("No service argument passed");
    }
    _loadTeachers();
  }

  Future<void> _loadTeachers() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final teachers = await _teachersRepository.getTeachersWithFilters(
        subjectId: selectedSubjectId,
        educationLevelId: selectedEducationLevelId,
        classId: selectedClassId,
        serviceId: selectedServiceId,
        maxPrice: maxPrice,
        minRating: minRating,
        searchQuery: searchQuery.isNotEmpty ? searchQuery : null,
      );

      final converted = teachers.map((t) => t.toJson()).toList();

      setState(() {
        _teachers = teachers;
        _convertedTeachers = converted;
        _isLoading = false;
      });
    } catch (e) {
      Logger.log("Error loading teachers: $e");
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final filteredTeachers = _convertedTeachers;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.primaryColor,
        elevation: 0,
        shadowColor: Colors.black.withValues(alpha: 0.1),
        surfaceTintColor: Colors.transparent,
        foregroundColor: Colors.white,
        title: Column(
          children: [
            Text(
              AppLocalizations.of(context)!.teachers,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            if (!_isLoading && _error == null)
              Text(
                AppLocalizations.of(
                  context,
                )!.teachersAvailable(filteredTeachers.length),
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white70,
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
      body: Stack(
        children: [
          BallsWidget(
            size: 40,
            color: Color(0xFF5170ff),
            alignment: Alignment(1.1, -0.8),
            opacity: 0.9,
          ),
          BallsWidget(
            size: 100,
            color: theme.primaryColorLight,
            alignment: Alignment(-1.4, -0.8),
            opacity: 0.9,
          ),
          BallsWidget(
            size: 100,
            color: Color(0xFF5170ff),
            alignment: Alignment(-1.3, 1),
            opacity: 0.9,
          ),
          Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
                child: SearchBarWidget(
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                    _loadTeachers();
                  },
                ),
              ),
              if (_hasActiveFilters() && !_isLoading && _error == null)
                _buildActiveFilters(),
              Expanded(
                child: _buildBodyContent(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBodyContent() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.red.shade300),
            const SizedBox(height: 16),
            Text(
              AppLocalizations.of(context)!.errorLoadingData,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _error ?? "",
              style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _loadTeachers,
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
              ),
              child: Text(AppLocalizations.of(context)!.retry),
            ),
          ],
        ),
      );
    }

    final filteredTeachers = _convertedTeachers;
    if (filteredTeachers.isEmpty) {
      return _buildEmptyState();
    }

    return RefreshIndicator(
      onRefresh: _loadTeachers,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: filteredTeachers.length,
        itemBuilder: (context, index) {
          return TeacherMapCard(
            teacher: filteredTeachers[index],
          );
        },
      ),
    );
  }

  bool _hasActiveFilters() {
    return selectedSubjectId != null ||
        selectedEducationLevelId != null ||
        selectedClassId != null ||
        selectedServiceId != null ||
        maxPrice != null ||
        minRating != null;
  }

  String? _getNameById(List<Map<String, dynamic>> list, int? id) {
    if (id == null) return null;
    try {
      final item = list.firstWhere((item) => item['id'] == id);
      return item['name_ar'] ?? item['name'] ?? item['title'];
    } catch (e) {
      return null;
    }
  }

  Widget _buildActiveFilters() {
    return ActiveFiltersList(
      selectedSubjectCategory: _getNameById(subjects, selectedSubjectId),
      selectedEducationLevel: _getNameById(
        educationLevels,
        selectedEducationLevelId,
      ),
      selectedClass: _getNameById(classes, selectedClassId),
      selectedService: _getNameById(services, selectedServiceId),
      maxPrice: maxPrice,
      minRating: minRating,
      onClearAll: _clearAllFilters,
      onClearFilter: (key) {
        setState(() {
          if (key == 'subject') selectedSubjectId = null;
          if (key == 'level') selectedEducationLevelId = null;
          if (key == 'class') selectedClassId = null;
          if (key == 'service') selectedServiceId = null;
          if (key == 'price') maxPrice = null;
          if (key == 'rating') minRating = null;
        });
        _loadTeachers();
      },
    );
  }

  void _clearAllFilters() {
    setState(() {
      selectedSubjectId = null;
      selectedEducationLevelId = null;
      selectedClassId = null;
      selectedServiceId = null;
      maxPrice = null;
      minRating = null;
    });
    _loadTeachers();
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
              Icons.person_search_rounded,
              size: 60,
              color: Colors.grey.shade400,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            AppLocalizations.of(context)!.noTeachersFound,
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

  void _openFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => FilterSheet(
        selectedSubjectId: selectedSubjectId,
        selectedEducationLevelId: selectedEducationLevelId,
        selectedClassId: selectedClassId,
        selectedServiceId: selectedServiceId,
        maxPrice: maxPrice,
        minRating: minRating,
        subjects: subjects,
        educationLevels: educationLevels,
        classes: classes,
        services: services,
        filtersRepository: _filtersRepository,
        onFiltersChanged: (filters) {
          setState(() {
            selectedSubjectId = filters['subject'];
            selectedEducationLevelId = filters['level'];
            selectedClassId = filters['class'];
            selectedServiceId = filters['service'];
            maxPrice = filters['price'];
            minRating = filters['rating'];
          });
          _loadTeachers();
        },
      ),
    );
  }
}
