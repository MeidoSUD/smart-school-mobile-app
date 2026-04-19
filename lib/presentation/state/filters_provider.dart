import 'package:geniuses_school/data/repositories/filters_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final filtersRepositoryProvider = Provider((ref) => FiltersRepository());

// Provider for available services
final servicesProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final repo = ref.watch(filtersRepositoryProvider);
  return repo.getServices();
});

// Provider for education levels
final educationLevelsProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final repo = ref.watch(filtersRepositoryProvider);
  return repo.getEducationLevels();
});

// Provider for classes by level
final classesByLevelProvider = FutureProvider.family<List<Map<String, dynamic>>, int>((ref, levelId) async {
  final repo = ref.watch(filtersRepositoryProvider);
  return repo.getClassesByLevel(levelId);
});

// Provider for subjects by class
final subjectsByClassProvider = FutureProvider.family<List<Map<String, dynamic>>, int>((ref, classId) async {
  final repo = ref.watch(filtersRepositoryProvider);
  return repo.getSubjectsByClass(classId);
});
