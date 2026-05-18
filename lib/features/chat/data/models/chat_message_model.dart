// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_message_model.freezed.dart';
part 'chat_message_model.g.dart';

@freezed
abstract class ChatMessageModel with _$ChatMessageModel {
  const factory ChatMessageModel({
    @Default(0) int id,
    @Default('') String message,
    @Default('') String sender,
    @Default('') String time,
    @JsonKey(name: 'is_me') @Default(false) bool isMe,
  }) = _ChatMessageModel;
  
  factory ChatMessageModel.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageModelFromJson(json);
}
