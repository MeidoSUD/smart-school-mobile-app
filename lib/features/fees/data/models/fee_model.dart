// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'fee_model.freezed.dart';
part 'fee_model.g.dart';

@freezed
abstract class FeeModel with _$FeeModel {
  const factory FeeModel({
    @Default(0) int id,
    @Default('') String title,
    @Default(0.0) double amount,
    @JsonKey(name: 'due_date') String? dueDate,
    String? status,
    String? description,
  }) = _FeeModel;
  
  factory FeeModel.fromJson(Map<String, dynamic> json) =>
      _$FeeModelFromJson(json);
}
