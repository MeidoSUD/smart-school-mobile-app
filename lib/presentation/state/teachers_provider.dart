import 'package:geniuses_school/data/models/teacher_model.dart';
import 'package:geniuses_school/data/repositories/teachers_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final teachersRepositoryProvider = Provider((ref) => TeachersRepository());

final teachersProvider = FutureProvider<List<TeacherModel>>((ref) async {
  final repo = ref.watch(teachersRepositoryProvider);
  return repo.getTeachers();
});

// Provider for teachers filtered by service ID
final teachersByServiceProvider = FutureProvider.family<List<TeacherModel>, int>((ref, serviceId) async {
  final repo = ref.watch(teachersRepositoryProvider);
  return repo.getTeachersWithFilters(serviceId: serviceId);
});
