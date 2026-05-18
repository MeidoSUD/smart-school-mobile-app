// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exam_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ExamModel _$ExamModelFromJson(Map<String, dynamic> json) => _ExamModel(
  id: (json['id'] as num?)?.toInt() ?? 0,
  subject: json['subject'] as String? ?? '',
  date: json['date'] as String?,
  time: json['time'] as String?,
  room: json['room'] as String?,
);

Map<String, dynamic> _$ExamModelToJson(_ExamModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'subject': instance.subject,
      'date': instance.date,
      'time': instance.time,
      'room': instance.room,
    };
