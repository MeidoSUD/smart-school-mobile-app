// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'leave_model.freezed.dart';
part 'leave_model.g.dart';

@freezed
abstract class LeaveModel with _$LeaveModel {
  const factory LeaveModel({
    @Default(0) int id,
    @JsonKey(name: 'from_date') @Default('') String fromDate,
    @JsonKey(name: 'to_date') @Default('') String toDate,
    String? reason,
    @Default('pending') String status,
    @JsonKey(name: 'applied_date') String? appliedDate,
  }) = _LeaveModel;
  
  factory LeaveModel.fromJson(Map<String, dynamic> json) =>
      _$LeaveModelFromJson(json);
}
