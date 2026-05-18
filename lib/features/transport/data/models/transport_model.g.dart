// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transport_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TransportModel _$TransportModelFromJson(Map<String, dynamic> json) =>
    _TransportModel(
      route: json['route'] as String? ?? '',
      driverName: json['driver_name'] as String?,
      driverPhone: json['driver_phone'] as String?,
      busNumber: json['bus_number'] as String?,
      pickupTime: json['pickup_time'] as String?,
      pickupPoint: json['pickup_point'] as String?,
    );

Map<String, dynamic> _$TransportModelToJson(_TransportModel instance) =>
    <String, dynamic>{
      'route': instance.route,
      'driver_name': instance.driverName,
      'driver_phone': instance.driverPhone,
      'bus_number': instance.busNumber,
      'pickup_time': instance.pickupTime,
      'pickup_point': instance.pickupPoint,
    };
