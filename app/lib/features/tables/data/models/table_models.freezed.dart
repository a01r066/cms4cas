// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'table_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TableDefModel {

 String get id; String get name; String get gameId; String get pit; double get minBet; double get maxBet; double get baseHold; String get system;
/// Create a copy of TableDefModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TableDefModelCopyWith<TableDefModel> get copyWith => _$TableDefModelCopyWithImpl<TableDefModel>(this as TableDefModel, _$identity);

  /// Serializes this TableDefModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TableDefModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TableDefModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.gameId, _this.gameId) || other.gameId == _this.gameId)&&(identical(other.pit, _this.pit) || other.pit == _this.pit)&&(identical(other.minBet, _this.minBet) || other.minBet == _this.minBet)&&(identical(other.maxBet, _this.maxBet) || other.maxBet == _this.maxBet)&&(identical(other.baseHold, _this.baseHold) || other.baseHold == _this.baseHold)&&(identical(other.system, _this.system) || other.system == _this.system));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TableDefModel;
  return Object.hash(runtimeType,_this.id,_this.name,_this.gameId,_this.pit,_this.minBet,_this.maxBet,_this.baseHold,_this.system);
}

@override
String toString() {
  final _this = this as TableDefModel;
  return 'TableDefModel(id: ${_this.id}, name: ${_this.name}, gameId: ${_this.gameId}, pit: ${_this.pit}, minBet: ${_this.minBet}, maxBet: ${_this.maxBet}, baseHold: ${_this.baseHold}, system: ${_this.system})';
}


}

