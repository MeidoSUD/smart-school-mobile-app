// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DashboardModel {

@JsonKey(name: 'attendence_percentage') int get attendancePercentage;@JsonKey(name: 'homeworklist') List<dynamic> get homeworkList;@JsonKey(name: 'notificationlist') List<dynamic> get notificationList;@JsonKey(name: 'subjects_data') Map<String, dynamic> get subjectsData;@JsonKey(name: 'timetable') Map<String, dynamic> get timetable;@JsonKey(name: 'visitor_list') List<dynamic> get visitorList;@JsonKey(name: 'bookList') List<dynamic> get bookList;@JsonKey(name: 'teacherlist') List<dynamic> get teacherList;
/// Create a copy of DashboardModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DashboardModelCopyWith<DashboardModel> get copyWith => _$DashboardModelCopyWithImpl<DashboardModel>(this as DashboardModel, _$identity);

  /// Serializes this DashboardModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardModel&&(identical(other.attendancePercentage, attendancePercentage) || other.attendancePercentage == attendancePercentage)&&const DeepCollectionEquality().equals(other.homeworkList, homeworkList)&&const DeepCollectionEquality().equals(other.notificationList, notificationList)&&const DeepCollectionEquality().equals(other.subjectsData, subjectsData)&&const DeepCollectionEquality().equals(other.timetable, timetable)&&const DeepCollectionEquality().equals(other.visitorList, visitorList)&&const DeepCollectionEquality().equals(other.bookList, bookList)&&const DeepCollectionEquality().equals(other.teacherList, teacherList));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,attendancePercentage,const DeepCollectionEquality().hash(homeworkList),const DeepCollectionEquality().hash(notificationList),const DeepCollectionEquality().hash(subjectsData),const DeepCollectionEquality().hash(timetable),const DeepCollectionEquality().hash(visitorList),const DeepCollectionEquality().hash(bookList),const DeepCollectionEquality().hash(teacherList));

@override
String toString() {
  return 'DashboardModel(attendancePercentage: $attendancePercentage, homeworkList: $homeworkList, notificationList: $notificationList, subjectsData: $subjectsData, timetable: $timetable, visitorList: $visitorList, bookList: $bookList, teacherList: $teacherList)';
}


}

