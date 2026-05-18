import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/models/teacher_model.dart';

part 'teachers_state.freezed.dart';

@freezed
class TeachersState with _$TeachersState {
  const factory TeachersState.initial() = _Initial;
  const factory TeachersState.loading() = _Loading;
  const factory TeachersState.loaded(List<TeacherModel> teachers) = _Loaded;
  const factory TeachersState.error(String message) = _Error;
}
