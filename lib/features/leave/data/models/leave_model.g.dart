// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LeaveModel _$LeaveModelFromJson(Map<String, dynamic> json) => _LeaveModel(
  id: (json['id'] as num?)?.toInt() ?? 0,
  fromDate: json['from_date'] as String? ?? '',
  toDate: json['to_date'] as String? ?? '',
  reason: json['reason'] as String?,
  status: json['status'] as String? ?? 'pending',
  appliedDate: json['applied_date'] as String?,
);

Map<String, dynamic> _$LeaveModelToJson(_LeaveModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'from_date': instance.fromDate,
      'to_date': instance.toDate,
      'reason': instance.reason,
      'status': instance.status,
      'applied_date': instance.appliedDate,
    };
