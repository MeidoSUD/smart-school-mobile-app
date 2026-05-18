// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'homework_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HomeworkModel {

 int get id; String get title; String? get description; String? get subject;@JsonKey(name: 'due_date') String? get dueDate; String? get status;@JsonKey(name: 'created_at') String? get createdAt;
/// Create a copy of HomeworkModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeworkModelCopyWith<HomeworkModel> get copyWith => _$HomeworkModelCopyWithImpl<HomeworkModel>(this as HomeworkModel, _$identity);

  /// Serializes this HomeworkModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeworkModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.subject, subject) || other.subject == subject)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,subject,dueDate,status,createdAt);

@override
String toString() {
  return 'HomeworkModel(id: $id, title: $title, description: $description, subject: $subject, dueDate: $dueDate, status: $status, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $HomeworkModelCopyWith<$Res>  {
  factory $HomeworkModelCopyWith(HomeworkModel value, $Res Function(HomeworkModel) _then) = _$HomeworkModelCopyWithImpl;
@useResult
$Res call({
 int id, String title, String? description, String? subject,@JsonKey(name: 'due_date') String? dueDate, String? status,@JsonKey(name: 'created_at') String? createdAt
});




}
/// @nodoc
class _$HomeworkModelCopyWithImpl<$Res>
    implements $HomeworkModelCopyWith<$Res> {
  _$HomeworkModelCopyWithImpl(this._self, this._then);

  final HomeworkModel _self;
  final $Res Function(HomeworkModel) _then;

/// Create a copy of HomeworkModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = freezed,Object? subject = freezed,Object? dueDate = freezed,Object? status = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,subject: freezed == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String?,dueDate: freezed == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [HomeworkModel].
extension HomeworkModelPatterns on HomeworkModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeworkModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeworkModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeworkModel value)  $default,){
final _that = this;
switch (_that) {
case _HomeworkModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeworkModel value)?  $default,){
final _that = this;
switch (_that) {
case _HomeworkModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String title,  String? description,  String? subject, @JsonKey(name: 'due_date')  String? dueDate,  String? status, @JsonKey(name: 'created_at')  String? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeworkModel() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.subject,_that.dueDate,_that.status,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String title,  String? description,  String? subject, @JsonKey(name: 'due_date')  String? dueDate,  String? status, @JsonKey(name: 'created_at')  String? createdAt)  $default,) {final _that = this;
switch (_that) {
case _HomeworkModel():
return $default(_that.id,_that.title,_that.description,_that.subject,_that.dueDate,_that.status,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String title,  String? description,  String? subject, @JsonKey(name: 'due_date')  String? dueDate,  String? status, @JsonKey(name: 'created_at')  String? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _HomeworkModel() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.subject,_that.dueDate,_that.status,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HomeworkModel implements HomeworkModel {
  const _HomeworkModel({this.id = 0, this.title = '', this.description, this.subject, @JsonKey(name: 'due_date') this.dueDate, this.status, @JsonKey(name: 'created_at') this.createdAt});
  factory _HomeworkModel.fromJson(Map<String, dynamic> json) => _$HomeworkModelFromJson(json);

@override@JsonKey() final  int id;
@override@JsonKey() final  String title;
@override final  String? description;
@override final  String? subject;
@override@JsonKey(name: 'due_date') final  String? dueDate;
@override final  String? status;
@override@JsonKey(name: 'created_at') final  String? createdAt;

/// Create a copy of HomeworkModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeworkModelCopyWith<_HomeworkModel> get copyWith => __$HomeworkModelCopyWithImpl<_HomeworkModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HomeworkModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeworkModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.subject, subject) || other.subject == subject)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,subject,dueDate,status,createdAt);

@override
String toString() {
  return 'HomeworkModel(id: $id, title: $title, description: $description, subject: $subject, dueDate: $dueDate, status: $status, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$HomeworkModelCopyWith<$Res> implements $HomeworkModelCopyWith<$Res> {
  factory _$HomeworkModelCopyWith(_HomeworkModel value, $Res Function(_HomeworkModel) _then) = __$HomeworkModelCopyWithImpl;
@override @useResult
$Res call({
 int id, String title, String? description, String? subject,@JsonKey(name: 'due_date') String? dueDate, String? status,@JsonKey(name: 'created_at') String? createdAt
});




}
/// @nodoc
class __$HomeworkModelCopyWithImpl<$Res>
    implements _$HomeworkModelCopyWith<$Res> {
  __$HomeworkModelCopyWithImpl(this._self, this._then);

  final _HomeworkModel _self;
  final $Res Function(_HomeworkModel) _then;

/// Create a copy of HomeworkModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = freezed,Object? subject = freezed,Object? dueDate = freezed,Object? status = freezed,Object? createdAt = freezed,}) {
  return _then(_HomeworkModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,subject: freezed == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String?,dueDate: freezed == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
