import 'package:freezed_annotation/freezed_annotation.dart';

part 'syllabus_model.freezed.dart';
part 'syllabus_model.g.dart';

@freezed
abstract class SyllabusModel with _$SyllabusModel {
  const factory SyllabusModel({
    @Default(0) int id,
    @Default('') String subject,
    String? topic,
    String? status,
  }) = _SyllabusModel;
  
  factory SyllabusModel.fromJson(Map<String, dynamic> json) =>
      _$SyllabusModelFromJson(json);
}
