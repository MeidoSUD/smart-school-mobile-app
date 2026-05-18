// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'lms_user_model.freezed.dart';
part 'lms_user_model.g.dart';

@freezed
abstract class LmsUserModel with _$LmsUserModel {
  const factory LmsUserModel({
    @Default(0) int id,
    @Default('') String role,
    @Default('') String firstname,
    @Default('') String lastname,
    String? email,
    String? phone,
    String? photo,
    String? gender,
    String? nationality,
    @JsonKey(name: 'student_id') String? studentId,
    @JsonKey(name: 'parent_phone') String? parentPhone,
  }) = _LmsUserModel;
  
  factory LmsUserModel.fromJson(Map<String, dynamic> json) =>
      _$LmsUserModelFromJson(json);
}

extension LmsUserModelX on LmsUserModel {
  String get fullName => '$firstname $lastname';
}
