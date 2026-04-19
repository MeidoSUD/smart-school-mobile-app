import 'package:dio/dio.dart';
import 'package:geniuses_school/data/models/course_model.dart';
import 'package:geniuses_school/data/models/course_category_model.dart';
import 'package:geniuses_school/data/models/level_model.dart';
import 'package:geniuses_school/data/models/subject_model.dart';
import 'package:geniuses_school/data/repositories/course_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CourseNotifier extends StateNotifier<AsyncValue<List<Course>>> {
  final CourseRepository _repository;

  CourseNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadCourses();
  }

  Future<void> loadCourses({int? categoryId}) async {
    state = const AsyncValue.loading();
    try {
      final courses = await _repository.getCourses(categoryId: categoryId);
      state = AsyncValue.data(courses);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> loadMyCourses() async {
    state = const AsyncValue.loading();
    try {
      final courses = await _repository.getMyCourses();
      state = AsyncValue.data(courses);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> createCourse(FormData formData) async {
    // state = const AsyncValue.loading(); // Don't reload whole list yet
    try {
      await _repository.createCourse(formData);
      await loadMyCourses(); // Reload after creation
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> updateCourse(int id, dynamic data) async {
    try {
      await _repository.updateCourse(id, data);
      await loadMyCourses();
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> deleteCourse(int id) async {
    try {
      await _repository.deleteCourse(id);
      await loadMyCourses();
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

final coursesProvider =
    StateNotifierProvider<CourseNotifier, AsyncValue<List<Course>>>((ref) {
      final repository = CourseRepository();
      return CourseNotifier(repository);
    });

final courseCategoriesProvider = FutureProvider<List<CourseCategory>>((
  ref,
) async {
  final repository = CourseRepository();
  return repository.getCourseCategories();
});

final educationLevelsProvider = FutureProvider<List<LevelModel>>((ref) async {
  final repository = CourseRepository();
  return repository.getEducationLevels();
});

final subjectsProvider = FutureProvider<List<SubjectModel>>((ref) async {
  final repository = CourseRepository();
  return repository.getSubjects();
});
