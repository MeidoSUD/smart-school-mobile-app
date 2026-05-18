// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'teacher_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TeacherModel {

 int get id; String get name; String? get photo; String? get subject; String? get phone; double get rating;
/// Create a copy of TeacherModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TeacherModelCopyWith<TeacherModel> get copyWith => _$TeacherModelCopyWithImpl<TeacherModel>(this as TeacherModel, _$identity);

  /// Serializes this TeacherModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TeacherModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.photo, photo) || other.photo == photo)&&(identical(other.subject, subject) || other.subject == subject)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.rating, rating) || other.rating == rating));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,photo,subject,phone,rating);

@override
String toString() {
  return 'TeacherModel(id: $id, name: $name, photo: $photo, subject: $subject, phone: $phone, rating: $rating)';
}


}

/// @nodoc
abstract mixin class $TeacherModelCopyWith<$Res>  {
  factory $TeacherModelCopyWith(TeacherModel value, $Res Function(TeacherModel) _then) = _$TeacherModelCopyWithImpl;
@useResult
$Res call({
 int id, String name, String? photo, String? subject, String? phone, double rating
});




}
/// @nodoc
class _$TeacherModelCopyWithImpl<$Res>
    implements $TeacherModelCopyWith<$Res> {
  _$TeacherModelCopyWithImpl(this._self, this._then);

  final TeacherModel _self;
  final $Res Function(TeacherModel) _then;

/// Create a copy of TeacherModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? photo = freezed,Object? subject = freezed,Object? phone = freezed,Object? rating = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,photo: freezed == photo ? _self.photo : photo // ignore: cast_nullable_to_non_nullable
as String?,subject: freezed == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [TeacherModel].
extension TeacherModelPatterns on TeacherModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TeacherModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TeacherModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TeacherModel value)  $default,){
final _that = this;
switch (_that) {
case _TeacherModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TeacherModel value)?  $default,){
final _that = this;
switch (_that) {
case _TeacherModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String? photo,  String? subject,  String? phone,  double rating)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TeacherModel() when $default != null:
return $default(_that.id,_that.name,_that.photo,_that.subject,_that.phone,_that.rating);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String? photo,  String? subject,  String? phone,  double rating)  $default,) {final _that = this;
switch (_that) {
case _TeacherModel():
return $default(_that.id,_that.name,_that.photo,_that.subject,_that.phone,_that.rating);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String? photo,  String? subject,  String? phone,  double rating)?  $default,) {final _that = this;
switch (_that) {
case _TeacherModel() when $default != null:
return $default(_that.id,_that.name,_that.photo,_that.subject,_that.phone,_that.rating);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TeacherModel implements TeacherModel {
  const _TeacherModel({this.id = 0, this.name = '', this.photo, this.subject, this.phone, this.rating = 0.0});
  factory _TeacherModel.fromJson(Map<String, dynamic> json) => _$TeacherModelFromJson(json);

@override@JsonKey() final  int id;
@override@JsonKey() final  String name;
@override final  String? photo;
@override final  String? subject;
@override final  String? phone;
@override@JsonKey() final  double rating;

/// Create a copy of TeacherModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TeacherModelCopyWith<_TeacherModel> get copyWith => __$TeacherModelCopyWithImpl<_TeacherModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TeacherModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TeacherModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.photo, photo) || other.photo == photo)&&(identical(other.subject, subject) || other.subject == subject)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.rating, rating) || other.rating == rating));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,photo,subject,phone,rating);

@override
String toString() {
  return 'TeacherModel(id: $id, name: $name, photo: $photo, subject: $subject, phone: $phone, rating: $rating)';
}


}

/// @nodoc
abstract mixin class _$TeacherModelCopyWith<$Res> implements $TeacherModelCopyWith<$Res> {
  factory _$TeacherModelCopyWith(_TeacherModel value, $Res Function(_TeacherModel) _then) = __$TeacherModelCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String? photo, String? subject, String? phone, double rating
});




}
/// @nodoc
class __$TeacherModelCopyWithImpl<$Res>
    implements _$TeacherModelCopyWith<$Res> {
  __$TeacherModelCopyWithImpl(this._self, this._then);

  final _TeacherModel _self;
  final $Res Function(_TeacherModel) _then;

/// Create a copy of TeacherModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? photo = freezed,Object? subject = freezed,Object? phone = freezed,Object? rating = null,}) {
  return _then(_TeacherModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,photo: freezed == photo ? _self.photo : photo // ignore: cast_nullable_to_non_nullable
as String?,subject: freezed == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