/// @nodoc
abstract mixin class $TableDefModelCopyWith<$Res>  {
  factory $TableDefModelCopyWith(TableDefModel value, $Res Function(TableDefModel) _then) = _$TableDefModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String gameId, String pit, double minBet, double maxBet, double baseHold, String system
});




}
/// @nodoc
class _$TableDefModelCopyWithImpl<$Res>
    implements $TableDefModelCopyWith<$Res> {
  _$TableDefModelCopyWithImpl(this._self, this._then);

  final TableDefModel _self;
  final $Res Function(TableDefModel) _then;

/// Create a copy of TableDefModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? gameId = null,Object? pit = null,Object? minBet = null,Object? maxBet = null,Object? baseHold = null,Object? system = null,}) {
  return _then(TableDefModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,gameId: null == gameId ? _self.gameId : gameId // ignore: cast_nullable_to_non_nullable
as String,pit: null == pit ? _self.pit : pit // ignore: cast_nullable_to_non_nullable
as String,minBet: null == minBet ? _self.minBet : minBet // ignore: cast_nullable_to_non_nullable
as double,maxBet: null == maxBet ? _self.maxBet : maxBet // ignore: cast_nullable_to_non_nullable
as double,baseHold: null == baseHold ? _self.baseHold : baseHold // ignore: cast_nullable_to_non_nullable
as double,system: null == system ? _self.system : system // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TableDefModel].
extension TableDefModelPatterns on TableDefModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TableDefModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TableDefModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TableDefModel value)  $default,){
final _that = this;
switch (_that) {
case _TableDefModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TableDefModel value)?  $default,){
final _that = this;
switch (_that) {
case _TableDefModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String gameId,  String pit,  double minBet,  double maxBet,  double baseHold,  String system)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TableDefModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String gameId,  String pit,  double minBet,  double maxBet,  double baseHold,  String system)  $default,) {final _that = this;
switch (_that) {
case _TableDefModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String gameId,  String pit,  double minBet,  double maxBet,  double baseHold,  String system)?  $default,) {final _that = this;
switch (_that) {
case _TableDefModel() when $default != null:
return $default(_that.id,_that.name,_that.gameId,_that.pit,_that.minBet,_that.maxBet,_that.baseHold,_that.system);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TableDefModel extends TableDefModel {
  const _TableDefModel({required this.id, this.name = '', this.gameId = 'blackjack', this.pit = '', this.minBet = 0, this.maxBet = 0, this.baseHold = 0, this.system = 'marker'}): super._();
  factory _TableDefModel.fromJson(Map<String, dynamic> json) => _$TableDefModelFromJson(json);

@override final  String id;
@override@JsonKey() final  String name;
@override@JsonKey() final  String gameId;
@override@JsonKey() final  String pit;
@override@JsonKey() final  double minBet;
@override@JsonKey() final  double maxBet;
@override@JsonKey() final  double baseHold;
@override@JsonKey() final  String system;

/// Create a copy of TableDefModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TableDefModelCopyWith<_TableDefModel> get copyWith => __$TableDefModelCopyWithImpl<_TableDefModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TableDefModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TableDefModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.gameId, gameId) || other.gameId == gameId)&&(identical(other.pit, pit) || other.pit == pit)&&(identical(other.minBet, minBet) || other.minBet == minBet)&&(identical(other.maxBet, maxBet) || other.maxBet == maxBet)&&(identical(other.baseHold, baseHold) || other.baseHold == baseHold)&&(identical(other.system, system) || other.system == system));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,gameId,pit,minBet,maxBet,baseHold,system);
}

@override
String toString() {
    return 'TableDefModel(id: $id, name: $name, gameId: $gameId, pit: $pit, minBet: $minBet, maxBet: $maxBet, baseHold: $baseHold, system: $system)';
}


}

/// @nodoc
abstract mixin class _$TableDefModelCopyWith<$Res> implements $TableDefModelCopyWith<$Res> {
  factory _$TableDefModelCopyWith(_TableDefModel value, $Res Function(_TableDefModel) _then) = __$TableDefModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String gameId, String pit, double minBet, double maxBet, double baseHold, String system
});




}
/// @nodoc
class __$TableDefModelCopyWithImpl<$Res>
    implements _$TableDefModelCopyWith<$Res> {
  __$TableDefModelCopyWithImpl(this._self, this._then);

  final _TableDefModel _self;
  final $Res Function(_TableDefModel) _then;

/// Create a copy of TableDefModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? gameId = null,Object? pit = null,Object? minBet = null,Object? maxBet = null,Object? baseHold = null,Object? system = null,}) {
  return _then(_TableDefModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,gameId: null == gameId ? _self.gameId : gameId // ignore: cast_nullable_to_non_nullable
as String,pit: null == pit ? _self.pit : pit // ignore: cast_nullable_to_non_nullable
as String,minBet: null == minBet ? _self.minBet : minBet // ignore: cast_nullable_to_non_nullable
as double,maxBet: null == maxBet ? _self.maxBet : maxBet // ignore: cast_nullable_to_non_nullable
as double,baseHold: null == baseHold ? _self.baseHold : baseHold // ignore: cast_nullable_to_non_nullable
as double,system: null == system ? _self.system : system // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$TableShiftModel {

 String get id; String get tableId; String get shift; String get recordedBy; DateTime get gamingDay; DateTime? get recordedAt; double get openingInventory; double get fills; double get credits; double get closingInventory; double get currencyInBox; double get chequesInBox; double get markersIssued; double get markersRedeemedInPitCash; double get markersRedeemedInPitCheques; String get system; double get drop; double get win; double get hold; double get statisticalDrop;
/// Create a copy of TableShiftModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TableShiftModelCopyWith<TableShiftModel> get copyWith => _$TableShiftModelCopyWithImpl<TableShiftModel>(this as TableShiftModel, _$identity);

  /// Serializes this TableShiftModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TableShiftModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TableShiftModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.tableId, _this.tableId) || other.tableId == _this.tableId)&&(identical(other.shift, _this.shift) || other.shift == _this.shift)&&(identical(other.recordedBy, _this.recordedBy) || other.recordedBy == _this.recordedBy)&&(identical(other.gamingDay, _this.gamingDay) || other.gamingDay == _this.gamingDay)&&(identical(other.recordedAt, _this.recordedAt) || other.recordedAt == _this.recordedAt)&&(identical(other.openingInventory, _this.openingInventory) || other.openingInventory == _this.openingInventory)&&(identical(other.fills, _this.fills) || other.fills == _this.fills)&&(identical(other.credits, _this.credits) || other.credits == _this.credits)&&(identical(other.closingInventory, _this.closingInventory) || other.closingInventory == _this.closingInventory)&&(identical(other.currencyInBox, _this.currencyInBox) || other.currencyInBox == _this.currencyInBox)&&(identical(other.chequesInBox, _this.chequesInBox) || other.chequesInBox == _this.chequesInBox)&&(identical(other.markersIssued, _this.markersIssued) || other.markersIssued == _this.markersIssued)&&(identical(other.markersRedeemedInPitCash, _this.markersRedeemedInPitCash) || other.markersRedeemedInPitCash == _this.markersRedeemedInPitCash)&&(identical(other.markersRedeemedInPitCheques, _this.markersRedeemedInPitCheques) || other.markersRedeemedInPitCheques == _this.markersRedeemedInPitCheques)&&(identical(other.system, _this.system) || other.system == _this.system)&&(identical(other.drop, _this.drop) || other.drop == _this.drop)&&(identical(other.win, _this.win) || other.win == _this.win)&&(identical(other.hold, _this.hold) || other.hold == _this.hold)&&(identical(other.statisticalDrop, _this.statisticalDrop) || other.statisticalDrop == _this.statisticalDrop));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TableShiftModel;
  return Object.hashAll([runtimeType,_this.id,_this.tableId,_this.shift,_this.recordedBy,_this.gamingDay,_this.recordedAt,_this.openingInventory,_this.fills,_this.credits,_this.closingInventory,_this.currencyInBox,_this.chequesInBox,_this.markersIssued,_this.markersRedeemedInPitCash,_this.markersRedeemedInPitCheques,_this.system,_this.drop,_this.win,_this.hold,_this.statisticalDrop]);
}

@override
String toString() {
  final _this = this as TableShiftModel;
  return 'TableShiftModel(id: ${_this.id}, tableId: ${_this.tableId}, shift: ${_this.shift}, recordedBy: ${_this.recordedBy}, gamingDay: ${_this.gamingDay}, recordedAt: ${_this.recordedAt}, openingInventory: ${_this.openingInventory}, fills: ${_this.fills}, credits: ${_this.credits}, closingInventory: ${_this.closingInventory}, currencyInBox: ${_this.currencyInBox}, chequesInBox: ${_this.chequesInBox}, markersIssued: ${_this.markersIssued}, markersRedeemedInPitCash: ${_this.markersRedeemedInPitCash}, markersRedeemedInPitCheques: ${_this.markersRedeemedInPitCheques}, system: ${_this.system}, drop: ${_this.drop}, win: ${_this.win}, hold: ${_this.hold}, statisticalDrop: ${_this.statisticalDrop})';
}


}

