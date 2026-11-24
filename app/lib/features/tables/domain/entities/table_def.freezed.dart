// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'table_def.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TableDef {

 String get id; String get name; String get gameId; String get pit; double get minBet; double get maxBet; double get baseHold; MarkerSystem get system;
/// Create a copy of TableDef
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TableDefCopyWith<TableDef> get copyWith => _$TableDefCopyWithImpl<TableDef>(this as TableDef, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as TableDef;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TableDef&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.gameId, _this.gameId) || other.gameId == _this.gameId)&&(identical(other.pit, _this.pit) || other.pit == _this.pit)&&(identical(other.minBet, _this.minBet) || other.minBet == _this.minBet)&&(identical(other.maxBet, _this.maxBet) || other.maxBet == _this.maxBet)&&(identical(other.baseHold, _this.baseHold) || other.baseHold == _this.baseHold)&&(identical(other.system, _this.system) || other.system == _this.system));
}


@override
int get hashCode {
  final _this = this as TableDef;
  return Object.hash(runtimeType,_this.id,_this.name,_this.gameId,_this.pit,_this.minBet,_this.maxBet,_this.baseHold,_this.system);
}

@override
String toString() {
  final _this = this as TableDef;
  return 'TableDef(id: ${_this.id}, name: ${_this.name}, gameId: ${_this.gameId}, pit: ${_this.pit}, minBet: ${_this.minBet}, maxBet: ${_this.maxBet}, baseHold: ${_this.baseHold}, system: ${_this.system})';
}


}

/// @nodoc
abstract mixin class $TableDefCopyWith<$Res>  {
  factory $TableDefCopyWith(TableDef value, $Res Function(TableDef) _then) = _$TableDefCopyWithImpl;
@useResult
$Res call({
 String id, String name, String gameId, String pit, double minBet, double maxBet, double baseHold, MarkerSystem system
});




}
/// @nodoc
class _$TableDefCopyWithImpl<$Res>
    implements $TableDefCopyWith<$Res> {
  _$TableDefCopyWithImpl(this._self, this._then);

  final TableDef _self;
  final $Res Function(TableDef) _then;

/// Create a copy of TableDef
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? gameId = null,Object? pit = null,Object? minBet = null,Object? maxBet = null,Object? baseHold = null,Object? system = null,}) {
  return _then(TableDef(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,gameId: null == gameId ? _self.gameId : gameId // ignore: cast_nullable_to_non_nullable
as String,pit: null == pit ? _self.pit : pit // ignore: cast_nullable_to_non_nullable
as String,minBet: null == minBet ? _self.minBet : minBet // ignore: cast_nullable_to_non_nullable
as double,maxBet: null == maxBet ? _self.maxBet : maxBet // ignore: cast_nullable_to_non_nullable
as double,baseHold: null == baseHold ? _self.baseHold : baseHold // ignore: cast_nullable_to_non_nullable
as double,system: null == system ? _self.system : system // ignore: cast_nullable_to_non_nullable
as MarkerSystem,
  ));
}

}


/// Adds pattern-matching-related methods to [TableDef].
extension TableDefPatterns on TableDef {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TableDef value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TableDef() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TableDef value)  $default,){
final _that = this;
switch (_that) {
case _TableDef():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TableDef value)?  $default,){
final _that = this;
switch (_that) {
case _TableDef() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String gameId,  String pit,  double minBet,  double maxBet,  double baseHold,  MarkerSystem system)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TableDef() when $default != null:
return $default(_that.id,_that.name,_that.gameId,_that.pit,_that.minBet,_that.maxBet,_that.baseHold,_that.system);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String gameId,  String pit,  double minBet,  double maxBet,  double baseHold,  MarkerSystem system)  $default,) {final _that = this;
switch (_that) {
case _TableDef():
return $default(_that.id,_that.name,_that.gameId,_that.pit,_that.minBet,_that.maxBet,_that.baseHold,_that.system);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String gameId,  String pit,  double minBet,  double maxBet,  double baseHold,  MarkerSystem system)?  $default,) {final _that = this;
switch (_that) {
case _TableDef() when $default != null:
return $default(_that.id,_that.name,_that.gameId,_that.pit,_that.minBet,_that.maxBet,_that.baseHold,_that.system);case _:
  return null;

}
}

}

/// @nodoc


class _TableDef implements TableDef {
  const _TableDef({required this.id, required this.name, required this.gameId, this.pit = '', this.minBet = 0, this.maxBet = 0, this.baseHold = 0, this.system = MarkerSystem.marker});
  

@override final  String id;
@override final  String name;
@override final  String gameId;
@override@JsonKey() final  String pit;
@override@JsonKey() final  double minBet;
@override@JsonKey() final  double maxBet;
@override@JsonKey() final  double baseHold;
@override@JsonKey() final  MarkerSystem system;

/// Create a copy of TableDef
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TableDefCopyWith<_TableDef> get copyWith => __$TableDefCopyWithImpl<_TableDef>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TableDef&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.gameId, gameId) || other.gameId == gameId)&&(identical(other.pit, pit) || other.pit == pit)&&(identical(other.minBet, minBet) || other.minBet == minBet)&&(identical(other.maxBet, maxBet) || other.maxBet == maxBet)&&(identical(other.baseHold, baseHold) || other.baseHold == baseHold)&&(identical(other.system, system) || other.system == system));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,name,gameId,pit,minBet,maxBet,baseHold,system);
}

@override
String toString() {
    return 'TableDef(id: $id, name: $name, gameId: $gameId, pit: $pit, minBet: $minBet, maxBet: $maxBet, baseHold: $baseHold, system: $system)';
}


}

/// @nodoc
abstract mixin class _$TableDefCopyWith<$Res> implements $TableDefCopyWith<$Res> {
  factory _$TableDefCopyWith(_TableDef value, $Res Function(_TableDef) _then) = __$TableDefCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String gameId, String pit, double minBet, double maxBet, double baseHold, MarkerSystem system
});




}
/// @nodoc
class __$TableDefCopyWithImpl<$Res>
    implements _$TableDefCopyWith<$Res> {
  __$TableDefCopyWithImpl(this._self, this._then);

  final _TableDef _self;
  final $Res Function(_TableDef) _then;

/// Create a copy of TableDef
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? gameId = null,Object? pit = null,Object? minBet = null,Object? maxBet = null,Object? baseHold = null,Object? system = null,}) {
  return _then(_TableDef(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,gameId: null == gameId ? _self.gameId : gameId // ignore: cast_nullable_to_non_nullable
as String,pit: null == pit ? _self.pit : pit // ignore: cast_nullable_to_non_nullable
as String,minBet: null == minBet ? _self.minBet : minBet // ignore: cast_nullable_to_non_nullable
as double,maxBet: null == maxBet ? _self.maxBet : maxBet // ignore: cast_nullable_to_non_nullable
as double,baseHold: null == baseHold ? _self.baseHold : baseHold // ignore: cast_nullable_to_non_nullable
as double,system: null == system ? _self.system : system // ignore: cast_nullable_to_non_nullable
as MarkerSystem,
  ));
}


}

// dart format on
