// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hostel_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HostelModel {

 String get name;@JsonKey(name: 'room_number') String? get roomNumber; String? get block;@JsonKey(name: 'bed_number') String? get bedNumber;
/// Create a copy of HostelModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HostelModelCopyWith<HostelModel> get copyWith => _$HostelModelCopyWithImpl<HostelModel>(this as HostelModel, _$identity);

  /// Serializes this HostelModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HostelModel&&(identical(other.name, name) || other.name == name)&&(identical(other.roomNumber, roomNumber) || other.roomNumber == roomNumber)&&(identical(other.block, block) || other.block == block)&&(identical(other.bedNumber, bedNumber) || other.bedNumber == bedNumber));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,roomNumber,block,bedNumber);

@override
String toString() {
  return 'HostelModel(name: $name, roomNumber: $roomNumber, block: $block, bedNumber: $bedNumber)';
}


}

/// @nodoc
abstract mixin class $HostelModelCopyWith<$Res>  {
  factory $HostelModelCopyWith(HostelModel value, $Res Function(HostelModel) _then) = _$HostelModelCopyWithImpl;
@useResult
$Res call({
 String name,@JsonKey(name: 'room_number') String? roomNumber, String? block,@JsonKey(name: 'bed_number') String? bedNumber
});




}
/// @nodoc
class _$HostelModelCopyWithImpl<$Res>
    implements $HostelModelCopyWith<$Res> {
  _$HostelModelCopyWithImpl(this._self, this._then);

  final HostelModel _self;
  final $Res Function(HostelModel) _then;

/// Create a copy of HostelModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? roomNumber = freezed,Object? block = freezed,Object? bedNumber = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,roomNumber: freezed == roomNumber ? _self.roomNumber : roomNumber // ignore: cast_nullable_to_non_nullable
as String?,block: freezed == block ? _self.block : block // ignore: cast_nullable_to_non_nullable
as String?,bedNumber: freezed == bedNumber ? _self.bedNumber : bedNumber // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [HostelModel].
extension HostelModelPatterns on HostelModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HostelModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HostelModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HostelModel value)  $default,){
final _that = this;
switch (_that) {
case _HostelModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HostelModel value)?  $default,){
final _that = this;
switch (_that) {
case _HostelModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name, @JsonKey(name: 'room_number')  String? roomNumber,  String? block, @JsonKey(name: 'bed_number')  String? bedNumber)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HostelModel() when $default != null:
return $default(_that.name,_that.roomNumber,_that.block,_that.bedNumber);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name, @JsonKey(name: 'room_number')  String? roomNumber,  String? block, @JsonKey(name: 'bed_number')  String? bedNumber)  $default,) {final _that = this;
switch (_that) {
case _HostelModel():
return $default(_that.name,_that.roomNumber,_that.block,_that.bedNumber);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name, @JsonKey(name: 'room_number')  String? roomNumber,  String? block, @JsonKey(name: 'bed_number')  String? bedNumber)?  $default,) {final _that = this;
switch (_that) {
case _HostelModel() when $default != null:
return $default(_that.name,_that.roomNumber,_that.block,_that.bedNumber);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HostelModel implements HostelModel {
  const _HostelModel({this.name = '', @JsonKey(name: 'room_number') this.roomNumber, this.block, @JsonKey(name: 'bed_number') this.bedNumber});
  factory _HostelModel.fromJson(Map<String, dynamic> json) => _$HostelModelFromJson(json);

@override@JsonKey() final  String name;
@override@JsonKey(name: 'room_number') final  String? roomNumber;
@override final  String? block;
@override@JsonKey(name: 'bed_number') final  String? bedNumber;

/// Create a copy of HostelModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HostelModelCopyWith<_HostelModel> get copyWith => __$HostelModelCopyWithImpl<_HostelModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HostelModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HostelModel&&(identical(other.name, name) || other.name == name)&&(identical(other.roomNumber, roomNumber) || other.roomNumber == roomNumber)&&(identical(other.block, block) || other.block == block)&&(identical(other.bedNumber, bedNumber) || other.bedNumber == bedNumber));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,roomNumber,block,bedNumber);

@override
String toString() {
  return 'HostelModel(name: $name, roomNumber: $roomNumber, block: $block, bedNumber: $bedNumber)';
}


}

/// @nodoc
abstract mixin class _$HostelModelCopyWith<$Res> implements $HostelModelCopyWith<$Res> {
  factory _$HostelModelCopyWith(_HostelModel value, $Res Function(_HostelModel) _then) = __$HostelModelCopyWithImpl;
@override @useResult
$Res call({
 String name,@JsonKey(name: 'room_number') String? roomNumber, String? block,@JsonKey(name: 'bed_number') String? bedNumber
});




}
/// @nodoc
class __$HostelModelCopyWithImpl<$Res>
    implements _$HostelModelCopyWith<$Res> {
  __$HostelModelCopyWithImpl(this._self, this._then);

  final _HostelModel _self;
  final $Res Function(_HostelModel) _then;

/// Create a copy of HostelModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? roomNumber = freezed,Object? block = freezed,Object? bedNumber = freezed,}) {
  return _then(_HostelModel(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,roomNumber: freezed == roomNumber ? _self.roomNumber : roomNumber // ignore: cast_nullable_to_non_nullable
as String?,block: freezed == block ? _self.block : block // ignore: cast_nullable_to_non_nullable
as String?,bedNumber: freezed == bedNumber ? _self.bedNumber : bedNumber // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
