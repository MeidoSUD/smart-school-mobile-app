// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lms_user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LmsUserModel {

 int get id; String get role; String get firstname; String get lastname; String? get email; String? get phone; String? get photo; String? get gender; String? get nationality;@JsonKey(name: 'student_id') String? get studentId;@JsonKey(name: 'parent_phone') String? get parentPhone;
/// Create a copy of LmsUserModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LmsUserModelCopyWith<LmsUserModel> get copyWith => _$LmsUserModelCopyWithImpl<LmsUserModel>(this as LmsUserModel, _$identity);

  /// Serializes this LmsUserModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LmsUserModel&&(identical(other.id, id) || other.id == id)&&(identical(other.role, role) || other.role == role)&&(identical(other.firstname, firstname) || other.firstname == firstname)&&(identical(other.lastname, lastname) || other.lastname == lastname)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.photo, photo) || other.photo == photo)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.nationality, nationality) || other.nationality == nationality)&&(identical(other.studentId, studentId) || other.studentId == studentId)&&(identical(other.parentPhone, parentPhone) || other.parentPhone == parentPhone));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,role,firstname,lastname,email,phone,photo,gender,nationality,studentId,parentPhone);

@override
String toString() {
  return 'LmsUserModel(id: $id, role: $role, firstname: $firstname, lastname: $lastname, email: $email, phone: $phone, photo: $photo, gender: $gender, nationality: $nationality, studentId: $studentId, parentPhone: $parentPhone)';
}


}

