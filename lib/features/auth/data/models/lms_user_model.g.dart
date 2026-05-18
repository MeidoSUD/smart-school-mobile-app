// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lms_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LmsUserModel _$LmsUserModelFromJson(Map<String, dynamic> json) =>
    _LmsUserModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      role: json['role'] as String? ?? '',
      firstname: json['firstname'] as String? ?? '',
      lastname: json['lastname'] as String? ?? '',
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      photo: json['photo'] as String?,
      gender: json['gender'] as String?,
      nationality: json['nationality'] as String?,
      studentId: json['student_id'] as String?,
      parentPhone: json['parent_phone'] as String?,
    );

Map<String, dynamic> _$LmsUserModelToJson(_LmsUserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'role': instance.role,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'email': instance.email,
      'phone': instance.phone,
      'photo': instance.photo,
      'gender': instance.gender,
      'nationality': instance.nationality,
      'student_id': instance.studentId,
      'parent_phone': instance.parentPhone,
    };
