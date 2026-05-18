// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'syllabus_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SyllabusModel {

 int get id; String get subject; String? get topic; String? get status;
/// Create a copy of SyllabusModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SyllabusModelCopyWith<SyllabusModel> get copyWith => _$SyllabusModelCopyWithImpl<SyllabusModel>(this as SyllabusModel, _$identity);

  /// Serializes this SyllabusModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SyllabusModel&&(identical(other.id, id) || other.id == id)&&(identical(other.subject, subject) || other.subject == subject)&&(identical(other.topic, topic) || other.topic == topic)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,subject,topic,status);

@override
String toString() {
  return 'SyllabusModel(id: $id, subject: $subject, topic: $topic, status: $status)';
}


}

/// @nodoc
abstract mixin class $SyllabusModelCopyWith<$Res>  {
  factory $SyllabusModelCopyWith(SyllabusModel value, $Res Function(SyllabusModel) _then) = _$SyllabusModelCopyWithImpl;
@useResult
$Res call({
 int id, String subject, String? topic, String? status
});




}
/// @nodoc
class _$SyllabusModelCopyWithImpl<$Res>
    implements $SyllabusModelCopyWith<$Res> {
  _$SyllabusModelCopyWithImpl(this._self, this._then);

  final SyllabusModel _self;
  final $Res Function(SyllabusModel) _then;

/// Create a copy of SyllabusModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? subject = null,Object? topic = freezed,Object? status = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,subject: null == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String,topic: freezed == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SyllabusModel].
extension SyllabusModelPatterns on SyllabusModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SyllabusModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SyllabusModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SyllabusModel value)  $default,){
final _that = this;
switch (_that) {
case _SyllabusModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SyllabusModel value)?  $default,){
final _that = this;
switch (_that) {
case _SyllabusModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String subject,  String? topic,  String? status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SyllabusModel() when $default != null:
return $default(_that.id,_that.subject,_that.topic,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String subject,  String? topic,  String? status)  $default,) {final _that = this;
switch (_that) {
case _SyllabusModel():
return $default(_that.id,_that.subject,_that.topic,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String subject,  String? topic,  String? status)?  $default,) {final _that = this;
switch (_that) {
case _SyllabusModel() when $default != null:
return $default(_that.id,_that.subject,_that.topic,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SyllabusModel implements SyllabusModel {
  const _SyllabusModel({this.id = 0, this.subject = '', this.topic, this.status});
  factory _SyllabusModel.fromJson(Map<String, dynamic> json) => _$SyllabusModelFromJson(json);

@override@JsonKey() final  int id;
@override@JsonKey() final  String subject;
@override final  String? topic;
@override final  String? status;

/// Create a copy of SyllabusModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SyllabusModelCopyWith<_SyllabusModel> get copyWith => __$SyllabusModelCopyWithImpl<_SyllabusModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SyllabusModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SyllabusModel&&(identical(other.id, id) || other.id == id)&&(identical(other.subject, subject) || other.subject == subject)&&(identical(other.topic, topic) || other.topic == topic)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,subject,topic,status);

@override
String toString() {
  return 'SyllabusModel(id: $id, subject: $subject, topic: $topic, status: $status)';
}


}

/// @nodoc
abstract mixin class _$SyllabusModelCopyWith<$Res> implements $SyllabusModelCopyWith<$Res> {
  factory _$SyllabusModelCopyWith(_SyllabusModel value, $Res Function(_SyllabusModel) _then) = __$SyllabusModelCopyWithImpl;
@override @useResult
$Res call({
 int id, String subject, String? topic, String? status
});




}
/// @nodoc
class __$SyllabusModelCopyWithImpl<$Res>
    implements _$SyllabusModelCopyWith<$Res> {
  __$SyllabusModelCopyWithImpl(this._self, this._then);

  final _SyllabusModel _self;
  final $Res Function(_SyllabusModel) _then;

/// Create a copy of SyllabusModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? subject = null,Object? topic = freezed,Object? status = freezed,}) {
  return _then(_SyllabusModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,subject: null == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String,topic: freezed == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