/// @nodoc
abstract mixin class $DashboardModelCopyWith<$Res>  {
  factory $DashboardModelCopyWith(DashboardModel value, $Res Function(DashboardModel) _then) = _$DashboardModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'attendence_percentage') int attendancePercentage,@JsonKey(name: 'homeworklist') List<dynamic> homeworkList,@JsonKey(name: 'notificationlist') List<dynamic> notificationList,@JsonKey(name: 'subjects_data') Map<String, dynamic> subjectsData,@JsonKey(name: 'timetable') Map<String, dynamic> timetable,@JsonKey(name: 'visitor_list') List<dynamic> visitorList,@JsonKey(name: 'bookList') List<dynamic> bookList,@JsonKey(name: 'teacherlist') List<dynamic> teacherList
});




}
/// @nodoc
class _$DashboardModelCopyWithImpl<$Res>
    implements $DashboardModelCopyWith<$Res> {
  _$DashboardModelCopyWithImpl(this._self, this._then);

  final DashboardModel _self;
  final $Res Function(DashboardModel) _then;

/// Create a copy of DashboardModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? attendancePercentage = null,Object? homeworkList = null,Object? notificationList = null,Object? subjectsData = null,Object? timetable = null,Object? visitorList = null,Object? bookList = null,Object? teacherList = null,}) {
  return _then(_self.copyWith(
attendancePercentage: null == attendancePercentage ? _self.attendancePercentage : attendancePercentage // ignore: cast_nullable_to_non_nullable
as int,homeworkList: null == homeworkList ? _self.homeworkList : homeworkList // ignore: cast_nullable_to_non_nullable
as List<dynamic>,notificationList: null == notificationList ? _self.notificationList : notificationList // ignore: cast_nullable_to_non_nullable
as List<dynamic>,subjectsData: null == subjectsData ? _self.subjectsData : subjectsData // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,timetable: null == timetable ? _self.timetable : timetable // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,visitorList: null == visitorList ? _self.visitorList : visitorList // ignore: cast_nullable_to_non_nullable
as List<dynamic>,bookList: null == bookList ? _self.bookList : bookList // ignore: cast_nullable_to_non_nullable
as List<dynamic>,teacherList: null == teacherList ? _self.teacherList : teacherList // ignore: cast_nullable_to_non_nullable
as List<dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [DashboardModel].
extension DashboardModelPatterns on DashboardModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DashboardModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DashboardModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DashboardModel value)  $default,){
final _that = this;
switch (_that) {
case _DashboardModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DashboardModel value)?  $default,){
final _that = this;
switch (_that) {
case _DashboardModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'attendence_percentage')  int attendancePercentage, @JsonKey(name: 'homeworklist')  List<dynamic> homeworkList, @JsonKey(name: 'notificationlist')  List<dynamic> notificationList, @JsonKey(name: 'subjects_data')  Map<String, dynamic> subjectsData, @JsonKey(name: 'timetable')  Map<String, dynamic> timetable, @JsonKey(name: 'visitor_list')  List<dynamic> visitorList, @JsonKey(name: 'bookList')  List<dynamic> bookList, @JsonKey(name: 'teacherlist')  List<dynamic> teacherList)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DashboardModel() when $default != null:
return $default(_that.attendancePercentage,_that.homeworkList,_that.notificationList,_that.subjectsData,_that.timetable,_that.visitorList,_that.bookList,_that.teacherList);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'attendence_percentage')  int attendancePercentage, @JsonKey(name: 'homeworklist')  List<dynamic> homeworkList, @JsonKey(name: 'notificationlist')  List<dynamic> notificationList, @JsonKey(name: 'subjects_data')  Map<String, dynamic> subjectsData, @JsonKey(name: 'timetable')  Map<String, dynamic> timetable, @JsonKey(name: 'visitor_list')  List<dynamic> visitorList, @JsonKey(name: 'bookList')  List<dynamic> bookList, @JsonKey(name: 'teacherlist')  List<dynamic> teacherList)  $default,) {final _that = this;
switch (_that) {
case _DashboardModel():
return $default(_that.attendancePercentage,_that.homeworkList,_that.notificationList,_that.subjectsData,_that.timetable,_that.visitorList,_that.bookList,_that.teacherList);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'attendence_percentage')  int attendancePercentage, @JsonKey(name: 'homeworklist')  List<dynamic> homeworkList, @JsonKey(name: 'notificationlist')  List<dynamic> notificationList, @JsonKey(name: 'subjects_data')  Map<String, dynamic> subjectsData, @JsonKey(name: 'timetable')  Map<String, dynamic> timetable, @JsonKey(name: 'visitor_list')  List<dynamic> visitorList, @JsonKey(name: 'bookList')  List<dynamic> bookList, @JsonKey(name: 'teacherlist')  List<dynamic> teacherList)?  $default,) {final _that = this;
switch (_that) {
case _DashboardModel() when $default != null:
return $default(_that.attendancePercentage,_that.homeworkList,_that.notificationList,_that.subjectsData,_that.timetable,_that.visitorList,_that.bookList,_that.teacherList);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DashboardModel implements DashboardModel {
  const _DashboardModel({@JsonKey(name: 'attendence_percentage') this.attendancePercentage = 0, @JsonKey(name: 'homeworklist') final  List<dynamic> homeworkList = const [], @JsonKey(name: 'notificationlist') final  List<dynamic> notificationList = const [], @JsonKey(name: 'subjects_data') final  Map<String, dynamic> subjectsData = const {}, @JsonKey(name: 'timetable') final  Map<String, dynamic> timetable = const {}, @JsonKey(name: 'visitor_list') final  List<dynamic> visitorList = const [], @JsonKey(name: 'bookList') final  List<dynamic> bookList = const [], @JsonKey(name: 'teacherlist') final  List<dynamic> teacherList = const []}): _homeworkList = homeworkList,_notificationList = notificationList,_subjectsData = subjectsData,_timetable = timetable,_visitorList = visitorList,_bookList = bookList,_teacherList = teacherList;
  factory _DashboardModel.fromJson(Map<String, dynamic> json) => _$DashboardModelFromJson(json);

@override@JsonKey(name: 'attendence_percentage') final  int attendancePercentage;
 final  List<dynamic> _homeworkList;
@override@JsonKey(name: 'homeworklist') List<dynamic> get homeworkList {
  if (_homeworkList is EqualUnmodifiableListView) return _homeworkList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_homeworkList);
}

 final  List<dynamic> _notificationList;
@override@JsonKey(name: 'notificationlist') List<dynamic> get notificationList {
  if (_notificationList is EqualUnmodifiableListView) return _notificationList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_notificationList);
}

 final  Map<String, dynamic> _subjectsData;
@override@JsonKey(name: 'subjects_data') Map<String, dynamic> get subjectsData {
  if (_subjectsData is EqualUnmodifiableMapView) return _subjectsData;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_subjectsData);
}

 final  Map<String, dynamic> _timetable;
