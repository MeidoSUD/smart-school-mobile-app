import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/models/exam_model.dart';
part 'exams_state.freezed.dart';

@freezed
class ExamsState with _$ExamsState {
  const factory ExamsState.initial() = _Initial;
  const factory ExamsState.loading() = _Loading;
  const factory ExamsState.loaded(List<ExamModel> exams) = _Loaded;
  const factory ExamsState.error(String message) = _Error;
}
