// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'homework_model.freezed.dart';
part 'homework_model.g.dart';

@freezed
abstract class HomeworkModel with _$HomeworkModel {
  const factory HomeworkModel({
    @Default(0) int id,
    @Default('') String title,
    String? description,
    String? subject,
    @JsonKey(name: 'due_date') String? dueDate,
    String? status,
    @JsonKey(name: 'created_at') String? createdAt,
  }) = _HomeworkModel;
  
  factory HomeworkModel.fromJson(Map<String, dynamic> json) =>
      _$HomeworkModelFromJson(json);
}
