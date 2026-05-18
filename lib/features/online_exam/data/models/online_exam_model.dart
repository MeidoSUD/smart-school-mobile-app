// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'online_exam_model.freezed.dart';
part 'online_exam_model.g.dart';

@freezed
abstract class OnlineExamModel with _$OnlineExamModel {
  const factory OnlineExamModel({
    @Default(0) int id,
    @Default('') String title,
    String? subject,
    int? duration,
    @JsonKey(name: 'total_questions') int? totalQuestions,
    String? status,
  }) = _OnlineExamModel;
  
  factory OnlineExamModel.fromJson(Map<String, dynamic> json) =>
      _$OnlineExamModelFromJson(json);
}