/// @nodoc
abstract mixin class $TableShiftModelCopyWith<$Res>  {
  factory $TableShiftModelCopyWith(TableShiftModel value, $Res Function(TableShiftModel) _then) = _$TableShiftModelCopyWithImpl;
@useResult
$Res call({
 String id, String tableId, String shift, String recordedBy, DateTime gamingDay, DateTime? recordedAt, double openingInventory, double fills, double credits, double closingInventory, double currencyInBox, double chequesInBox, double markersIssued, double markersRedeemedInPitCash, double markersRedeemedInPitCheques, String system, double drop, double win, double hold, double statisticalDrop
});




}
/// @nodoc
class _$TableShiftModelCopyWithImpl<$Res>
    implements $TableShiftModelCopyWith<$Res> {
  _$TableShiftModelCopyWithImpl(this._self, this._then);

  final TableShiftModel _self;
  final $Res Function(TableShiftModel) _then;

/// Create a copy of TableShiftModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? tableId = null,Object? shift = null,Object? recordedBy = null,Object? gamingDay = null,Object? recordedAt = freezed,Object? openingInventory = null,Object? fills = null,Object? credits = null,Object? closingInventory = null,Object? currencyInBox = null,Object? chequesInBox = null,Object? markersIssued = null,Object? markersRedeemedInPitCash = null,Object? markersRedeemedInPitCheques = null,Object? system = null,Object? drop = null,Object? win = null,Object? hold = null,Object? statisticalDrop = null,}) {
  return _then(TableShiftModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tableId: null == tableId ? _self.tableId : tableId // ignore: cast_nullable_to_non_nullable
as String,shift: null == shift ? _self.shift : shift // ignore: cast_nullable_to_non_nullable
as String,recordedBy: null == recordedBy ? _self.recordedBy : recordedBy // ignore: cast_nullable_to_non_nullable
as String,gamingDay: null == gamingDay ? _self.gamingDay : gamingDay // ignore: cast_nullable_to_non_nullable
as DateTime,recordedAt: freezed == recordedAt ? _self.recordedAt : recordedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,openingInventory: null == openingInventory ? _self.openingInventory : openingInventory // ignore: cast_nullable_to_non_nullable
as double,fills: null == fills ? _self.fills : fills // ignore: cast_nullable_to_non_nullable
as double,credits: null == credits ? _self.credits : credits // ignore: cast_nullable_to_non_nullable
as double,closingInventory: null == closingInventory ? _self.closingInventory : closingInventory // ignore: cast_nullable_to_non_nullable
as double,currencyInBox: null == currencyInBox ? _self.currencyInBox : currencyInBox // ignore: cast_nullable_to_non_nullable
as double,chequesInBox: null == chequesInBox ? _self.chequesInBox : chequesInBox // ignore: cast_nullable_to_non_nullable
as double,markersIssued: null == markersIssued ? _self.markersIssued : markersIssued // ignore: cast_nullable_to_non_nullable
as double,markersRedeemedInPitCash: null == markersRedeemedInPitCash ? _self.markersRedeemedInPitCash : markersRedeemedInPitCash // ignore: cast_nullable_to_non_nullable
as double,markersRedeemedInPitCheques: null == markersRedeemedInPitCheques ? _self.markersRedeemedInPitCheques : markersRedeemedInPitCheques // ignore: cast_nullable_to_non_nullable
as double,system: null == system ? _self.system : system // ignore: cast_nullable_to_non_nullable
as String,drop: null == drop ? _self.drop : drop // ignore: cast_nullable_to_non_nullable
as double,win: null == win ? _self.win : win // ignore: cast_nullable_to_non_nullable
as double,hold: null == hold ? _self.hold : hold // ignore: cast_nullable_to_non_nullable
as double,statisticalDrop: null == statisticalDrop ? _self.statisticalDrop : statisticalDrop // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [TableShiftModel].
extension TableShiftModelPatterns on TableShiftModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TableShiftModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TableShiftModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TableShiftModel value)  $default,){
final _that = this;
switch (_that) {
case _TableShiftModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TableShiftModel value)?  $default,){
final _that = this;
switch (_that) {
case _TableShiftModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String tableId,  String shift,  String recordedBy,  DateTime gamingDay,  DateTime? recordedAt,  double openingInventory,  double fills,  double credits,  double closingInventory,  double currencyInBox,  double chequesInBox,  double markersIssued,  double markersRedeemedInPitCash,  double markersRedeemedInPitCheques,  String system,  double drop,  double win,  double hold,  double statisticalDrop)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TableShiftModel() when $default != null:
return $default(_that.id,_that.tableId,_that.shift,_that.recordedBy,_that.gamingDay,_that.recordedAt,_that.openingInventory,_that.fills,_that.credits,_that.closingInventory,_that.currencyInBox,_that.chequesInBox,_that.markersIssued,_that.markersRedeemedInPitCash,_that.markersRedeemedInPitCheques,_that.system,_that.drop,_that.win,_that.hold,_that.statisticalDrop);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String tableId,  String shift,  String recordedBy,  DateTime gamingDay,  DateTime? recordedAt,  double openingInventory,  double fills,  double credits,  double closingInventory,  double currencyInBox,  double chequesInBox,  double markersIssued,  double markersRedeemedInPitCash,  double markersRedeemedInPitCheques,  String system,  double drop,  double win,  double hold,  double statisticalDrop)  $default,) {final _that = this;
switch (_that) {
case _TableShiftModel():
return $default(_that.id,_that.tableId,_that.shift,_that.recordedBy,_that.gamingDay,_that.recordedAt,_that.openingInventory,_that.fills,_that.credits,_that.closingInventory,_that.currencyInBox,_that.chequesInBox,_that.markersIssued,_that.markersRedeemedInPitCash,_that.markersRedeemedInPitCheques,_that.system,_that.drop,_that.win,_that.hold,_that.statisticalDrop);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String tableId,  String shift,  String recordedBy,  DateTime gamingDay,  DateTime? recordedAt,  double openingInventory,  double fills,  double credits,  double closingInventory,  double currencyInBox,  double chequesInBox,  double markersIssued,  double markersRedeemedInPitCash,  double markersRedeemedInPitCheques,  String system,  double drop,  double win,  double hold,  double statisticalDrop)?  $default,) {final _that = this;
switch (_that) {
case _TableShiftModel() when $default != null:
return $default(_that.id,_that.tableId,_that.shift,_that.recordedBy,_that.gamingDay,_that.recordedAt,_that.openingInventory,_that.fills,_that.credits,_that.closingInventory,_that.currencyInBox,_that.chequesInBox,_that.markersIssued,_that.markersRedeemedInPitCash,_that.markersRedeemedInPitCheques,_that.system,_that.drop,_that.win,_that.hold,_that.statisticalDrop);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TableShiftModel extends TableShiftModel {
  const _TableShiftModel({required this.id, this.tableId = '', this.shift = '', this.recordedBy = '', required this.gamingDay, this.recordedAt, this.openingInventory = 0, this.fills = 0, this.credits = 0, this.closingInventory = 0, this.currencyInBox = 0, this.chequesInBox = 0, this.markersIssued = 0, this.markersRedeemedInPitCash = 0, this.markersRedeemedInPitCheques = 0, this.system = 'marker', this.drop = 0, this.win = 0, this.hold = 0, this.statisticalDrop = 0}): super._();
  factory _TableShiftModel.fromJson(Map<String, dynamic> json) => _$TableShiftModelFromJson(json);

@override final  String id;
@override@JsonKey() final  String tableId;
@override@JsonKey() final  String shift;
@override@JsonKey() final  String recordedBy;
@override final  DateTime gamingDay;
@override final  DateTime? recordedAt;
@override@JsonKey() final  double openingInventory;
@override@JsonKey() final  double fills;
@override@JsonKey() final  double credits;
@override@JsonKey() final  double closingInventory;
@override@JsonKey() final  double currencyInBox;
@override@JsonKey() final  double chequesInBox;
@override@JsonKey() final  double markersIssued;
@override@JsonKey() final  double markersRedeemedInPitCash;
@override@JsonKey() final  double markersRedeemedInPitCheques;
@override@JsonKey() final  String system;
@override@JsonKey() final  double drop;
@override@JsonKey() final  double win;
@override@JsonKey() final  double hold;
@override@JsonKey() final  double statisticalDrop;

/// Create a copy of TableShiftModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TableShiftModelCopyWith<_TableShiftModel> get copyWith => __$TableShiftModelCopyWithImpl<_TableShiftModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TableShiftModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TableShiftModel&&(identical(other.id, id) || other.id == id)&&(identical(other.tableId, tableId) || other.tableId == tableId)&&(identical(other.shift, shift) || other.shift == shift)&&(identical(other.recordedBy, recordedBy) || other.recordedBy == recordedBy)&&(identical(other.gamingDay, gamingDay) || other.gamingDay == gamingDay)&&(identical(other.recordedAt, recordedAt) || other.recordedAt == recordedAt)&&(identical(other.openingInventory, openingInventory) || other.openingInventory == openingInventory)&&(identical(other.fills, fills) || other.fills == fills)&&(identical(other.credits, credits) || other.credits == credits)&&(identical(other.closingInventory, closingInventory) || other.closingInventory == closingInventory)&&(identical(other.currencyInBox, currencyInBox) || other.currencyInBox == currencyInBox)&&(identical(other.chequesInBox, chequesInBox) || other.chequesInBox == chequesInBox)&&(identical(other.markersIssued, markersIssued) || other.markersIssued == markersIssued)&&(identical(other.markersRedeemedInPitCash, markersRedeemedInPitCash) || other.markersRedeemedInPitCash == markersRedeemedInPitCash)&&(identical(other.markersRedeemedInPitCheques, markersRedeemedInPitCheques) || other.markersRedeemedInPitCheques == markersRedeemedInPitCheques)&&(identical(other.system, system) || other.system == system)&&(identical(other.drop, drop) || other.drop == drop)&&(identical(other.win, win) || other.win == win)&&(identical(other.hold, hold) || other.hold == hold)&&(identical(other.statisticalDrop, statisticalDrop) || other.statisticalDrop == statisticalDrop));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hashAll([runtimeType,id,tableId,shift,recordedBy,gamingDay,recordedAt,openingInventory,fills,credits,closingInventory,currencyInBox,chequesInBox,markersIssued,markersRedeemedInPitCash,markersRedeemedInPitCheques,system,drop,win,hold,statisticalDrop]);
}

@override
String toString() {
    return 'TableShiftModel(id: $id, tableId: $tableId, shift: $shift, recordedBy: $recordedBy, gamingDay: $gamingDay, recordedAt: $recordedAt, openingInventory: $openingInventory, fills: $fills, credits: $credits, closingInventory: $closingInventory, currencyInBox: $currencyInBox, chequesInBox: $chequesInBox, markersIssued: $markersIssued, markersRedeemedInPitCash: $markersRedeemedInPitCash, markersRedeemedInPitCheques: $markersRedeemedInPitCheques, system: $system, drop: $drop, win: $win, hold: $hold, statisticalDrop: $statisticalDrop)';
}


}

/// @nodoc
abstract mixin class _$TableShiftModelCopyWith<$Res> implements $TableShiftModelCopyWith<$Res> {
  factory _$TableShiftModelCopyWith(_TableShiftModel value, $Res Function(_TableShiftModel) _then) = __$TableShiftModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String tableId, String shift, String recordedBy, DateTime gamingDay, DateTime? recordedAt, double openingInventory, double fills, double credits, double closingInventory, double currencyInBox, double chequesInBox, double markersIssued, double markersRedeemedInPitCash, double markersRedeemedInPitCheques, String system, double drop, double win, double hold, double statisticalDrop
});




}
/// @nodoc
class __$TableShiftModelCopyWithImpl<$Res>
    implements _$TableShiftModelCopyWith<$Res> {
  __$TableShiftModelCopyWithImpl(this._self, this._then);

  final _TableShiftModel _self;
  final $Res Function(_TableShiftModel) _then;

/// Create a copy of TableShiftModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? tableId = null,Object? shift = null,Object? recordedBy = null,Object? gamingDay = null,Object? recordedAt = freezed,Object? openingInventory = null,Object? fills = null,Object? credits = null,Object? closingInventory = null,Object? currencyInBox = null,Object? chequesInBox = null,Object? markersIssued = null,Object? markersRedeemedInPitCash = null,Object? markersRedeemedInPitCheques = null,Object? system = null,Object? drop = null,Object? win = null,Object? hold = null,Object? statisticalDrop = null,}) {
  return _then(_TableShiftModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tableId: null == tableId ? _self.tableId : tableId // ignore: cast_nullable_to_non_nullable
as String,shift: null == shift ? _self.shift : shift // ignore: cast_nullable_to_non_nullable
as String,recordedBy: null == recordedBy ? _self.recordedBy : recordedBy // ignore: cast_nullable_to_non_nullable
as String,gamingDay: null == gamingDay ? _self.gamingDay : gamingDay // ignore: cast_nullable_to_non_nullable
as DateTime,recordedAt: freezed == recordedAt ? _self.recordedAt : recordedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,openingInventory: null == openingInventory ? _self.openingInventory : openingInventory // ignore: cast_nullable_to_non_nullable
as double,fills: null == fills ? _self.fills : fills // ignore: cast_nullable_to_non_nullable
as double,credits: null == credits ? _self.credits : credits // ignore: cast_nullable_to_non_nullable
as double,closingInventory: null == closingInventory ? _self.closingInventory : closingInventory // ignore: cast_nullable_to_non_nullable
as double,currencyInBox: null == currencyInBox ? _self.currencyInBox : currencyInBox // ignore: cast_nullable_to_non_nullable
as double,chequesInBox: null == chequesInBox ? _self.chequesInBox : chequesInBox // ignore: cast_nullable_to_non_nullable
as double,markersIssued: null == markersIssued ? _self.markersIssued : markersIssued // ignore: cast_nullable_to_non_nullable
as double,markersRedeemedInPitCash: null == markersRedeemedInPitCash ? _self.markersRedeemedInPitCash : markersRedeemedInPitCash // ignore: cast_nullable_to_non_nullable
as double,markersRedeemedInPitCheques: null == markersRedeemedInPitCheques ? _self.markersRedeemedInPitCheques : markersRedeemedInPitCheques // ignore: cast_nullable_to_non_nullable
as double,system: null == system ? _self.system : system // ignore: cast_nullable_to_non_nullable
as String,drop: null == drop ? _self.drop : drop // ignore: cast_nullable_to_non_nullable
as double,win: null == win ? _self.win : win // ignore: cast_nullable_to_non_nullable
as double,hold: null == hold ? _self.hold : hold // ignore: cast_nullable_to_non_nullable
as double,statisticalDrop: null == statisticalDrop ? _self.statisticalDrop : statisticalDrop // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$HitRecordModel {

 String get id; String get tableId; String get playerLabel; DateTime get gamingDay; double get playerDrop; double get casinoResult; String get note; String get recordedBy;
/// Create a copy of HitRecordModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HitRecordModelCopyWith<HitRecordModel> get copyWith => _$HitRecordModelCopyWithImpl<HitRecordModel>(this as HitRecordModel, _$identity);

  /// Serializes this HitRecordModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as HitRecordModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HitRecordModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.tableId, _this.tableId) || other.tableId == _this.tableId)&&(identical(other.playerLabel, _this.playerLabel) || other.playerLabel == _this.playerLabel)&&(identical(other.gamingDay, _this.gamingDay) || other.gamingDay == _this.gamingDay)&&(identical(other.playerDrop, _this.playerDrop) || other.playerDrop == _this.playerDrop)&&(identical(other.casinoResult, _this.casinoResult) || other.casinoResult == _this.casinoResult)&&(identical(other.note, _this.note) || other.note == _this.note)&&(identical(other.recordedBy, _this.recordedBy) || other.recordedBy == _this.recordedBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as HitRecordModel;
  return Object.hash(runtimeType,_this.id,_this.tableId,_this.playerLabel,_this.gamingDay,_this.playerDrop,_this.casinoResult,_this.note,_this.recordedBy);
}

@override
String toString() {
  final _this = this as HitRecordModel;
  return 'HitRecordModel(id: ${_this.id}, tableId: ${_this.tableId}, playerLabel: ${_this.playerLabel}, gamingDay: ${_this.gamingDay}, playerDrop: ${_this.playerDrop}, casinoResult: ${_this.casinoResult}, note: ${_this.note}, recordedBy: ${_this.recordedBy})';
}


}

