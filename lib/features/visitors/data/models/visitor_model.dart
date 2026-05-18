// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'visitor_model.freezed.dart';
part 'visitor_model.g.dart';

@freezed
abstract class VisitorModel with _$VisitorModel {
  const factory VisitorModel({
    @Default(0) int id,
    @Default('') String name,
    String? reason,
    @JsonKey(name: 'visit_date') String? visitDate,
    String? phone,
  }) = _VisitorModel;
  
  factory VisitorModel.fromJson(Map<String, dynamic> json) =>
      _$VisitorModelFromJson(json);
}
