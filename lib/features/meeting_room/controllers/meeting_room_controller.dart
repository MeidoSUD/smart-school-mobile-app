import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/logger.dart';
import '../data/models/meeting_room_model.dart';
import '../data/repositories/meeting_room_repository.dart';

class MeetingRoomNotifier
    extends StateNotifier<AsyncValue<MeetingRoomResponse?>> {
  final MeetingRoomRepository _repository;

  MeetingRoomNotifier(this._repository) : super(const AsyncValue.data(null));

  Future<MeetingRoomResponse?> createSession(int sessionId) async {
    state = const AsyncValue.loading();
    try {
      final response = await _repository.createSession(sessionId);
      if (response.success == true && response.data != null) {
        state = AsyncValue.data(response);
        return response;
      } else {
        state = AsyncValue.error(
          response.message ?? "Failed to start session",
          StackTrace.current,
        );
        return null; // Or throw
      }
    } catch (e, stack) {
      Logger.log("Error creating session: $e");
      state = AsyncValue.error(e, stack);
      rethrow;
    }
  }

  Future<MeetingRoomResponse?> joinSession(int sessionId) async {
    state = const AsyncValue.loading();
    try {
      final response = await _repository.joinSession(sessionId);
      if (response.success == true && response.data != null) {
        state = AsyncValue.data(response);
        return response;
      } else {
        state = AsyncValue.error(
          response.message ?? "Failed to join session",
          StackTrace.current,
        );
        return null;
      }
    } catch (e, stack) {
      Logger.log("Error joining session: $e");
      state = AsyncValue.error(e, stack);
      rethrow;
    }
  }

  Future<MeetingRoomResponse?> endSession(int sessionId) async {
    state = const AsyncValue.loading();
    try {
      final response = await _repository.endSession(sessionId);
      if (response.success == true) {
        state = AsyncValue.data(response);
        return response;
      } else {
        state = AsyncValue.error(
          response.message ?? "Failed to end session",
          StackTrace.current,
        );
        return null;
      }
    } catch (e, stack) {
      Logger.log("Error ending session: $e");
      state = AsyncValue.error(e, stack);
      rethrow;
    }
  }
}

final meetingRoomRepositoryProvider = Provider(
  (ref) => MeetingRoomRepository(),
);

final meetingRoomProvider =
    StateNotifierProvider<
      MeetingRoomNotifier,
      AsyncValue<MeetingRoomResponse?>
    >((ref) {
      final repository = ref.watch(meetingRoomRepositoryProvider);
      return MeetingRoomNotifier(repository);
    });
