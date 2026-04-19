import 'package:geniuses_school/core/utils/logger.dart';
import 'package:geniuses_school/data/repositories/lessons_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/session_model.dart';
import 'auth_provider.dart';

class LessonsNotifier extends StateNotifier<AsyncValue<SessionsResponse>> {
  final LessonsRepository _repository;
  final int roleId;

  LessonsNotifier(this._repository, this.roleId)
    : super(const AsyncValue.loading()) {
    // Initial load or setup can be done here
    loadLessons();
  }

  Future<void> loadLessons() async {
    state = const AsyncValue.loading();
    try {
      final lessons = await _repository.getLessons(roleId: roleId);
      Logger.log("lessons loaded: $lessons");
      state = AsyncValue.data(lessons);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  // Implementation of LessonsNotifier
}

final lessonsRepositoryProvider = Provider((ref) => LessonsRepository());

final lessonsProvider =
    StateNotifierProvider<LessonsNotifier, AsyncValue<SessionsResponse>>((ref) {
      final repository = ref.watch(lessonsRepositoryProvider);
      final authState = ref.watch(authProvider);
      // Default to student (4) if role is not available, though it should be if logged in.
      // If not logged in, the repository might fail on token anyway.
      final roleId = authState.user?.role_id ?? 4;
      return LessonsNotifier(repository, roleId);
    });
