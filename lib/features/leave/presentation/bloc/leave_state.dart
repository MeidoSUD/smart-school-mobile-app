import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/models/leave_model.dart';

part 'leave_state.freezed.dart';

@freezed
abstract class LeaveState with _$LeaveState {
  const factory LeaveState.initial() = _Initial;
  const factory LeaveState.loading() = _Loading;
  const factory LeaveState.loaded(List<LeaveModel> leaves) = _Loaded;
  const factory LeaveState.error(String message) = _Error;
}
