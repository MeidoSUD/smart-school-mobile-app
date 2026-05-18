import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/models/attendance_model.dart';

part 'attendance_state.freezed.dart';

@freezed
class AttendanceState with _$AttendanceState {
  const factory AttendanceState.initial() = _Initial;
  const factory AttendanceState.loading() = _Loading;
  const factory AttendanceState.loaded(List<AttendanceModel> attendance) = _Loaded;
  const factory AttendanceState.error(String message) = _Error;
}
