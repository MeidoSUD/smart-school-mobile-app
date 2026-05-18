// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transport_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TransportModel {

 String get route;@JsonKey(name: 'driver_name') String? get driverName;@JsonKey(name: 'driver_phone') String? get driverPhone;@JsonKey(name: 'bus_number') String? get busNumber;@JsonKey(name: 'pickup_time') String? get pickupTime;@JsonKey(name: 'pickup_point') String? get pickupPoint;
/// Create a copy of TransportModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransportModelCopyWith<TransportModel> get copyWith => _$TransportModelCopyWithImpl<TransportModel>(this as TransportModel, _$identity);

  /// Serializes this TransportModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransportModel&&(identical(other.route, route) || other.route == route)&&(identical(other.driverName, driverName) || other.driverName == driverName)&&(identical(other.driverPhone, driverPhone) || other.driverPhone == driverPhone)&&(identical(other.busNumber, busNumber) || other.busNumber == busNumber)&&(identical(other.pickupTime, pickupTime) || other.pickupTime == pickupTime)&&(identical(other.pickupPoint, pickupPoint) || other.pickupPoint == pickupPoint));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,route,driverName,driverPhone,busNumber,pickupTime,pickupPoint);

@override
String toString() {
  return 'TransportModel(route: $route, driverName: $driverName, driverPhone: $driverPhone, busNumber: $busNumber, pickupTime: $pickupTime, pickupPoint: $pickupPoint)';
}


}

