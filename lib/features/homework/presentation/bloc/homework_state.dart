import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/models/homework_model.dart';
part 'homework_state.freezed.dart';

@freezed
class HomeworkState with _$HomeworkState {
  const factory HomeworkState.initial() = _Initial;
  const factory HomeworkState.loading() = _Loading;
  const factory HomeworkState.loaded(List<HomeworkModel> homework) = _Loaded;
  const factory HomeworkState.error(String message) = _Error;
}
