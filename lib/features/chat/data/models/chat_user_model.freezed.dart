// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChatUserModel {

 int get id; String get name; String? get photo;@JsonKey(name: 'last_message') String? get lastMessage; String? get time;
/// Create a copy of ChatUserModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatUserModelCopyWith<ChatUserModel> get copyWith => _$ChatUserModelCopyWithImpl<ChatUserModel>(this as ChatUserModel, _$identity);

  /// Serializes this ChatUserModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatUserModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.photo, photo) || other.photo == photo)&&(identical(other.lastMessage, lastMessage) || other.lastMessage == lastMessage)&&(identical(other.time, time) || other.time == time));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,photo,lastMessage,time);

@override
String toString() {
  return 'ChatUserModel(id: $id, name: $name, photo: $photo, lastMessage: $lastMessage, time: $time)';
}


}

/// @nodoc
abstract mixin class $ChatUserModelCopyWith<$Res>  {
  factory $ChatUserModelCopyWith(ChatUserModel value, $Res Function(ChatUserModel) _then) = _$ChatUserModelCopyWithImpl;
@useResult
$Res call({
 int id, String name, String? photo,@JsonKey(name: 'last_message') String? lastMessage, String? time
});




}
/// @nodoc
class _$ChatUserModelCopyWithImpl<$Res>
    implements $ChatUserModelCopyWith<$Res> {
  _$ChatUserModelCopyWithImpl(this._self, this._then);

  final ChatUserModel _self;
  final $Res Function(ChatUserModel) _then;

/// Create a copy of ChatUserModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? photo = freezed,Object? lastMessage = freezed,Object? time = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,photo: freezed == photo ? _self.photo : photo // ignore: cast_nullable_to_non_nullable
as String?,lastMessage: freezed == lastMessage ? _self.lastMessage : lastMessage // ignore: cast_nullable_to_non_nullable
as String?,time: freezed == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatUserModel].
extension ChatUserModelPatterns on ChatUserModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatUserModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatUserModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatUserModel value)  $default,){
final _that = this;
switch (_that) {
case _ChatUserModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatUserModel value)?  $default,){
final _that = this;
switch (_that) {
case _ChatUserModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String? photo, @JsonKey(name: 'last_message')  String? lastMessage,  String? time)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatUserModel() when $default != null:
return $default(_that.id,_that.name,_that.photo,_that.lastMessage,_that.time);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String? photo, @JsonKey(name: 'last_message')  String? lastMessage,  String? time)  $default,) {final _that = this;
switch (_that) {
case _ChatUserModel():
return $default(_that.id,_that.name,_that.photo,_that.lastMessage,_that.time);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String? photo, @JsonKey(name: 'last_message')  String? lastMessage,  String? time)?  $default,) {final _that = this;
switch (_that) {
case _ChatUserModel() when $default != null:
return $default(_that.id,_that.name,_that.photo,_that.lastMessage,_that.time);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChatUserModel implements ChatUserModel {
  const _ChatUserModel({this.id = 0, this.name = '', this.photo, @JsonKey(name: 'last_message') this.lastMessage, this.time});
  factory _ChatUserModel.fromJson(Map<String, dynamic> json) => _$ChatUserModelFromJson(json);

@override@JsonKey() final  int id;
@override@JsonKey() final  String name;
@override final  String? photo;
@override@JsonKey(name: 'last_message') final  String? lastMessage;
@override final  String? time;

/// Create a copy of ChatUserModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatUserModelCopyWith<_ChatUserModel> get copyWith => __$ChatUserModelCopyWithImpl<_ChatUserModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatUserModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatUserModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.photo, photo) || other.photo == photo)&&(identical(other.lastMessage, lastMessage) || other.lastMessage == lastMessage)&&(identical(other.time, time) || other.time == time));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,photo,lastMessage,time);

@override
String toString() {
  return 'ChatUserModel(id: $id, name: $name, photo: $photo, lastMessage: $lastMessage, time: $time)';
}


}

/// @nodoc
abstract mixin class _$ChatUserModelCopyWith<$Res> implements $ChatUserModelCopyWith<$Res> {
  factory _$ChatUserModelCopyWith(_ChatUserModel value, $Res Function(_ChatUserModel) _then) = __$ChatUserModelCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String? photo,@JsonKey(name: 'last_message') String? lastMessage, String? time
});




}
/// @nodoc
class __$ChatUserModelCopyWithImpl<$Res>
    implements _$ChatUserModelCopyWith<$Res> {
  __$ChatUserModelCopyWithImpl(this._self, this._then);

  final _ChatUserModel _self;
  final $Res Function(_ChatUserModel) _then;

/// Create a copy of ChatUserModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? photo = freezed,Object? lastMessage = freezed,Object? time = freezed,}) {
  return _then(_ChatUserModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,photo: freezed == photo ? _self.photo : photo // ignore: cast_nullable_to_non_nullable
as String?,lastMessage: freezed == lastMessage ? _self.lastMessage : lastMessage // ignore: cast_nullable_to_non_nullable
as String?,time: freezed == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
