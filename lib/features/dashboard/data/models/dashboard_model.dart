// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard_model.freezed.dart';
part 'dashboard_model.g.dart';

@freezed
abstract class DashboardModel with _$DashboardModel {
  const factory DashboardModel({
    @JsonKey(name: 'attendence_percentage') @Default(0) int attendancePercentage,
    @JsonKey(name: 'homeworklist') @Default([]) List<dynamic> homeworkList,
    @JsonKey(name: 'notificationlist') @Default([]) List<dynamic> notificationList,
    @JsonKey(name: 'subjects_data') @Default({}) Map<String, dynamic> subjectsData,
    @JsonKey(name: 'timetable') @Default({}) Map<String, dynamic> timetable,
    @JsonKey(name: 'visitor_list') @Default([]) List<dynamic> visitorList,
    @JsonKey(name: 'bookList') @Default([]) List<dynamic> bookList,
    @JsonKey(name: 'teacherlist') @Default([]) List<dynamic> teacherList,
  }) = _DashboardModel;
  
  factory DashboardModel.fromJson(Map<String, dynamic> json) =>
      _$DashboardModelFromJson(json);
}
