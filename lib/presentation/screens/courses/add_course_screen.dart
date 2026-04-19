import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:geniuses_school/l10n/app_localizations.dart';
import 'package:geniuses_school/presentation/state/courses_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class AddCourseScreen extends ConsumerStatefulWidget {
  const AddCourseScreen({super.key});

  @override
  ConsumerState<AddCourseScreen> createState() => _AddCourseScreenState();
}

class _AddCourseScreenState extends ConsumerState<AddCourseScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleArController = TextEditingController();
  final _titleEnController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _durationController = TextEditingController();

  int? _selectedCategoryId;
  int? _selectedLevelId;
  int? _selectedSubjectId;
  String _selectedType = 'single';
  String _selectedStatus = 'draft';

  File? _coverImage;
  // Slots: mapping day (1-7) to a list of times
  // Example: { 1: ["09:00", "14:00"], 2: ["10:00"] }
  final Map<int, List<String>> _daySlots = {};

  bool _isLoading = false;

  // Days will be initialized in build or fetched dynamically
  // But since we need them for display, let's use a method to get them localized
  List<String> _getDays(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return [
      loc.sunday,
      loc.monday,
      loc.tuesday,
      loc.wednesday,
      loc.thursday,
      loc.friday,
      loc.saturday,
    ];
  }

  @override
  void initState() {
    super.initState();
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() => _coverImage = File(pickedFile.path));
    }
  }

  void _addSlot(int dayIndex) async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) {
      final formattedTime =
          '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
      setState(() {
        final currentTimes = _daySlots[dayIndex + 1] ?? [];
        if (!currentTimes.contains(formattedTime)) {
          _daySlots[dayIndex + 1] = [...currentTimes, formattedTime];
        }
      });
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_coverImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.coverImageRequired),
        ),
      );
      return;
    }
    if (_daySlots.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.availableSlotsRequired),
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Format slots for API: [ { "day": 1, "times": ["09:00", "14:00"] }, ... ]
      final List<Map<String, dynamic>> formattedSlots = [];
      _daySlots.forEach((day, times) {
        formattedSlots.add({"day": day, "times": times});
      });

      final formData = FormData.fromMap({
        'name': _titleArController.text,
        'description': _descriptionController.text,
        'price': _priceController.text,
        'duration_hours': _durationController.text,
        'category_id': _selectedCategoryId,
        'education_level_id': _selectedLevelId,
        'subject_id': _selectedSubjectId,
        'course_type': _selectedType,
        'status': _selectedStatus,
        'cover_image': await MultipartFile.fromFile(
          _coverImage!.path,
          filename: 'cover.jpg',
        ),
      });

      for (int i = 0; i < formattedSlots.length; i++) {
        formData.fields.add(
          MapEntry(
            'available_slots[$i][day]',
            formattedSlots[i]['day'].toString(),
          ),
        );
        final times = formattedSlots[i]['times'] as List<String>;
        for (int j = 0; j < times.length; j++) {
          formData.fields.add(
            MapEntry('available_slots[$i][times][$j]', times[j]),
          );
        }
      }

      await ref.read(coursesProvider.notifier).createCourse(formData);

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.courseAddedSuccess),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("${AppLocalizations.of(context)!.errorPrefix}$e"),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final categoriesAsync = ref.watch(courseCategoriesProvider);
    final levelsAsync = ref.watch(educationLevelsProvider);
    final subjectsAsync = ref.watch(subjectsProvider);
    final days = _getDays(context);

    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.addCourse)),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                          image: _coverImage != null
                              ? DecorationImage(
                                  image: FileImage(_coverImage!),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        child: _coverImage == null
                            ? const Icon(
                                Icons.add_a_photo,
                                size: 40,
                                color: Colors.grey,
                              )
                            : null,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Categories Dropdown
                    categoriesAsync.when(
                      data: (categories) => DropdownButtonFormField<int>(
                        initialValue: _selectedCategoryId,
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(
                            context,
                          )!.courseCategories,
                        ),
                        items: categories
                            .map(
                              (c) => DropdownMenuItem(
                                value: c.id,
                                child: Text(
                                  Localizations.localeOf(
                                            context,
                                          ).languageCode ==
                                          'ar'
                                      ? c.nameAr
                                      : c.nameEn,
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (val) =>
                            setState(() => _selectedCategoryId = val),
                        validator: (v) => v == null
                            ? AppLocalizations.of(context)!.required
                            : null,
                      ),
                      loading: () => const LinearProgressIndicator(),
                      error: (e, s) => Text(
                        "${AppLocalizations.of(context)!.errorLoadingCategories}: $e",
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Levels Dropdown
                    levelsAsync.when(
                      data: (levels) => DropdownButtonFormField<int>(
                        initialValue: _selectedLevelId,
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(
                            context,
                          )!.educationLevel,
                        ),
                        items: levels
                            .map(
                              (l) => DropdownMenuItem(
                                value: l.id,
                                child: Text(l.name),
                              ),
                            )
                            .toList(),
                        onChanged: (val) =>
                            setState(() => _selectedLevelId = val),
                        validator: (v) => v == null
                            ? AppLocalizations.of(context)!.required
                            : null,
                      ),
                      loading: () => const SizedBox(),
                      error: (e, s) => const SizedBox(),
                    ),
                    const SizedBox(height: 16),
                    // Subjects Dropdown
                    subjectsAsync.when(
                      data: (subjects) => DropdownButtonFormField<int>(
                        initialValue: _selectedSubjectId,
                        decoration: InputDecoration(labelText: "المادة"),
                        items: subjects
                            .map(
                              (s) => DropdownMenuItem(
                                value: s.id,
                                child: Text(s.name),
                              ),
                            )
                            .toList(),
                        onChanged: (val) =>
                            setState(() => _selectedSubjectId = val),
                        validator: (v) => null,
                      ),
                      loading: () => const SizedBox(),
                      error: (e, s) => const SizedBox(),
                    ),
                    const SizedBox(height: 16),

                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            initialValue: _selectedType,
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(
                                context,
                              )!.courseType,
                            ),
                            items: [
                              DropdownMenuItem(
                                value: 'single',
                                child: Text(
                                  AppLocalizations.of(context)!.typeSingle,
                                ),
                              ),
                              DropdownMenuItem(
                                value: 'package',
                                child: Text(
                                  AppLocalizations.of(context)!.typePackage,
                                ),
                              ),
                              DropdownMenuItem(
                                value: 'subscription',
                                child: Text(
                                  AppLocalizations.of(
                                    context,
                                  )!.typeSubscription,
                                ),
                              ),
                            ],
                            onChanged: (val) =>
                                setState(() => _selectedType = val!),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            initialValue: _selectedStatus,
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(context)!.status,
                            ),
                            items: [
                              DropdownMenuItem(
                                value: 'draft',
                                child: Text(
                                  AppLocalizations.of(context)!.statusDraft,
                                ),
                              ),
                              DropdownMenuItem(
                                value: 'published',
                                child: Text(
                                  AppLocalizations.of(context)!.statusPublished,
                                ),
                              ),
                            ],
                            onChanged: (val) =>
                                setState(() => _selectedStatus = val!),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _titleArController,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.courseTitleAr,
                      ),
                      validator: (v) => v!.isEmpty
                          ? AppLocalizations.of(context)!.required
                          : null,
                    ),
                    TextFormField(
                      controller: _titleEnController,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.courseTitleEn,
                      ),
                    ),
                    TextFormField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.description,
                      ),
                      maxLines: 3,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _priceController,
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(context)!.price,
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            controller: _durationController,
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(context)!.hours,
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Text(
                      AppLocalizations.of(context)!.weeklyAvailableSlots,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...List.generate(7, (index) {
                      final dayNum = index + 1;
                      final times = _daySlots[dayNum] ?? [];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ExpansionTile(
                          title: Text("${days[index]} (${times.length})"),
                          trailing: IconButton(
                            icon: const Icon(Icons.add_circle_outline),
                            onPressed: () => _addSlot(index),
                          ),
                          children: [
                            if (times.isEmpty)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  AppLocalizations.of(context)!.noSlotsAdded,
                                ),
                              ),
                            Wrap(
                              spacing: 8,
                              children: times
                                  .map(
                                    (t) => Chip(
                                      label: Text(t),
                                      deleteIcon: const Icon(
                                        Icons.close,
                                        size: 18,
                                      ),
                                      onDeleted: () {
                                        setState(() {
                                          final currentTimes =
                                              _daySlots[dayNum] ?? [];
                                          currentTimes.remove(t);
                                          if (currentTimes.isEmpty) {
                                            _daySlots.remove(dayNum);
                                          } else {
                                            _daySlots[dayNum] = currentTimes;
                                          }
                                        });
                                      },
                                    ),
                                  )
                                  .toList(),
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      );
                    }),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _submit,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.saveCourse,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
