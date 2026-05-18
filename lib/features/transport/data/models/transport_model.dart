// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'transport_model.freezed.dart';
part 'transport_model.g.dart';

@freezed
abstract class TransportModel with _$TransportModel {
  const factory TransportModel({
    @Default('') String route,
    @JsonKey(name: 'driver_name') String? driverName,
    @JsonKey(name: 'driver_phone') String? driverPhone,
    @JsonKey(name: 'bus_number') String? busNumber,
    @JsonKey(name: 'pickup_time') String? pickupTime,
    @JsonKey(name: 'pickup_point') String? pickupPoint,
  }) = _TransportModel;
  
  factory TransportModel.fromJson(Map<String, dynamic> json) =>
      _$TransportModelFromJson(json);
}
