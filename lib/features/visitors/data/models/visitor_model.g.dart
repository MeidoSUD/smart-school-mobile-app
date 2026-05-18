// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visitor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VisitorModel _$VisitorModelFromJson(Map<String, dynamic> json) =>
    _VisitorModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
      reason: json['reason'] as String?,
      visitDate: json['visit_date'] as String?,
      phone: json['phone'] as String?,
    );

Map<String, dynamic> _$VisitorModelToJson(_VisitorModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'reason': instance.reason,
      'visit_date': instance.visitDate,
      'phone': instance.phone,
    };
