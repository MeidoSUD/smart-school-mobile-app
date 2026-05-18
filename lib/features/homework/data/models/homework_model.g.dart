// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'homework_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HomeworkModel _$HomeworkModelFromJson(Map<String, dynamic> json) =>
    _HomeworkModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      title: json['title'] as String? ?? '',
      description: json['description'] as String?,
      subject: json['subject'] as String?,
      dueDate: json['due_date'] as String?,
      status: json['status'] as String?,
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$HomeworkModelToJson(_HomeworkModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'subject': instance.subject,
      'due_date': instance.dueDate,
      'status': instance.status,
      'created_at': instance.createdAt,
    };