/// @nodoc
abstract mixin class $TransportModelCopyWith<$Res>  {
  factory $TransportModelCopyWith(TransportModel value, $Res Function(TransportModel) _then) = _$TransportModelCopyWithImpl;
@useResult
$Res call({
 String route,@JsonKey(name: 'driver_name') String? driverName,@JsonKey(name: 'driver_phone') String? driverPhone,@JsonKey(name: 'bus_number') String? busNumber,@JsonKey(name: 'pickup_time') String? pickupTime,@JsonKey(name: 'pickup_point') String? pickupPoint
});




}
/// @nodoc
class _$TransportModelCopyWithImpl<$Res>
    implements $TransportModelCopyWith<$Res> {
  _$TransportModelCopyWithImpl(this._self, this._then);

  final TransportModel _self;
  final $Res Function(TransportModel) _then;

/// Create a copy of TransportModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? route = null,Object? driverName = freezed,Object? driverPhone = freezed,Object? busNumber = freezed,Object? pickupTime = freezed,Object? pickupPoint = freezed,}) {
  return _then(_self.copyWith(
route: null == route ? _self.route : route // ignore: cast_nullable_to_non_nullable
as String,driverName: freezed == driverName ? _self.driverName : driverName // ignore: cast_nullable_to_non_nullable
as String?,driverPhone: freezed == driverPhone ? _self.driverPhone : driverPhone // ignore: cast_nullable_to_non_nullable
as String?,busNumber: freezed == busNumber ? _self.busNumber : busNumber // ignore: cast_nullable_to_non_nullable
as String?,pickupTime: freezed == pickupTime ? _self.pickupTime : pickupTime // ignore: cast_nullable_to_non_nullable
as String?,pickupPoint: freezed == pickupPoint ? _self.pickupPoint : pickupPoint // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TransportModel].
extension TransportModelPatterns on TransportModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TransportModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TransportModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TransportModel value)  $default,){
final _that = this;
switch (_that) {
case _TransportModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TransportModel value)?  $default,){
final _that = this;
switch (_that) {
case _TransportModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String route, @JsonKey(name: 'driver_name')  String? driverName, @JsonKey(name: 'driver_phone')  String? driverPhone, @JsonKey(name: 'bus_number')  String? busNumber, @JsonKey(name: 'pickup_time')  String? pickupTime, @JsonKey(name: 'pickup_point')  String? pickupPoint)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TransportModel() when $default != null:
return $default(_that.route,_that.driverName,_that.driverPhone,_that.busNumber,_that.pickupTime,_that.pickupPoint);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String route, @JsonKey(name: 'driver_name')  String? driverName, @JsonKey(name: 'driver_phone')  String? driverPhone, @JsonKey(name: 'bus_number')  String? busNumber, @JsonKey(name: 'pickup_time')  String? pickupTime, @JsonKey(name: 'pickup_point')  String? pickupPoint)  $default,) {final _that = this;
switch (_that) {
case _TransportModel():
return $default(_that.route,_that.driverName,_that.driverPhone,_that.busNumber,_that.pickupTime,_that.pickupPoint);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String route, @JsonKey(name: 'driver_name')  String? driverName, @JsonKey(name: 'driver_phone')  String? driverPhone, @JsonKey(name: 'bus_number')  String? busNumber, @JsonKey(name: 'pickup_time')  String? pickupTime, @JsonKey(name: 'pickup_point')  String? pickupPoint)?  $default,) {final _that = this;
switch (_that) {
case _TransportModel() when $default != null:
return $default(_that.route,_that.driverName,_that.driverPhone,_that.busNumber,_that.pickupTime,_that.pickupPoint);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TransportModel implements TransportModel {
  const _TransportModel({this.route = '', @JsonKey(name: 'driver_name') this.driverName, @JsonKey(name: 'driver_phone') this.driverPhone, @JsonKey(name: 'bus_number') this.busNumber, @JsonKey(name: 'pickup_time') this.pickupTime, @JsonKey(name: 'pickup_point') this.pickupPoint});
  factory _TransportModel.fromJson(Map<String, dynamic> json) => _$TransportModelFromJson(json);

@override@JsonKey() final  String route;
@override@JsonKey(name: 'driver_name') final  String? driverName;
@override@JsonKey(name: 'driver_phone') final  String? driverPhone;
@override@JsonKey(name: 'bus_number') final  String? busNumber;
@override@JsonKey(name: 'pickup_time') final  String? pickupTime;
@override@JsonKey(name: 'pickup_point') final  String? pickupPoint;

/// Create a copy of TransportModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransportModelCopyWith<_TransportModel> get copyWith => __$TransportModelCopyWithImpl<_TransportModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TransportModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransportModel&&(identical(other.route, route) || other.route == route)&&(identical(other.driverName, driverName) || other.driverName == driverName)&&(identical(other.driverPhone, driverPhone) || other.driverPhone == driverPhone)&&(identical(other.busNumber, busNumber) || other.busNumber == busNumber)&&(identical(other.pickupTime, pickupTime) || other.pickupTime == pickupTime)&&(identical(other.pickupPoint, pickupPoint) || other.pickupPoint == pickupPoint));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,route,driverName,driverPhone,busNumber,pickupTime,pickupPoint);

@override
String toString() {
  return 'TransportModel(route: $route, driverName: $driverName, driverPhone: $driverPhone, busNumber: $busNumber, pickupTime: $pickupTime, pickupPoint: $pickupPoint)';
}


}

/// @nodoc
abstract mixin class _$TransportModelCopyWith<$Res> implements $TransportModelCopyWith<$Res> {
  factory _$TransportModelCopyWith(_TransportModel value, $Res Function(_TransportModel) _then) = __$TransportModelCopyWithImpl;
@override @useResult
$Res call({
 String route,@JsonKey(name: 'driver_name') String? driverName,@JsonKey(name: 'driver_phone') String? driverPhone,@JsonKey(name: 'bus_number') String? busNumber,@JsonKey(name: 'pickup_time') String? pickupTime,@JsonKey(name: 'pickup_point') String? pickupPoint
});




}
/// @nodoc
class __$TransportModelCopyWithImpl<$Res>
    implements _$TransportModelCopyWith<$Res> {
  __$TransportModelCopyWithImpl(this._self, this._then);

  final _TransportModel _self;
  final $Res Function(_TransportModel) _then;

/// Create a copy of TransportModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? route = null,Object? driverName = freezed,Object? driverPhone = freezed,Object? busNumber = freezed,Object? pickupTime = freezed,Object? pickupPoint = freezed,}) {
  return _then(_TransportModel(
route: null == route ? _self.route : route // ignore: cast_nullable_to_non_nullable
as String,driverName: freezed == driverName ? _self.driverName : driverName // ignore: cast_nullable_to_non_nullable
as String?,driverPhone: freezed == driverPhone ? _self.driverPhone : driverPhone // ignore: cast_nullable_to_non_nullable
as String?,busNumber: freezed == busNumber ? _self.busNumber : busNumber // ignore: cast_nullable_to_non_nullable
as String?,pickupTime: freezed == pickupTime ? _self.pickupTime : pickupTime // ignore: cast_nullable_to_non_nullable
as String?,pickupPoint: freezed == pickupPoint ? _self.pickupPoint : pickupPoint // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