/// @nodoc
abstract mixin class $LmsUserModelCopyWith<$Res>  {
  factory $LmsUserModelCopyWith(LmsUserModel value, $Res Function(LmsUserModel) _then) = _$LmsUserModelCopyWithImpl;
@useResult
$Res call({
 int id, String role, String firstname, String lastname, String? email, String? phone, String? photo, String? gender, String? nationality,@JsonKey(name: 'student_id') String? studentId,@JsonKey(name: 'parent_phone') String? parentPhone
});




}
/// @nodoc
class _$LmsUserModelCopyWithImpl<$Res>
    implements $LmsUserModelCopyWith<$Res> {
  _$LmsUserModelCopyWithImpl(this._self, this._then);

  final LmsUserModel _self;
  final $Res Function(LmsUserModel) _then;

/// Create a copy of LmsUserModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? role = null,Object? firstname = null,Object? lastname = null,Object? email = freezed,Object? phone = freezed,Object? photo = freezed,Object? gender = freezed,Object? nationality = freezed,Object? studentId = freezed,Object? parentPhone = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,firstname: null == firstname ? _self.firstname : firstname // ignore: cast_nullable_to_non_nullable
as String,lastname: null == lastname ? _self.lastname : lastname // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,photo: freezed == photo ? _self.photo : photo // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,nationality: freezed == nationality ? _self.nationality : nationality // ignore: cast_nullable_to_non_nullable
as String?,studentId: freezed == studentId ? _self.studentId : studentId // ignore: cast_nullable_to_non_nullable
as String?,parentPhone: freezed == parentPhone ? _self.parentPhone : parentPhone // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [LmsUserModel].
extension LmsUserModelPatterns on LmsUserModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LmsUserModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LmsUserModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LmsUserModel value)  $default,){
final _that = this;
switch (_that) {
case _LmsUserModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LmsUserModel value)?  $default,){
final _that = this;
switch (_that) {
case _LmsUserModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String role,  String firstname,  String lastname,  String? email,  String? phone,  String? photo,  String? gender,  String? nationality, @JsonKey(name: 'student_id')  String? studentId, @JsonKey(name: 'parent_phone')  String? parentPhone)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LmsUserModel() when $default != null:
return $default(_that.id,_that.role,_that.firstname,_that.lastname,_that.email,_that.phone,_that.photo,_that.gender,_that.nationality,_that.studentId,_that.parentPhone);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String role,  String firstname,  String lastname,  String? email,  String? phone,  String? photo,  String? gender,  String? nationality, @JsonKey(name: 'student_id')  String? studentId, @JsonKey(name: 'parent_phone')  String? parentPhone)  $default,) {final _that = this;
switch (_that) {
case _LmsUserModel():
return $default(_that.id,_that.role,_that.firstname,_that.lastname,_that.email,_that.phone,_that.photo,_that.gender,_that.nationality,_that.studentId,_that.parentPhone);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String role,  String firstname,  String lastname,  String? email,  String? phone,  String? photo,  String? gender,  String? nationality, @JsonKey(name: 'student_id')  String? studentId, @JsonKey(name: 'parent_phone')  String? parentPhone)?  $default,) {final _that = this;
switch (_that) {
case _LmsUserModel() when $default != null:
return $default(_that.id,_that.role,_that.firstname,_that.lastname,_that.email,_that.phone,_that.photo,_that.gender,_that.nationality,_that.studentId,_that.parentPhone);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LmsUserModel implements LmsUserModel {
  const _LmsUserModel({this.id = 0, this.role = '', this.firstname = '', this.lastname = '', this.email, this.phone, this.photo, this.gender, this.nationality, @JsonKey(name: 'student_id') this.studentId, @JsonKey(name: 'parent_phone') this.parentPhone});
  factory _LmsUserModel.fromJson(Map<String, dynamic> json) => _$LmsUserModelFromJson(json);

@override@JsonKey() final  int id;
@override@JsonKey() final  String role;
@override@JsonKey() final  String firstname;
@override@JsonKey() final  String lastname;
@override final  String? email;
@override final  String? phone;
@override final  String? photo;
@override final  String? gender;
@override final  String? nationality;
@override@JsonKey(name: 'student_id') final  String? studentId;
@override@JsonKey(name: 'parent_phone') final  String? parentPhone;

/// Create a copy of LmsUserModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LmsUserModelCopyWith<_LmsUserModel> get copyWith => __$LmsUserModelCopyWithImpl<_LmsUserModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LmsUserModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LmsUserModel&&(identical(other.id, id) || other.id == id)&&(identical(other.role, role) || other.role == role)&&(identical(other.firstname, firstname) || other.firstname == firstname)&&(identical(other.lastname, lastname) || other.lastname == lastname)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.photo, photo) || other.photo == photo)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.nationality, nationality) || other.nationality == nationality)&&(identical(other.studentId, studentId) || other.studentId == studentId)&&(identical(other.parentPhone, parentPhone) || other.parentPhone == parentPhone));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,role,firstname,lastname,email,phone,photo,gender,nationality,studentId,parentPhone);

@override
String toString() {
  return 'LmsUserModel(id: $id, role: $role, firstname: $firstname, lastname: $lastname, email: $email, phone: $phone, photo: $photo, gender: $gender, nationality: $nationality, studentId: $studentId, parentPhone: $parentPhone)';
}


}

/// @nodoc
abstract mixin class _$LmsUserModelCopyWith<$Res> implements $LmsUserModelCopyWith<$Res> {
  factory _$LmsUserModelCopyWith(_LmsUserModel value, $Res Function(_LmsUserModel) _then) = __$LmsUserModelCopyWithImpl;
@override @useResult
$Res call({
 int id, String role, String firstname, String lastname, String? email, String? phone, String? photo, String? gender, String? nationality,@JsonKey(name: 'student_id') String? studentId,@JsonKey(name: 'parent_phone') String? parentPhone
});




}
/// @nodoc
class __$LmsUserModelCopyWithImpl<$Res>
    implements _$LmsUserModelCopyWith<$Res> {
  __$LmsUserModelCopyWithImpl(this._self, this._then);

  final _LmsUserModel _self;
  final $Res Function(_LmsUserModel) _then;

/// Create a copy of LmsUserModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? role = null,Object? firstname = null,Object? lastname = null,Object? email = freezed,Object? phone = freezed,Object? photo = freezed,Object? gender = freezed,Object? nationality = freezed,Object? studentId = freezed,Object? parentPhone = freezed,}) {
  return _then(_LmsUserModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,firstname: null == firstname ? _self.firstname : firstname // ignore: cast_nullable_to_non_nullable
as String,lastname: null == lastname ? _self.lastname : lastname // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,photo: freezed == photo ? _self.photo : photo // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,nationality: freezed == nationality ? _self.nationality : nationality // ignore: cast_nullable_to_non_nullable
as String?,studentId: freezed == studentId ? _self.studentId : studentId // ignore: cast_nullable_to_non_nullable
as String?,parentPhone: freezed == parentPhone ? _self.parentPhone : parentPhone // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
