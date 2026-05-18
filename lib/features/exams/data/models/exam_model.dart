import 'package:freezed_annotation/freezed_annotation.dart';

part 'exam_model.freezed.dart';
part 'exam_model.g.dart';

@freezed
abstract class ExamModel with _$ExamModel {
  const factory ExamModel({
    @Default(0) int id,
    @Default('') String subject,
    String? date,
    String? time,
    String? room,
  }) = _ExamModel;
  
  factory ExamModel.fromJson(Map<String, dynamic> json) =>
      _$ExamModelFromJson(json);
}
