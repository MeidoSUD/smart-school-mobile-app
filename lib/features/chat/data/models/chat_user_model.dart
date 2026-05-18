// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_user_model.freezed.dart';
part 'chat_user_model.g.dart';

@freezed
abstract class ChatUserModel with _$ChatUserModel {
  const factory ChatUserModel({
    @Default(0) int id,
    @Default('') String name,
    String? photo,
    @JsonKey(name: 'last_message') String? lastMessage,
    String? time,
  }) = _ChatUserModel;
  
  factory ChatUserModel.fromJson(Map<String, dynamic> json) =>
      _$ChatUserModelFromJson(json);
}
