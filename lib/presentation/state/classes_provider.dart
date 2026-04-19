

import 'package:geniuses_school/data/models/class_model.dart';
import 'package:geniuses_school/data/repositories/classes_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final classesRepositoryProvider = Provider((ref) => ClassesRepository());

class ClassesNotifier extends AsyncNotifier<List<ClassModel>> {
  int? levelId;

  ClassesNotifier({this.levelId});

  @override
  Future<List<ClassModel>> build() async {
    final repo = ref.read(classesRepositoryProvider);
    return await repo.getClasses(levelId: levelId);
  }
}

final classesProvider =
    AsyncNotifierProvider<ClassesNotifier, List<ClassModel>>(() {
  return ClassesNotifier();
});