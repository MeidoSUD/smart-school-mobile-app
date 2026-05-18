import 'package:freezed_annotation/freezed_annotation.dart';

part 'timetable_model.freezed.dart';
part 'timetable_model.g.dart';

@freezed
abstract class TimetableModel with _$TimetableModel {
  const factory TimetableModel({
    @Default(0) int id,
    @Default('') String day,
    @Default('') String subject,
    @Default('') String time,
    String? room,
  }) = _TimetableModel;
  
  factory TimetableModel.fromJson(Map<String, dynamic> json) =>
      _$TimetableModelFromJson(json);
}
