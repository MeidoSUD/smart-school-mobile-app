import '../../../../core/network/api_result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/usecases/get_attendance_usecase.dart';
import 'attendance_state.dart';

@injectable
class AttendanceCubit extends Cubit<AttendanceState> {
  final GetAttendanceUseCase _getAttendanceUseCase;

  AttendanceCubit(this._getAttendanceUseCase)
    : super(const AttendanceState.initial());

  Future<void> loadAttendance({String? start, String? end}) async {
    emit(const AttendanceState.loading());

    final result = await _getAttendanceUseCase.execute(start: start, end: end);

    result.when(
      success: (attendance) {
        emit(AttendanceState.loaded(attendance));
      },
      failure: (failure) {
        emit(AttendanceState.error(failure.message));
      },
    );
  }
}
