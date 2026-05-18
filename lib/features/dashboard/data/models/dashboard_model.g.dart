// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DashboardModel _$DashboardModelFromJson(Map<String, dynamic> json) =>
    _DashboardModel(
      attendancePercentage:
          (json['attendence_percentage'] as num?)?.toInt() ?? 0,
      homeworkList: json['homeworklist'] as List<dynamic>? ?? const [],
      notificationList: json['notificationlist'] as List<dynamic>? ?? const [],
      subjectsData: json['subjects_data'] as Map<String, dynamic>? ?? const {},
      timetable: json['timetable'] as Map<String, dynamic>? ?? const {},
      visitorList: json['visitor_list'] as List<dynamic>? ?? const [],
      bookList: json['bookList'] as List<dynamic>? ?? const [],
      teacherList: json['teacherlist'] as List<dynamic>? ?? const [],
    );

Map<String, dynamic> _$DashboardModelToJson(_DashboardModel instance) =>
    <String, dynamic>{
      'attendence_percentage': instance.attendancePercentage,
      'homeworklist': instance.homeworkList,
      'notificationlist': instance.notificationList,
      'subjects_data': instance.subjectsData,
      'timetable': instance.timetable,
      'visitor_list': instance.visitorList,
      'bookList': instance.bookList,
      'teacherlist': instance.teacherList,
    };
