import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/models/calendar_event_model.dart';

part 'calendar_state.freezed.dart';

@freezed
abstract class CalendarState with _$CalendarState {
  const factory CalendarState.initial() = _Initial;
  const factory CalendarState.loading() = _Loading;
  const factory CalendarState.loaded(List<CalendarEventModel> events) = _Loaded;
  const factory CalendarState.error(String message) = _Error;
}
