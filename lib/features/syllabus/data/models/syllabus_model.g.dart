// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'syllabus_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SyllabusModel _$SyllabusModelFromJson(Map<String, dynamic> json) =>
    _SyllabusModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      subject: json['subject'] as String? ?? '',
      topic: json['topic'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$SyllabusModelToJson(_SyllabusModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'subject': instance.subject,
      'topic': instance.topic,
      'status': instance.status,
    };
