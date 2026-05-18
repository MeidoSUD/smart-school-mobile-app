// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'visitor_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VisitorModel {

 int get id; String get name; String? get reason;@JsonKey(name: 'visit_date') String? get visitDate; String? get phone;
/// Create a copy of VisitorModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VisitorModelCopyWith<VisitorModel> get copyWith => _$VisitorModelCopyWithImpl<VisitorModel>(this as VisitorModel, _$identity);

  /// Serializes this VisitorModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VisitorModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.visitDate, visitDate) || other.visitDate == visitDate)&&(identical(other.phone, phone) || other.phone == phone));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,reason,visitDate,phone);

@override
String toString() {
  return 'VisitorModel(id: $id, name: $name, reason: $reason, visitDate: $visitDate, phone: $phone)';
}


}

/// @nodoc
abstract mixin class $VisitorModelCopyWith<$Res>  {
  factory $VisitorModelCopyWith(VisitorModel value, $Res Function(VisitorModel) _then) = _$VisitorModelCopyWithImpl;
@useResult
$Res call({
 int id, String name, String? reason,@JsonKey(name: 'visit_date') String? visitDate, String? phone
});




}
/// @nodoc
class _$VisitorModelCopyWithImpl<$Res>
    implements $VisitorModelCopyWith<$Res> {
  _$VisitorModelCopyWithImpl(this._self, this._then);

  final VisitorModel _self;
  final $Res Function(VisitorModel) _then;

/// Create a copy of VisitorModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? reason = freezed,Object? visitDate = freezed,Object? phone = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,visitDate: freezed == visitDate ? _self.visitDate : visitDate // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [VisitorModel].
extension VisitorModelPatterns on VisitorModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VisitorModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VisitorModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VisitorModel value)  $default,){
final _that = this;
switch (_that) {
case _VisitorModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VisitorModel value)?  $default,){
final _that = this;
switch (_that) {
case _VisitorModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String? reason, @JsonKey(name: 'visit_date')  String? visitDate,  String? phone)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VisitorModel() when $default != null:
return $default(_that.id,_that.name,_that.reason,_that.visitDate,_that.phone);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String? reason, @JsonKey(name: 'visit_date')  String? visitDate,  String? phone)  $default,) {final _that = this;
switch (_that) {
case _VisitorModel():
return $default(_that.id,_that.name,_that.reason,_that.visitDate,_that.phone);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String? reason, @JsonKey(name: 'visit_date')  String? visitDate,  String? phone)?  $default,) {final _that = this;
switch (_that) {
case _VisitorModel() when $default != null:
return $default(_that.id,_that.name,_that.reason,_that.visitDate,_that.phone);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VisitorModel implements VisitorModel {
  const _VisitorModel({this.id = 0, this.name = '', this.reason, @JsonKey(name: 'visit_date') this.visitDate, this.phone});
  factory _VisitorModel.fromJson(Map<String, dynamic> json) => _$VisitorModelFromJson(json);

@override@JsonKey() final  int id;
@override@JsonKey() final  String name;
@override final  String? reason;
@override@JsonKey(name: 'visit_date') final  String? visitDate;
@override final  String? phone;

/// Create a copy of VisitorModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VisitorModelCopyWith<_VisitorModel> get copyWith => __$VisitorModelCopyWithImpl<_VisitorModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VisitorModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VisitorModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.visitDate, visitDate) || other.visitDate == visitDate)&&(identical(other.phone, phone) || other.phone == phone));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,reason,visitDate,phone);

@override
String toString() {
  return 'VisitorModel(id: $id, name: $name, reason: $reason, visitDate: $visitDate, phone: $phone)';
}


}

/// @nodoc
abstract mixin class _$VisitorModelCopyWith<$Res> implements $VisitorModelCopyWith<$Res> {
  factory _$VisitorModelCopyWith(_VisitorModel value, $Res Function(_VisitorModel) _then) = __$VisitorModelCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String? reason,@JsonKey(name: 'visit_date') String? visitDate, String? phone
});




}
/// @nodoc
class __$VisitorModelCopyWithImpl<$Res>
    implements _$VisitorModelCopyWith<$Res> {
  __$VisitorModelCopyWithImpl(this._self, this._then);

  final _VisitorModel _self;
  final $Res Function(_VisitorModel) _then;

/// Create a copy of VisitorModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? reason = freezed,Object? visitDate = freezed,Object? phone = freezed,}) {
  return _then(_VisitorModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,visitDate: freezed == visitDate ? _self.visitDate : visitDate // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
