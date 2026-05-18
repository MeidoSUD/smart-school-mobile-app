import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/models/timetable_model.dart';
part 'timetable_state.freezed.dart';

@freezed
class TimetableState with _$TimetableState {
  const factory TimetableState.initial() = _Initial;
  const factory TimetableState.loading() = _Loading;
  const factory TimetableState.loaded(List<TimetableModel> timetable) = _Loaded;
  const factory TimetableState.error(String message) = _Error;
}
