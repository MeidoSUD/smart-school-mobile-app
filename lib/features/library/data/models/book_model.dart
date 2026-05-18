// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'book_model.freezed.dart';
part 'book_model.g.dart';

@freezed
abstract class BookModel with _$BookModel {
  const factory BookModel({
    @Default(0) int id,
    @Default('') String title,
    String? author,
    @JsonKey(name: 'issue_date') String? issueDate,
    @JsonKey(name: 'return_date') String? returnDate,
  }) = _BookModel;
  
  factory BookModel.fromJson(Map<String, dynamic> json) =>
      _$BookModelFromJson(json);
}
