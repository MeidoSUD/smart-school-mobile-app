// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'online_exam_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OnlineExamModel _$OnlineExamModelFromJson(Map<String, dynamic> json) =>
    _OnlineExamModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      title: json['title'] as String? ?? '',
      subject: json['subject'] as String?,
      duration: (json['duration'] as num?)?.toInt(),
      totalQuestions: (json['total_questions'] as num?)?.toInt(),
      status: json['status'] as String?,
    );

Map<String, dynamic> _$OnlineExamModelToJson(_OnlineExamModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'subject': instance.subject,
      'duration': instance.duration,
      'total_questions': instance.totalQuestions,
      'status': instance.status,
    };
