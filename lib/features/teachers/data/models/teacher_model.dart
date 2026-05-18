import 'package:freezed_annotation/freezed_annotation.dart';

part 'teacher_model.freezed.dart';
part 'teacher_model.g.dart';

@freezed
abstract class TeacherModel with _$TeacherModel {
  const factory TeacherModel({
    @Default(0) int id,
    @Default('') String name,
    String? photo,
    String? subject,
    String? phone,
    @Default(0.0) double rating,
  }) = _TeacherModel;
  
  factory TeacherModel.fromJson(Map<String, dynamic> json) =>
      _$TeacherModelFromJson(json);
}