/// @nodoc
abstract mixin class $HitRecordModelCopyWith<$Res>  {
  factory $HitRecordModelCopyWith(HitRecordModel value, $Res Function(HitRecordModel) _then) = _$HitRecordModelCopyWithImpl;
@useResult
$Res call({
 String id, String tableId, String playerLabel, DateTime gamingDay, double playerDrop, double casinoResult, String note, String recordedBy
});




}
/// @nodoc
class _$HitRecordModelCopyWithImpl<$Res>
    implements $HitRecordModelCopyWith<$Res> {
  _$HitRecordModelCopyWithImpl(this._self, this._then);

  final HitRecordModel _self;
  final $Res Function(HitRecordModel) _then;

/// Create a copy of HitRecordModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? tableId = null,Object? playerLabel = null,Object? gamingDay = null,Object? playerDrop = null,Object? casinoResult = null,Object? note = null,Object? recordedBy = null,}) {
  return _then(HitRecordModel(
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


/// Adds pattern-matching-related methods to [HitRecordModel].
extension HitRecordModelPatterns on HitRecordModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HitRecordModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HitRecordModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HitRecordModel value)  $default,){
final _that = this;
switch (_that) {
case _HitRecordModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HitRecordModel value)?  $default,){
final _that = this;
switch (_that) {
case _HitRecordModel() when $default != null:
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
case _HitRecordModel() when $default != null:
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
case _HitRecordModel():
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
case _HitRecordModel() when $default != null:
return $default(_that.id,_that.tableId,_that.playerLabel,_that.gamingDay,_that.playerDrop,_that.casinoResult,_that.note,_that.recordedBy);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HitRecordModel extends HitRecordModel {
  const _HitRecordModel({required this.id, this.tableId = '', this.playerLabel = '', required this.gamingDay, this.playerDrop = 0, this.casinoResult = 0, this.note = '', this.recordedBy = ''}): super._();
  factory _HitRecordModel.fromJson(Map<String, dynamic> json) => _$HitRecordModelFromJson(json);

@override final  String id;
@override@JsonKey() final  String tableId;
@override@JsonKey() final  String playerLabel;
@override final  DateTime gamingDay;
@override@JsonKey() final  double playerDrop;
@override@JsonKey() final  double casinoResult;
@override@JsonKey() final  String note;
@override@JsonKey() final  String recordedBy;

/// Create a copy of HitRecordModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HitRecordModelCopyWith<_HitRecordModel> get copyWith => __$HitRecordModelCopyWithImpl<_HitRecordModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HitRecordModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _HitRecordModel&&(identical(other.id, id) || other.id == id)&&(identical(other.tableId, tableId) || other.tableId == tableId)&&(identical(other.playerLabel, playerLabel) || other.playerLabel == playerLabel)&&(identical(other.gamingDay, gamingDay) || other.gamingDay == gamingDay)&&(identical(other.playerDrop, playerDrop) || other.playerDrop == playerDrop)&&(identical(other.casinoResult, casinoResult) || other.casinoResult == casinoResult)&&(identical(other.note, note) || other.note == note)&&(identical(other.recordedBy, recordedBy) || other.recordedBy == recordedBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,tableId,playerLabel,gamingDay,playerDrop,casinoResult,note,recordedBy);
}

@override
String toString() {
    return 'HitRecordModel(id: $id, tableId: $tableId, playerLabel: $playerLabel, gamingDay: $gamingDay, playerDrop: $playerDrop, casinoResult: $casinoResult, note: $note, recordedBy: $recordedBy)';
}


}

/// @nodoc
abstract mixin class _$HitRecordModelCopyWith<$Res> implements $HitRecordModelCopyWith<$Res> {
  factory _$HitRecordModelCopyWith(_HitRecordModel value, $Res Function(_HitRecordModel) _then) = __$HitRecordModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String tableId, String playerLabel, DateTime gamingDay, double playerDrop, double casinoResult, String note, String recordedBy
});




}
/// @nodoc
class __$HitRecordModelCopyWithImpl<$Res>
    implements _$HitRecordModelCopyWith<$Res> {
  __$HitRecordModelCopyWithImpl(this._self, this._then);

  final _HitRecordModel _self;
  final $Res Function(_HitRecordModel) _then;

/// Create a copy of HitRecordModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? tableId = null,Object? playerLabel = null,Object? gamingDay = null,Object? playerDrop = null,Object? casinoResult = null,Object? note = null,Object? recordedBy = null,}) {
  return _then(_HitRecordModel(
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
