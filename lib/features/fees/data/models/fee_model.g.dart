// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fee_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FeeModel _$FeeModelFromJson(Map<String, dynamic> json) => _FeeModel(
  id: (json['id'] as num?)?.toInt() ?? 0,
  title: json['title'] as String? ?? '',
  amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
  dueDate: json['due_date'] as String?,
  status: json['status'] as String?,
  description: json['description'] as String?,
);

Map<String, dynamic> _$FeeModelToJson(_FeeModel instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'amount': instance.amount,
  'due_date': instance.dueDate,
  'status': instance.status,
  'description': instance.description,
};
