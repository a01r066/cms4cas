// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hit_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HitRecord {

 String get id; String get tableId; String get playerLabel; DateTime get gamingDay; double get playerDrop; double get casinoResult; String get note; String get recordedBy;
/// Create a copy of HitRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HitRecordCopyWith<HitRecord> get copyWith => _$HitRecordCopyWithImpl<HitRecord>(this as HitRecord, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as HitRecord;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HitRecord&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.tableId, _this.tableId) || other.tableId == _this.tableId)&&(identical(other.playerLabel, _this.playerLabel) || other.playerLabel == _this.playerLabel)&&(identical(other.gamingDay, _this.gamingDay) || other.gamingDay == _this.gamingDay)&&(identical(other.playerDrop, _this.playerDrop) || other.playerDrop == _this.playerDrop)&&(identical(other.casinoResult, _this.casinoResult) || other.casinoResult == _this.casinoResult)&&(identical(other.note, _this.note) || other.note == _this.note)&&(identical(other.recordedBy, _this.recordedBy) || other.recordedBy == _this.recordedBy));
}


@override
int get hashCode {
  final _this = this as HitRecord;
  return Object.hash(runtimeType,_this.id,_this.tableId,_this.playerLabel,_this.gamingDay,_this.playerDrop,_this.casinoResult,_this.note,_this.recordedBy);
}

@override
String toString() {
  final _this = this as HitRecord;
  return 'HitRecord(id: ${_this.id}, tableId: ${_this.tableId}, playerLabel: ${_this.playerLabel}, gamingDay: ${_this.gamingDay}, playerDrop: ${_this.playerDrop}, casinoResult: ${_this.casinoResult}, note: ${_this.note}, recordedBy: ${_this.recordedBy})';
}


}

/// @nodoc
abstract mixin class $HitRecordCopyWith<$Res>  {
  factory $HitRecordCopyWith(HitRecord value, $Res Function(HitRecord) _then) = _$HitRecordCopyWithImpl;
@useResult
$Res call({
 String id, String tableId, String playerLabel, DateTime gamingDay, double playerDrop, double casinoResult, String note, String recordedBy
});




}
/// @nodoc
class _$HitRecordCopyWithImpl<$Res>
    implements $HitRecordCopyWith<$Res> {
  _$HitRecordCopyWithImpl(this._self, this._then);

  final HitRecord _self;
  final $Res Function(HitRecord) _then;

/// Create a copy of HitRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? tableId = null,Object? playerLabel = null,Object? gamingDay = null,Object? playerDrop = null,Object? casinoResult = null,Object? note = null,Object? recordedBy = null,}) {
  return _then(HitRecord(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tableId: null == tableId ? _self.tableId : tableId // ignore: cast_nullable_to_non_nullable
as String,playerLabel: null == playerLabel ? _self.playerLabel : playerLabel // ignore: cast_nullable_to_non_nullable
as String,gamingDay: null == gamingDay ? _self.gamingDay : gamingDay // ignore: cast_nullable_to_non_nullable
as DateTime,playerDrop: null == playerDrop ? _self.playerDrop : playerDrop // ignore: cast_nullable_to_non_nullable
as double,casinoResult: null == casinoResult ? _self.casinoResult : casinoResult // ignore: cast_nullable_to_non_nullable
as double,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,recordedBy: null == recordedBy ? _self.recordedBy : recordedBy // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [HitRecord].
extension HitRecordPatterns on HitRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HitRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HitRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HitRecord value)  $default,){
final _that = this;
switch (_that) {
case _HitRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HitRecord value)?  $default,){
final _that = this;
switch (_that) {
case _HitRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String tableId,  String playerLabel,  DateTime gamingDay,  double playerDrop,  double casinoResult,  String note,  String recordedBy)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HitRecord() when $default != null:
return $default(_that.id,_that.tableId,_that.playerLabel,_that.gamingDay,_that.playerDrop,_that.casinoResult,_that.note,_that.recordedBy);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String tableId,  String playerLabel,  DateTime gamingDay,  double playerDrop,  double casinoResult,  String note,  String recordedBy)  $default,) {final _that = this;
switch (_that) {
case _HitRecord():
return $default(_that.id,_that.tableId,_that.playerLabel,_that.gamingDay,_that.playerDrop,_that.casinoResult,_that.note,_that.recordedBy);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String tableId,  String playerLabel,  DateTime gamingDay,  double playerDrop,  double casinoResult,  String note,  String recordedBy)?  $default,) {final _that = this;
switch (_that) {
case _HitRecord() when $default != null:
return $default(_that.id,_that.tableId,_that.playerLabel,_that.gamingDay,_that.playerDrop,_that.casinoResult,_that.note,_that.recordedBy);case _:
  return null;

}
}

}

