// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timetable_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TimetableModel _$TimetableModelFromJson(Map<String, dynamic> json) =>
    _TimetableModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      day: json['day'] as String? ?? '',
      subject: json['subject'] as String? ?? '',
      time: json['time'] as String? ?? '',
      room: json['room'] as String?,
    );

Map<String, dynamic> _$TimetableModelToJson(_TimetableModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'day': instance.day,
      'subject': instance.subject,
      'time': instance.time,
      'room': instance.room,
    };
