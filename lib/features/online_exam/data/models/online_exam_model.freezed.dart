// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'online_exam_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OnlineExamModel {

 int get id; String get title; String? get subject; int? get duration;@JsonKey(name: 'total_questions') int? get totalQuestions; String? get status;
/// Create a copy of OnlineExamModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnlineExamModelCopyWith<OnlineExamModel> get copyWith => _$OnlineExamModelCopyWithImpl<OnlineExamModel>(this as OnlineExamModel, _$identity);

  /// Serializes this OnlineExamModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnlineExamModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.subject, subject) || other.subject == subject)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.totalQuestions, totalQuestions) || other.totalQuestions == totalQuestions)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,subject,duration,totalQuestions,status);

@override
String toString() {
  return 'OnlineExamModel(id: $id, title: $title, subject: $subject, duration: $duration, totalQuestions: $totalQuestions, status: $status)';
}


}

/// @nodoc
abstract mixin class $OnlineExamModelCopyWith<$Res>  {
  factory $OnlineExamModelCopyWith(OnlineExamModel value, $Res Function(OnlineExamModel) _then) = _$OnlineExamModelCopyWithImpl;
@useResult
$Res call({
 int id, String title, String? subject, int? duration,@JsonKey(name: 'total_questions') int? totalQuestions, String? status
});




}
/// @nodoc
class _$OnlineExamModelCopyWithImpl<$Res>
    implements $OnlineExamModelCopyWith<$Res> {
  _$OnlineExamModelCopyWithImpl(this._self, this._then);

  final OnlineExamModel _self;
  final $Res Function(OnlineExamModel) _then;

/// Create a copy of OnlineExamModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? subject = freezed,Object? duration = freezed,Object? totalQuestions = freezed,Object? status = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subject: freezed == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String?,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int?,totalQuestions: freezed == totalQuestions ? _self.totalQuestions : totalQuestions // ignore: cast_nullable_to_non_nullable
as int?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [OnlineExamModel].
extension OnlineExamModelPatterns on OnlineExamModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OnlineExamModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OnlineExamModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OnlineExamModel value)  $default,){
final _that = this;
switch (_that) {
case _OnlineExamModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OnlineExamModel value)?  $default,){
final _that = this;
switch (_that) {
case _OnlineExamModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String title,  String? subject,  int? duration, @JsonKey(name: 'total_questions')  int? totalQuestions,  String? status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OnlineExamModel() when $default != null:
return $default(_that.id,_that.title,_that.subject,_that.duration,_that.totalQuestions,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String title,  String? subject,  int? duration, @JsonKey(name: 'total_questions')  int? totalQuestions,  String? status)  $default,) {final _that = this;
switch (_that) {
case _OnlineExamModel():
return $default(_that.id,_that.title,_that.subject,_that.duration,_that.totalQuestions,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String title,  String? subject,  int? duration, @JsonKey(name: 'total_questions')  int? totalQuestions,  String? status)?  $default,) {final _that = this;
switch (_that) {
case _OnlineExamModel() when $default != null:
return $default(_that.id,_that.title,_that.subject,_that.duration,_that.totalQuestions,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OnlineExamModel implements OnlineExamModel {
  const _OnlineExamModel({this.id = 0, this.title = '', this.subject, this.duration, @JsonKey(name: 'total_questions') this.totalQuestions, this.status});
  factory _OnlineExamModel.fromJson(Map<String, dynamic> json) => _$OnlineExamModelFromJson(json);

@override@JsonKey() final  int id;
@override@JsonKey() final  String title;
@override final  String? subject;
@override final  int? duration;
@override@JsonKey(name: 'total_questions') final  int? totalQuestions;
@override final  String? status;

/// Create a copy of OnlineExamModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OnlineExamModelCopyWith<_OnlineExamModel> get copyWith => __$OnlineExamModelCopyWithImpl<_OnlineExamModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OnlineExamModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OnlineExamModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.subject, subject) || other.subject == subject)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.totalQuestions, totalQuestions) || other.totalQuestions == totalQuestions)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,subject,duration,totalQuestions,status);

@override
String toString() {
  return 'OnlineExamModel(id: $id, title: $title, subject: $subject, duration: $duration, totalQuestions: $totalQuestions, status: $status)';
}


}

/// @nodoc
abstract mixin class _$OnlineExamModelCopyWith<$Res> implements $OnlineExamModelCopyWith<$Res> {
  factory _$OnlineExamModelCopyWith(_OnlineExamModel value, $Res Function(_OnlineExamModel) _then) = __$OnlineExamModelCopyWithImpl;
@override @useResult
$Res call({
 int id, String title, String? subject, int? duration,@JsonKey(name: 'total_questions') int? totalQuestions, String? status
});




}
/// @nodoc
class __$OnlineExamModelCopyWithImpl<$Res>
    implements _$OnlineExamModelCopyWith<$Res> {
  __$OnlineExamModelCopyWithImpl(this._self, this._then);

  final _OnlineExamModel _self;
  final $Res Function(_OnlineExamModel) _then;

/// Create a copy of OnlineExamModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? subject = freezed,Object? duration = freezed,Object? totalQuestions = freezed,Object? status = freezed,}) {
  return _then(_OnlineExamModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subject: freezed == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String?,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int?,totalQuestions: freezed == totalQuestions ? _self.totalQuestions : totalQuestions // ignore: cast_nullable_to_non_nullable
as int?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
