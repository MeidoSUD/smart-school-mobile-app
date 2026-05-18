// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hostel_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HostelModel _$HostelModelFromJson(Map<String, dynamic> json) => _HostelModel(
  name: json['name'] as String? ?? '',
  roomNumber: json['room_number'] as String?,
  block: json['block'] as String?,
  bedNumber: json['bed_number'] as String?,
);

Map<String, dynamic> _$HostelModelToJson(_HostelModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'room_number': instance.roomNumber,
      'block': instance.block,
      'bed_number': instance.bedNumber,
    };
