import 'package:geniuses_school/data/models/subject_model.dart';
import 'package:geniuses_school/data/repositories/subjects_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final subjectRepositoryProvider = Provider((ref) => SubjectsRepository());

class SubjectsNotifier extends AsyncNotifier<List<SubjectModel>> {
  @override
  Future<List<SubjectModel>> build() async {
    final repo = ref.read(subjectRepositoryProvider);
    return await repo.getSubjects();
  }

  Future<void> updateSubject() async {
    final previousSubjects = state.value; // ✅ save first
    if (previousSubjects == null) return;

    state = const AsyncLoading();

    try {
      final repo = ref.read(subjectRepositoryProvider);
      final subjects = previousSubjects.map((s) => s.id).toList();

      await repo.updateSubject(subjects);

      // refresh list
      final updatedSubjects = await repo.getSubjects();
      state = AsyncData(updatedSubjects);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

final subjectsProvider =
    AsyncNotifierProvider<SubjectsNotifier, List<SubjectModel>>(() {
      return SubjectsNotifier();
    });

class PublicSubjectsNotifier extends AsyncNotifier<List<SubjectModel>> {
  @override
  Future<List<SubjectModel>> build() async {
    final repo = ref.read(subjectRepositoryProvider);
    return await repo.getCommonSubjects();
  }
}

final publicSubjectsProvider =
    AsyncNotifierProvider<PublicSubjectsNotifier, List<SubjectModel>>(() {
      return PublicSubjectsNotifier();
    });
