import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/models/online_exam_model.dart';

part 'online_exam_state.freezed.dart';

@freezed
abstract class OnlineExamState with _$OnlineExamState {
  const factory OnlineExamState.initial() = _Initial;
  const factory OnlineExamState.loading() = _Loading;
  const factory OnlineExamState.loaded(List<OnlineExamModel> exams) = _Loaded;
  const factory OnlineExamState.error(String message) = _Error;
}