@override@JsonKey(name: 'timetable') Map<String, dynamic> get timetable {
  if (_timetable is EqualUnmodifiableMapView) return _timetable;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_timetable);
}

 final  List<dynamic> _visitorList;
@override@JsonKey(name: 'visitor_list') List<dynamic> get visitorList {
  if (_visitorList is EqualUnmodifiableListView) return _visitorList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_visitorList);
}

 final  List<dynamic> _bookList;
@override@JsonKey(name: 'bookList') List<dynamic> get bookList {
  if (_bookList is EqualUnmodifiableListView) return _bookList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_bookList);
}

 final  List<dynamic> _teacherList;
@override@JsonKey(name: 'teacherlist') List<dynamic> get teacherList {
  if (_teacherList is EqualUnmodifiableListView) return _teacherList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_teacherList);
}


/// Create a copy of DashboardModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DashboardModelCopyWith<_DashboardModel> get copyWith => __$DashboardModelCopyWithImpl<_DashboardModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DashboardModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DashboardModel&&(identical(other.attendancePercentage, attendancePercentage) || other.attendancePercentage == attendancePercentage)&&const DeepCollectionEquality().equals(other._homeworkList, _homeworkList)&&const DeepCollectionEquality().equals(other._notificationList, _notificationList)&&const DeepCollectionEquality().equals(other._subjectsData, _subjectsData)&&const DeepCollectionEquality().equals(other._timetable, _timetable)&&const DeepCollectionEquality().equals(other._visitorList, _visitorList)&&const DeepCollectionEquality().equals(other._bookList, _bookList)&&const DeepCollectionEquality().equals(other._teacherList, _teacherList));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,attendancePercentage,const DeepCollectionEquality().hash(_homeworkList),const DeepCollectionEquality().hash(_notificationList),const DeepCollectionEquality().hash(_subjectsData),const DeepCollectionEquality().hash(_timetable),const DeepCollectionEquality().hash(_visitorList),const DeepCollectionEquality().hash(_bookList),const DeepCollectionEquality().hash(_teacherList));

@override
String toString() {
  return 'DashboardModel(attendancePercentage: $attendancePercentage, homeworkList: $homeworkList, notificationList: $notificationList, subjectsData: $subjectsData, timetable: $timetable, visitorList: $visitorList, bookList: $bookList, teacherList: $teacherList)';
}


}

/// @nodoc
abstract mixin class _$DashboardModelCopyWith<$Res> implements $DashboardModelCopyWith<$Res> {
  factory _$DashboardModelCopyWith(_DashboardModel value, $Res Function(_DashboardModel) _then) = __$DashboardModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'attendence_percentage') int attendancePercentage,@JsonKey(name: 'homeworklist') List<dynamic> homeworkList,@JsonKey(name: 'notificationlist') List<dynamic> notificationList,@JsonKey(name: 'subjects_data') Map<String, dynamic> subjectsData,@JsonKey(name: 'timetable') Map<String, dynamic> timetable,@JsonKey(name: 'visitor_list') List<dynamic> visitorList,@JsonKey(name: 'bookList') List<dynamic> bookList,@JsonKey(name: 'teacherlist') List<dynamic> teacherList
});




}
/// @nodoc
class __$DashboardModelCopyWithImpl<$Res>
    implements _$DashboardModelCopyWith<$Res> {
  __$DashboardModelCopyWithImpl(this._self, this._then);

  final _DashboardModel _self;
  final $Res Function(_DashboardModel) _then;

/// Create a copy of DashboardModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? attendancePercentage = null,Object? homeworkList = null,Object? notificationList = null,Object? subjectsData = null,Object? timetable = null,Object? visitorList = null,Object? bookList = null,Object? teacherList = null,}) {
  return _then(_DashboardModel(
attendancePercentage: null == attendancePercentage ? _self.attendancePercentage : attendancePercentage // ignore: cast_nullable_to_non_nullable
as int,homeworkList: null == homeworkList ? _self._homeworkList : homeworkList // ignore: cast_nullable_to_non_nullable
as List<dynamic>,notificationList: null == notificationList ? _self._notificationList : notificationList // ignore: cast_nullable_to_non_nullable
as List<dynamic>,subjectsData: null == subjectsData ? _self._subjectsData : subjectsData // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,timetable: null == timetable ? _self._timetable : timetable // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,visitorList: null == visitorList ? _self._visitorList : visitorList // ignore: cast_nullable_to_non_nullable
as List<dynamic>,bookList: null == bookList ? _self._bookList : bookList // ignore: cast_nullable_to_non_nullable
as List<dynamic>,teacherList: null == teacherList ? _self._teacherList : teacherList // ignore: cast_nullable_to_non_nullable
as List<dynamic>,
  ));
}


}

// dart format on
