import 'package:geniuses_school/data/repositories/classroom_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'agora_provider.dart';

class ClassroomState {
  final bool isLoading;
  final bool isJoined;
  final String? error;
  final String? classroomId;
  final String? agoraToken;
  final int? agoraUid; // ADD THIS
  final String role; // teacher/student

  ClassroomState({
    this.isLoading = false,
    this.isJoined = false,
    this.error,
    this.classroomId,
    this.agoraToken,
    this.agoraUid, // ADD THIS
    this.role = 'student',
  });

  ClassroomState copyWith({
    bool? isLoading,
    bool? isJoined,
    String? error,
    String? classroomId,
    String? agoraToken,
    int? agoraUid, // ADD THIS
    String? role,
  }) {
    return ClassroomState(
      isLoading: isLoading ?? this.isLoading,
      isJoined: isJoined ?? this.isJoined,
      error: error,
      classroomId: classroomId ?? this.classroomId,
      agoraToken: agoraToken ?? this.agoraToken,
      agoraUid: agoraUid ?? this.agoraUid, // ADD THIS
      role: role ?? this.role,
    );
  }
}

final classroomProvider =
    StateNotifierProvider<ClassroomNotifier, ClassroomState>(
      (ref) => ClassroomNotifier(ref),
    );

class ClassroomNotifier extends StateNotifier<ClassroomState> {
  final Ref ref;
  late final ClassroomRepository repository;

  ClassroomNotifier(this.ref) : super(ClassroomState()) {
    repository = ClassroomRepository();
  }

  // Teacher creates classroom
  Future<void> createClassroom({required int session_id}) async {
    state = state.copyWith(isLoading: true, error: null, role: 'teacher');
    try {
      final data = await repository.createClassroom(sessionId: session_id);
      state = state.copyWith(
        isLoading: false,
        classroomId: data['classroomId'],
        agoraToken: data['agoraToken'],
        agoraUid: data['uid'], // STORE THE UID
        isJoined: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  // Student joins classroom
  Future<void> joinClassroom({
    required int studentId,
    required String classroomId,
  }) async {
    state = state.copyWith(isLoading: true, error: null, role: 'student');
    try {
      final data = await repository.joinClassroom(
        studentId: studentId,
        classroomId: classroomId,
      );
      state = state.copyWith(
        isLoading: false,
        classroomId: classroomId,
        agoraToken: data['agoraToken'],
        agoraUid: data['uid'], // STORE THE UID
        isJoined: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> agoraJoin() async {
    if (state.classroomId == null ||
        state.agoraToken == null ||
        state.agoraUid == null) {
      state = state.copyWith(error: 'Missing classroom credentials');
      return;
    }

    final agoraController = ref.read(agoraProvider.notifier);
    await agoraController.joinChannel(
      token: state.agoraToken!,
      channelName: state.classroomId!,
      uid: state.agoraUid!, // USE THE STORED UID
      role: state.role,
    );
    state = state.copyWith(isJoined: true);
  }

  Future<void> leaveAgora() async {
    final agoraController = ref.read(agoraProvider.notifier);
    await agoraController.leaveChannel();
    state = state.copyWith(isJoined: false);
  }
}