/// @nodoc


class _HitRecord implements HitRecord {
  const _HitRecord({required this.id, required this.tableId, required this.playerLabel, required this.gamingDay, required this.playerDrop, required this.casinoResult, this.note = '', this.recordedBy = ''});
  

@override final  String id;
@override final  String tableId;
@override final  String playerLabel;
@override final  DateTime gamingDay;
@override final  double playerDrop;
@override final  double casinoResult;
@override@JsonKey() final  String note;
@override@JsonKey() final  String recordedBy;

/// Create a copy of HitRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HitRecordCopyWith<_HitRecord> get copyWith => __$HitRecordCopyWithImpl<_HitRecord>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _HitRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.tableId, tableId) || other.tableId == tableId)&&(identical(other.playerLabel, playerLabel) || other.playerLabel == playerLabel)&&(identical(other.gamingDay, gamingDay) || other.gamingDay == gamingDay)&&(identical(other.playerDrop, playerDrop) || other.playerDrop == playerDrop)&&(identical(other.casinoResult, casinoResult) || other.casinoResult == casinoResult)&&(identical(other.note, note) || other.note == note)&&(identical(other.recordedBy, recordedBy) || other.recordedBy == recordedBy));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,tableId,playerLabel,gamingDay,playerDrop,casinoResult,note,recordedBy);
}

@override
String toString() {
    return 'HitRecord(id: $id, tableId: $tableId, playerLabel: $playerLabel, gamingDay: $gamingDay, playerDrop: $playerDrop, casinoResult: $casinoResult, note: $note, recordedBy: $recordedBy)';
}


}

/// @nodoc
abstract mixin class _$HitRecordCopyWith<$Res> implements $HitRecordCopyWith<$Res> {
  factory _$HitRecordCopyWith(_HitRecord value, $Res Function(_HitRecord) _then) = __$HitRecordCopyWithImpl;
@override @useResult
$Res call({
 String id, String tableId, String playerLabel, DateTime gamingDay, double playerDrop, double casinoResult, String note, String recordedBy
});




}
/// @nodoc
class __$HitRecordCopyWithImpl<$Res>
    implements _$HitRecordCopyWith<$Res> {
  __$HitRecordCopyWithImpl(this._self, this._then);

  final _HitRecord _self;
  final $Res Function(_HitRecord) _then;

/// Create a copy of HitRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? tableId = null,Object? playerLabel = null,Object? gamingDay = null,Object? playerDrop = null,Object? casinoResult = null,Object? note = null,Object? recordedBy = null,}) {
  return _then(_HitRecord(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tableId: null == tableId ? _self.tableId : tableId // ignore: cast_nullable_to_non_nullable
as String,playerLabel: null == playerLabel ? _self.playerLabel : playerLabel // ignore: cast_nullable_to_non_nullable
as String,gamingDay: null == gamingDay ? _self.gamingDay : gamingDay // ignore: cast_nullable_to_non_nullable
as DateTime,playerDrop: null == playerDrop ? _self.playerDrop : playerDrop // ignore: cast_nullable_to_non_nullable
as double,casinoResult: null == casinoResult ? _self.casinoResult : casinoResult // ignore: cast_nullable_to_non_nullable
as double,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,recordedBy: null == recordedBy ? _self.recordedBy : recordedBy // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
