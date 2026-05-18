import 'package:freezed_annotation/freezed_annotation.dart';

part 'subject_model.freezed.dart';
part 'subject_model.g.dart';

@freezed
abstract class SubjectModel with _$SubjectModel {
  const factory SubjectModel({
    @Default(0) int id,
    @Default('') String name,
    String? code,
    String? teacher,
  }) = _SubjectModel;
  
  factory SubjectModel.fromJson(Map<String, dynamic> json) =>
      _$SubjectModelFromJson(json);
}
