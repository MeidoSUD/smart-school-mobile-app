// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'hostel_model.freezed.dart';
part 'hostel_model.g.dart';

@freezed
abstract class HostelModel with _$HostelModel {
  const factory HostelModel({
    @Default('') String name,
    @JsonKey(name: 'room_number') String? roomNumber,
    String? block,
    @JsonKey(name: 'bed_number') String? bedNumber,
  }) = _HostelModel;
  
  factory HostelModel.fromJson(Map<String, dynamic> json) =>
      _$HostelModelFromJson(json);
}
