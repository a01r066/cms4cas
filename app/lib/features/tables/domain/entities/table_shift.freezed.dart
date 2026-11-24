// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'table_shift.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TableShift {

 String get id; String get tableId; String get shift; String get recordedBy; DateTime get gamingDay; DateTime get recordedAt; TableShiftInput get input;
/// Create a copy of TableShift
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TableShiftCopyWith<TableShift> get copyWith => _$TableShiftCopyWithImpl<TableShift>(this as TableShift, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as TableShift;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TableShift&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.tableId, _this.tableId) || other.tableId == _this.tableId)&&(identical(other.shift, _this.shift) || other.shift == _this.shift)&&(identical(other.recordedBy, _this.recordedBy) || other.recordedBy == _this.recordedBy)&&(identical(other.gamingDay, _this.gamingDay) || other.gamingDay == _this.gamingDay)&&(identical(other.recordedAt, _this.recordedAt) || other.recordedAt == _this.recordedAt)&&(identical(other.input, _this.input) || other.input == _this.input));
}


@override
int get hashCode {
  final _this = this as TableShift;
  return Object.hash(runtimeType,_this.id,_this.tableId,_this.shift,_this.recordedBy,_this.gamingDay,_this.recordedAt,_this.input);
}

@override
String toString() {
  final _this = this as TableShift;
  return 'TableShift(id: ${_this.id}, tableId: ${_this.tableId}, shift: ${_this.shift}, recordedBy: ${_this.recordedBy}, gamingDay: ${_this.gamingDay}, recordedAt: ${_this.recordedAt}, input: ${_this.input})';
}


}

/// @nodoc
abstract mixin class $TableShiftCopyWith<$Res>  {
  factory $TableShiftCopyWith(TableShift value, $Res Function(TableShift) _then) = _$TableShiftCopyWithImpl;
@useResult
$Res call({
 String id, String tableId, String shift, String recordedBy, DateTime gamingDay, DateTime recordedAt, TableShiftInput input
});




}
/// @nodoc
class _$TableShiftCopyWithImpl<$Res>
    implements $TableShiftCopyWith<$Res> {
  _$TableShiftCopyWithImpl(this._self, this._then);

  final TableShift _self;
  final $Res Function(TableShift) _then;

/// Create a copy of TableShift
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? tableId = null,Object? shift = null,Object? recordedBy = null,Object? gamingDay = null,Object? recordedAt = null,Object? input = null,}) {
  return _then(TableShift(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tableId: null == tableId ? _self.tableId : tableId // ignore: cast_nullable_to_non_nullable
as String,shift: null == shift ? _self.shift : shift // ignore: cast_nullable_to_non_nullable
as String,recordedBy: null == recordedBy ? _self.recordedBy : recordedBy // ignore: cast_nullable_to_non_nullable
as String,gamingDay: null == gamingDay ? _self.gamingDay : gamingDay // ignore: cast_nullable_to_non_nullable
as DateTime,recordedAt: null == recordedAt ? _self.recordedAt : recordedAt // ignore: cast_nullable_to_non_nullable
as DateTime,input: null == input ? _self.input : input // ignore: cast_nullable_to_non_nullable
as TableShiftInput,
  ));
}

}


/// Adds pattern-matching-related methods to [TableShift].
extension TableShiftPatterns on TableShift {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TableShift value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TableShift() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TableShift value)  $default,){
final _that = this;
switch (_that) {
case _TableShift():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TableShift value)?  $default,){
final _that = this;
switch (_that) {
case _TableShift() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String tableId,  String shift,  String recordedBy,  DateTime gamingDay,  DateTime recordedAt,  TableShiftInput input)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TableShift() when $default != null:
return $default(_that.id,_that.tableId,_that.shift,_that.recordedBy,_that.gamingDay,_that.recordedAt,_that.input);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String tableId,  String shift,  String recordedBy,  DateTime gamingDay,  DateTime recordedAt,  TableShiftInput input)  $default,) {final _that = this;
switch (_that) {
case _TableShift():
return $default(_that.id,_that.tableId,_that.shift,_that.recordedBy,_that.gamingDay,_that.recordedAt,_that.input);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String tableId,  String shift,  String recordedBy,  DateTime gamingDay,  DateTime recordedAt,  TableShiftInput input)?  $default,) {final _that = this;
switch (_that) {
case _TableShift() when $default != null:
return $default(_that.id,_that.tableId,_that.shift,_that.recordedBy,_that.gamingDay,_that.recordedAt,_that.input);case _:
  return null;

}
}

}

/// @nodoc


class _TableShift extends TableShift {
  const _TableShift({required this.id, required this.tableId, required this.shift, required this.recordedBy, required this.gamingDay, required this.recordedAt, required this.input}): super._();
  

@override final  String id;
@override final  String tableId;
@override final  String shift;
@override final  String recordedBy;
@override final  DateTime gamingDay;
@override final  DateTime recordedAt;
@override final  TableShiftInput input;

/// Create a copy of TableShift
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TableShiftCopyWith<_TableShift> get copyWith => __$TableShiftCopyWithImpl<_TableShift>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TableShift&&(identical(other.id, id) || other.id == id)&&(identical(other.tableId, tableId) || other.tableId == tableId)&&(identical(other.shift, shift) || other.shift == shift)&&(identical(other.recordedBy, recordedBy) || other.recordedBy == recordedBy)&&(identical(other.gamingDay, gamingDay) || other.gamingDay == gamingDay)&&(identical(other.recordedAt, recordedAt) || other.recordedAt == recordedAt)&&(identical(other.input, input) || other.input == input));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,tableId,shift,recordedBy,gamingDay,recordedAt,input);
}

@override
String toString() {
    return 'TableShift(id: $id, tableId: $tableId, shift: $shift, recordedBy: $recordedBy, gamingDay: $gamingDay, recordedAt: $recordedAt, input: $input)';
}


}

/// @nodoc
abstract mixin class _$TableShiftCopyWith<$Res> implements $TableShiftCopyWith<$Res> {
  factory _$TableShiftCopyWith(_TableShift value, $Res Function(_TableShift) _then) = __$TableShiftCopyWithImpl;
@override @useResult
$Res call({
 String id, String tableId, String shift, String recordedBy, DateTime gamingDay, DateTime recordedAt, TableShiftInput input
});




}
/// @nodoc
class __$TableShiftCopyWithImpl<$Res>
    implements _$TableShiftCopyWith<$Res> {
  __$TableShiftCopyWithImpl(this._self, this._then);

  final _TableShift _self;
  final $Res Function(_TableShift) _then;

/// Create a copy of TableShift
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? tableId = null,Object? shift = null,Object? recordedBy = null,Object? gamingDay = null,Object? recordedAt = null,Object? input = null,}) {
  return _then(_TableShift(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tableId: null == tableId ? _self.tableId : tableId // ignore: cast_nullable_to_non_nullable
as String,shift: null == shift ? _self.shift : shift // ignore: cast_nullable_to_non_nullable
as String,recordedBy: null == recordedBy ? _self.recordedBy : recordedBy // ignore: cast_nullable_to_non_nullable
as String,gamingDay: null == gamingDay ? _self.gamingDay : gamingDay // ignore: cast_nullable_to_non_nullable
as DateTime,recordedAt: null == recordedAt ? _self.recordedAt : recordedAt // ignore: cast_nullable_to_non_nullable
as DateTime,input: null == input ? _self.input : input // ignore: cast_nullable_to_non_nullable
as TableShiftInput,
  ));
}


}

// dart format on
