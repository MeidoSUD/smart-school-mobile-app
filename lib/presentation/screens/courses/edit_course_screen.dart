import 'dart:convert';
import 'dart:io';
// ignore: unused_import
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:geniuses_school/data/models/course_model.dart';
import 'package:geniuses_school/l10n/app_localizations.dart';
import 'package:geniuses_school/presentation/state/courses_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class EditCourseScreen extends ConsumerStatefulWidget {
  final Course course;
  const EditCourseScreen({super.key, required this.course});

  @override
  ConsumerState<EditCourseScreen> createState() => _EditCourseScreenState();
}

class _EditCourseScreenState extends ConsumerState<EditCourseScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleArController;
  late TextEditingController _titleEnController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;
  late TextEditingController _durationController;

  int? _selectedCategoryId;
  int? _selectedLevelId;
  int? _selectedSubjectId;
  String _selectedType = 'single';
  String _selectedStatus = 'draft';

  File? _newCoverImage;
  // Slots: mapping day (1-7) to a list of slot details. Each slot detail is a map like {'id': slotId, 'time': 'HH:MM'}.
  // NOTE: Backend uses 1=Sunday..7=Saturday usually, but we need to check consistent usage. In AddCourseScreen: 1=Sunday.
  final Map<int, List<Map<String, dynamic>>> _daySlots = {};

  bool _isLoading = false;

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
    _titleArController = TextEditingController(text: widget.course.title);
    _titleEnController = TextEditingController();
    _descriptionController = TextEditingController(
      text: widget.course.description,
    );
    _priceController = TextEditingController(
      text: widget.course.price.toString(),
    );
    _durationController = TextEditingController(
      text: widget.course.hours.toString(),
    );
    _selectedCategoryId = widget.course.categoryId;
    _selectedLevelId = widget.course.levelId;
    _selectedSubjectId = widget.course.subjectId;
    _selectedType = widget.course.type ?? 'single';
    _selectedStatus = widget.course.status ?? 'draft';

    // Parse existing slots from widget.course.rawSlots
    // rawSlots structure: [{ 'day_number': 1, 'start_time': '09:00:00', ...}]
    if (widget.course.rawSlots.isNotEmpty) {
      for (var slot in widget.course.rawSlots) {
        if (slot == null) continue;
        int? day = int.tryParse(slot['day_number']?.toString() ?? '');
        // If day_number is missing, try 'day'
        day ??= int.tryParse(slot['day']?.toString() ?? '');

        String? start = slot['start_time']?.toString();
        int? slotId = slot['id'] is int
            ? slot['id']
            : int.tryParse(slot['id']?.toString() ?? '');

        if (day != null && start != null && start.length >= 5) {
          final timeStr = start.substring(0, 5);
          final currentList = _daySlots[day] ?? [];

          final alreadyExists = currentList.any((s) => s['time'] == timeStr);
          if (!alreadyExists) {
            _daySlots[day] = [
              ...currentList,
              {'id': slotId, 'time': timeStr},
            ];
          }
        }
      }
    }
  }

  @override
  void dispose() {
    _titleArController.dispose();
    _titleEnController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _durationController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() => _newCoverImage = File(pickedFile.path));
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
        final alreadyExists = currentTimes.any(
          (s) => s['time'] == formattedTime,
        );
        if (!alreadyExists) {
          _daySlots[dayIndex + 1] = [
            ...currentTimes,
            {'id': null, 'time': formattedTime},
          ];
        }
      });
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    // Validate slots (must match AddCourseScreen logic)
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
      final List<Map<String, dynamic>> formattedSlots = [];

      _daySlots.forEach((day, slotsList) {
        for (var slotData in slotsList) {
          final slotMap = {
            "day": day,
            "times": [slotData['time']],
          };

          if (slotData['id'] != null) {
            slotMap['id'] = slotData['id'];
          }

          formattedSlots.add(slotMap);
        }
      });

      final Map<String, dynamic> data = {
        '_method': 'PUT',
        'name': _titleArController.text,
        'description': _descriptionController.text,
        'price': _priceController.text,
        'duration_hours': _durationController.text,
        'category_id': _selectedCategoryId,
        'education_level_id': _selectedLevelId,
        'subject_id': _selectedSubjectId,
        'course_type': _selectedType,
        'status': _selectedStatus,
      };

      final formData = FormData.fromMap(data);

      if (formattedSlots.isNotEmpty) {
        for (int i = 0; i < formattedSlots.length; i++) {
          if (formattedSlots[i]['id'] != null) {
            formData.fields.add(
              MapEntry(
                'available_slots[$i][id]',
                formattedSlots[i]['id'].toString(),
              ),
            );
          }

          formData.fields.add(
            MapEntry(
              'available_slots[$i][day]',
              formattedSlots[i]['day'].toString(),
            ),
          );

          final times = formattedSlots[i]['times'] as List;
          for (int j = 0; j < times.length; j++) {
            formData.fields.add(
              MapEntry('available_slots[$i][times][$j]', times[j].toString()),
            );
          }
        }
      }

      if (_newCoverImage != null) {
        formData.files.add(
          MapEntry(
            'cover_image',
            await MultipartFile.fromFile(
              _newCoverImage!.path,
              filename: 'cover_updated.jpg',
            ),
          ),
        );
      }

      await ref
          .read(coursesProvider.notifier)
          .updateCourse(widget.course.id, formData);

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.courseUpdatedSuccess),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("${AppLocalizations.of(context)!.errorPrefix}: $e"),
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
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.editCourse)),
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
                          image: _newCoverImage != null
                              ? DecorationImage(
                                  image: FileImage(_newCoverImage!),
                                  fit: BoxFit.cover,
                                )
                              : widget.course.image.isNotEmpty
                              ? DecorationImage(
                                  image: NetworkImage(widget.course.image),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        child:
                            (_newCoverImage == null &&
                                widget.course.image.isEmpty)
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
                          labelText: AppLocalizations.of(context)!.category,
                        ),
                        items: categories
                            .map(
                              (c) => DropdownMenuItem(
                                value: c.id,
                                child: Text(c.nameAr),
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
                            keyboardType: TextInputType.number,
                            controller: _priceController,
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(context)!.price,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: _durationController,
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(context)!.hours,
                            ),
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
                                    (slotData) => Chip(
                                      label: Text(slotData['time'] as String),
                                      deleteIcon: const Icon(
                                        Icons.close,
                                        size: 18,
                                      ),
                                      onDeleted: () {
                                        setState(() {
                                          final currentTimes =
                                              _daySlots[dayNum] ?? [];
                                          currentTimes.remove(slotData);
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
                          AppLocalizations.of(context)!.updateCourse,
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
