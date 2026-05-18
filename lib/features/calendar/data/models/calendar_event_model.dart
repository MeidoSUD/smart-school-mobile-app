import 'package:freezed_annotation/freezed_annotation.dart';

part 'calendar_event_model.freezed.dart';
part 'calendar_event_model.g.dart';

@freezed
abstract class CalendarEventModel with _$CalendarEventModel {
  const factory CalendarEventModel({
    @Default(0) int id,
    @Default('') String title,
    String? description,
    @Default('') String date,
    String? time,
  }) = _CalendarEventModel;
  
  factory CalendarEventModel.fromJson(Map<String, dynamic> json) =>
      _$CalendarEventModelFromJson(json);
}
