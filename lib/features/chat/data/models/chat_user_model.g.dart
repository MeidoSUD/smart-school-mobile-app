// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChatUserModel _$ChatUserModelFromJson(Map<String, dynamic> json) =>
    _ChatUserModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
      photo: json['photo'] as String?,
      lastMessage: json['last_message'] as String?,
      time: json['time'] as String?,
    );

Map<String, dynamic> _$ChatUserModelToJson(_ChatUserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'photo': instance.photo,
      'last_message': instance.lastMessage,
      'time': instance.time,
    };
