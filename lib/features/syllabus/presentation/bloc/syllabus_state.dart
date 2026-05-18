import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/models/syllabus_model.dart';

part 'syllabus_state.freezed.dart';

@freezed
class SyllabusState with _$SyllabusState {
  const factory SyllabusState.initial() = _Initial;
  const factory SyllabusState.loading() = _Loading;
  const factory SyllabusState.loaded(List<SyllabusModel> syllabus) = _Loaded;
  const factory SyllabusState.error(String message) = _Error;
}
