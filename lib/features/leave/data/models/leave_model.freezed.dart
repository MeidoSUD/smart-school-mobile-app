// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'leave_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LeaveModel {

 int get id;@JsonKey(name: 'from_date') String get fromDate;@JsonKey(name: 'to_date') String get toDate; String? get reason; String get status;@JsonKey(name: 'applied_date') String? get appliedDate;
/// Create a copy of LeaveModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LeaveModelCopyWith<LeaveModel> get copyWith => _$LeaveModelCopyWithImpl<LeaveModel>(this as LeaveModel, _$identity);

  /// Serializes this LeaveModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LeaveModel&&(identical(other.id, id) || other.id == id)&&(identical(other.fromDate, fromDate) || other.fromDate == fromDate)&&(identical(other.toDate, toDate) || other.toDate == toDate)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.status, status) || other.status == status)&&(identical(other.appliedDate, appliedDate) || other.appliedDate == appliedDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,fromDate,toDate,reason,status,appliedDate);

@override
String toString() {
  return 'LeaveModel(id: $id, fromDate: $fromDate, toDate: $toDate, reason: $reason, status: $status, appliedDate: $appliedDate)';
}


}

/// @nodoc
abstract mixin class $LeaveModelCopyWith<$Res>  {
  factory $LeaveModelCopyWith(LeaveModel value, $Res Function(LeaveModel) _then) = _$LeaveModelCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'from_date') String fromDate,@JsonKey(name: 'to_date') String toDate, String? reason, String status,@JsonKey(name: 'applied_date') String? appliedDate
});




}
/// @nodoc
class _$LeaveModelCopyWithImpl<$Res>
    implements $LeaveModelCopyWith<$Res> {
  _$LeaveModelCopyWithImpl(this._self, this._then);

  final LeaveModel _self;
  final $Res Function(LeaveModel) _then;

/// Create a copy of LeaveModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? fromDate = null,Object? toDate = null,Object? reason = freezed,Object? status = null,Object? appliedDate = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,fromDate: null == fromDate ? _self.fromDate : fromDate // ignore: cast_nullable_to_non_nullable
as String,toDate: null == toDate ? _self.toDate : toDate // ignore: cast_nullable_to_non_nullable
as String,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,appliedDate: freezed == appliedDate ? _self.appliedDate : appliedDate // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [LeaveModel].
extension LeaveModelPatterns on LeaveModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LeaveModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LeaveModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LeaveModel value)  $default,){
final _that = this;
switch (_that) {
case _LeaveModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LeaveModel value)?  $default,){
final _that = this;
switch (_that) {
case _LeaveModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'from_date')  String fromDate, @JsonKey(name: 'to_date')  String toDate,  String? reason,  String status, @JsonKey(name: 'applied_date')  String? appliedDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LeaveModel() when $default != null:
return $default(_that.id,_that.fromDate,_that.toDate,_that.reason,_that.status,_that.appliedDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'from_date')  String fromDate, @JsonKey(name: 'to_date')  String toDate,  String? reason,  String status, @JsonKey(name: 'applied_date')  String? appliedDate)  $default,) {final _that = this;
switch (_that) {
case _LeaveModel():
return $default(_that.id,_that.fromDate,_that.toDate,_that.reason,_that.status,_that.appliedDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'from_date')  String fromDate, @JsonKey(name: 'to_date')  String toDate,  String? reason,  String status, @JsonKey(name: 'applied_date')  String? appliedDate)?  $default,) {final _that = this;
switch (_that) {
case _LeaveModel() when $default != null:
return $default(_that.id,_that.fromDate,_that.toDate,_that.reason,_that.status,_that.appliedDate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LeaveModel implements LeaveModel {
  const _LeaveModel({this.id = 0, @JsonKey(name: 'from_date') this.fromDate = '', @JsonKey(name: 'to_date') this.toDate = '', this.reason, this.status = 'pending', @JsonKey(name: 'applied_date') this.appliedDate});
  factory _LeaveModel.fromJson(Map<String, dynamic> json) => _$LeaveModelFromJson(json);

@override@JsonKey() final  int id;
@override@JsonKey(name: 'from_date') final  String fromDate;
@override@JsonKey(name: 'to_date') final  String toDate;
@override final  String? reason;
@override@JsonKey() final  String status;
@override@JsonKey(name: 'applied_date') final  String? appliedDate;

/// Create a copy of LeaveModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LeaveModelCopyWith<_LeaveModel> get copyWith => __$LeaveModelCopyWithImpl<_LeaveModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LeaveModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LeaveModel&&(identical(other.id, id) || other.id == id)&&(identical(other.fromDate, fromDate) || other.fromDate == fromDate)&&(identical(other.toDate, toDate) || other.toDate == toDate)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.status, status) || other.status == status)&&(identical(other.appliedDate, appliedDate) || other.appliedDate == appliedDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,fromDate,toDate,reason,status,appliedDate);

@override
String toString() {
  return 'LeaveModel(id: $id, fromDate: $fromDate, toDate: $toDate, reason: $reason, status: $status, appliedDate: $appliedDate)';
}


}

/// @nodoc
abstract mixin class _$LeaveModelCopyWith<$Res> implements $LeaveModelCopyWith<$Res> {
  factory _$LeaveModelCopyWith(_LeaveModel value, $Res Function(_LeaveModel) _then) = __$LeaveModelCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'from_date') String fromDate,@JsonKey(name: 'to_date') String toDate, String? reason, String status,@JsonKey(name: 'applied_date') String? appliedDate
});




}
/// @nodoc
class __$LeaveModelCopyWithImpl<$Res>
    implements _$LeaveModelCopyWith<$Res> {
  __$LeaveModelCopyWithImpl(this._self, this._then);

  final _LeaveModel _self;
  final $Res Function(_LeaveModel) _then;

/// Create a copy of LeaveModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? fromDate = null,Object? toDate = null,Object? reason = freezed,Object? status = null,Object? appliedDate = freezed,}) {
  return _then(_LeaveModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,fromDate: null == fromDate ? _self.fromDate : fromDate // ignore: cast_nullable_to_non_nullable
as String,toDate: null == toDate ? _self.toDate : toDate // ignore: cast_nullable_to_non_nullable
as String,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,appliedDate: freezed == appliedDate ? _self.appliedDate : appliedDate // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
