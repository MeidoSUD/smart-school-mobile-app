// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TeacherModel _$TeacherModelFromJson(Map<String, dynamic> json) =>
    _TeacherModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
      photo: json['photo'] as String?,
      subject: json['subject'] as String?,
      phone: json['phone'] as String?,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$TeacherModelToJson(_TeacherModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'photo': instance.photo,
      'subject': instance.subject,
      'phone': instance.phone,
      'rating': instance.rating,
    };
