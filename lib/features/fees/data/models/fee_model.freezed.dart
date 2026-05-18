// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fee_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FeeModel {

 int get id; String get title; double get amount;@JsonKey(name: 'due_date') String? get dueDate; String? get status; String? get description;
/// Create a copy of FeeModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeeModelCopyWith<FeeModel> get copyWith => _$FeeModelCopyWithImpl<FeeModel>(this as FeeModel, _$identity);

  /// Serializes this FeeModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeeModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.status, status) || other.status == status)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,amount,dueDate,status,description);

@override
String toString() {
  return 'FeeModel(id: $id, title: $title, amount: $amount, dueDate: $dueDate, status: $status, description: $description)';
}


}

/// @nodoc
abstract mixin class $FeeModelCopyWith<$Res>  {
  factory $FeeModelCopyWith(FeeModel value, $Res Function(FeeModel) _then) = _$FeeModelCopyWithImpl;
@useResult
$Res call({
 int id, String title, double amount,@JsonKey(name: 'due_date') String? dueDate, String? status, String? description
});




}
/// @nodoc
class _$FeeModelCopyWithImpl<$Res>
    implements $FeeModelCopyWith<$Res> {
  _$FeeModelCopyWithImpl(this._self, this._then);

  final FeeModel _self;
  final $Res Function(FeeModel) _then;

/// Create a copy of FeeModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? amount = null,Object? dueDate = freezed,Object? status = freezed,Object? description = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,dueDate: freezed == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [FeeModel].
extension FeeModelPatterns on FeeModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeeModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeeModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeeModel value)  $default,){
final _that = this;
switch (_that) {
case _FeeModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeeModel value)?  $default,){
final _that = this;
switch (_that) {
case _FeeModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String title,  double amount, @JsonKey(name: 'due_date')  String? dueDate,  String? status,  String? description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeeModel() when $default != null:
return $default(_that.id,_that.title,_that.amount,_that.dueDate,_that.status,_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String title,  double amount, @JsonKey(name: 'due_date')  String? dueDate,  String? status,  String? description)  $default,) {final _that = this;
switch (_that) {
case _FeeModel():
return $default(_that.id,_that.title,_that.amount,_that.dueDate,_that.status,_that.description);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String title,  double amount, @JsonKey(name: 'due_date')  String? dueDate,  String? status,  String? description)?  $default,) {final _that = this;
switch (_that) {
case _FeeModel() when $default != null:
return $default(_that.id,_that.title,_that.amount,_that.dueDate,_that.status,_that.description);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FeeModel implements FeeModel {
  const _FeeModel({this.id = 0, this.title = '', this.amount = 0.0, @JsonKey(name: 'due_date') this.dueDate, this.status, this.description});
  factory _FeeModel.fromJson(Map<String, dynamic> json) => _$FeeModelFromJson(json);

@override@JsonKey() final  int id;
@override@JsonKey() final  String title;
@override@JsonKey() final  double amount;
@override@JsonKey(name: 'due_date') final  String? dueDate;
@override final  String? status;
@override final  String? description;

/// Create a copy of FeeModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeeModelCopyWith<_FeeModel> get copyWith => __$FeeModelCopyWithImpl<_FeeModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FeeModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeeModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.status, status) || other.status == status)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,amount,dueDate,status,description);

@override
String toString() {
  return 'FeeModel(id: $id, title: $title, amount: $amount, dueDate: $dueDate, status: $status, description: $description)';
}


}

/// @nodoc
abstract mixin class _$FeeModelCopyWith<$Res> implements $FeeModelCopyWith<$Res> {
  factory _$FeeModelCopyWith(_FeeModel value, $Res Function(_FeeModel) _then) = __$FeeModelCopyWithImpl;
@override @useResult
$Res call({
 int id, String title, double amount,@JsonKey(name: 'due_date') String? dueDate, String? status, String? description
});




}
/// @nodoc
class __$FeeModelCopyWithImpl<$Res>
    implements _$FeeModelCopyWith<$Res> {
  __$FeeModelCopyWithImpl(this._self, this._then);

  final _FeeModel _self;
  final $Res Function(_FeeModel) _then;

/// Create a copy of FeeModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? amount = null,Object? dueDate = freezed,Object? status = freezed,Object? description = freezed,}) {
  return _then(_FeeModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,dueDate: freezed == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
