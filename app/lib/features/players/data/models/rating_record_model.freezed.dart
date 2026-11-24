// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rating_record_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RatingRecordModel {

 String get id; String get playerId; String get gameId; String get gameName; String get table; String get ratedBy; double get averageBet; double get minutes; double get decisionsPerHour; double get effectiveAdvantage; double get theo; double get actualCasinoWin; double get sd; int get players; String get type; DateTime get at;
/// Create a copy of RatingRecordModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RatingRecordModelCopyWith<RatingRecordModel> get copyWith => _$RatingRecordModelCopyWithImpl<RatingRecordModel>(this as RatingRecordModel, _$identity);

  /// Serializes this RatingRecordModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as RatingRecordModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RatingRecordModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.playerId, _this.playerId) || other.playerId == _this.playerId)&&(identical(other.gameId, _this.gameId) || other.gameId == _this.gameId)&&(identical(other.gameName, _this.gameName) || other.gameName == _this.gameName)&&(identical(other.table, _this.table) || other.table == _this.table)&&(identical(other.ratedBy, _this.ratedBy) || other.ratedBy == _this.ratedBy)&&(identical(other.averageBet, _this.averageBet) || other.averageBet == _this.averageBet)&&(identical(other.minutes, _this.minutes) || other.minutes == _this.minutes)&&(identical(other.decisionsPerHour, _this.decisionsPerHour) || other.decisionsPerHour == _this.decisionsPerHour)&&(identical(other.effectiveAdvantage, _this.effectiveAdvantage) || other.effectiveAdvantage == _this.effectiveAdvantage)&&(identical(other.theo, _this.theo) || other.theo == _this.theo)&&(identical(other.actualCasinoWin, _this.actualCasinoWin) || other.actualCasinoWin == _this.actualCasinoWin)&&(identical(other.sd, _this.sd) || other.sd == _this.sd)&&(identical(other.players, _this.players) || other.players == _this.players)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.at, _this.at) || other.at == _this.at));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as RatingRecordModel;
  return Object.hash(runtimeType,_this.id,_this.playerId,_this.gameId,_this.gameName,_this.table,_this.ratedBy,_this.averageBet,_this.minutes,_this.decisionsPerHour,_this.effectiveAdvantage,_this.theo,_this.actualCasinoWin,_this.sd,_this.players,_this.type,_this.at);
}

@override
String toString() {
  final _this = this as RatingRecordModel;
  return 'RatingRecordModel(id: ${_this.id}, playerId: ${_this.playerId}, gameId: ${_this.gameId}, gameName: ${_this.gameName}, table: ${_this.table}, ratedBy: ${_this.ratedBy}, averageBet: ${_this.averageBet}, minutes: ${_this.minutes}, decisionsPerHour: ${_this.decisionsPerHour}, effectiveAdvantage: ${_this.effectiveAdvantage}, theo: ${_this.theo}, actualCasinoWin: ${_this.actualCasinoWin}, sd: ${_this.sd}, players: ${_this.players}, type: ${_this.type}, at: ${_this.at})';
}


}

/// @nodoc
abstract mixin class $RatingRecordModelCopyWith<$Res>  {
  factory $RatingRecordModelCopyWith(RatingRecordModel value, $Res Function(RatingRecordModel) _then) = _$RatingRecordModelCopyWithImpl;
@useResult
$Res call({
 String id, String playerId, String gameId, String gameName, String table, String ratedBy, double averageBet, double minutes, double decisionsPerHour, double effectiveAdvantage, double theo, double actualCasinoWin, double sd, int players, String type, DateTime at
});




}
/// @nodoc
class _$RatingRecordModelCopyWithImpl<$Res>
    implements $RatingRecordModelCopyWith<$Res> {
  _$RatingRecordModelCopyWithImpl(this._self, this._then);

  final RatingRecordModel _self;
  final $Res Function(RatingRecordModel) _then;

/// Create a copy of RatingRecordModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? playerId = null,Object? gameId = null,Object? gameName = null,Object? table = null,Object? ratedBy = null,Object? averageBet = null,Object? minutes = null,Object? decisionsPerHour = null,Object? effectiveAdvantage = null,Object? theo = null,Object? actualCasinoWin = null,Object? sd = null,Object? players = null,Object? type = null,Object? at = null,}) {
  return _then(RatingRecordModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,gameId: null == gameId ? _self.gameId : gameId // ignore: cast_nullable_to_non_nullable
as String,gameName: null == gameName ? _self.gameName : gameName // ignore: cast_nullable_to_non_nullable
as String,table: null == table ? _self.table : table // ignore: cast_nullable_to_non_nullable
as String,ratedBy: null == ratedBy ? _self.ratedBy : ratedBy // ignore: cast_nullable_to_non_nullable
as String,averageBet: null == averageBet ? _self.averageBet : averageBet // ignore: cast_nullable_to_non_nullable
as double,minutes: null == minutes ? _self.minutes : minutes // ignore: cast_nullable_to_non_nullable
as double,decisionsPerHour: null == decisionsPerHour ? _self.decisionsPerHour : decisionsPerHour // ignore: cast_nullable_to_non_nullable
as double,effectiveAdvantage: null == effectiveAdvantage ? _self.effectiveAdvantage : effectiveAdvantage // ignore: cast_nullable_to_non_nullable
as double,theo: null == theo ? _self.theo : theo // ignore: cast_nullable_to_non_nullable
as double,actualCasinoWin: null == actualCasinoWin ? _self.actualCasinoWin : actualCasinoWin // ignore: cast_nullable_to_non_nullable
as double,sd: null == sd ? _self.sd : sd // ignore: cast_nullable_to_non_nullable
as double,players: null == players ? _self.players : players // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,at: null == at ? _self.at : at // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [RatingRecordModel].
extension RatingRecordModelPatterns on RatingRecordModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RatingRecordModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RatingRecordModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RatingRecordModel value)  $default,){
final _that = this;
switch (_that) {
case _RatingRecordModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RatingRecordModel value)?  $default,){
final _that = this;
switch (_that) {
case _RatingRecordModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String playerId,  String gameId,  String gameName,  String table,  String ratedBy,  double averageBet,  double minutes,  double decisionsPerHour,  double effectiveAdvantage,  double theo,  double actualCasinoWin,  double sd,  int players,  String type,  DateTime at)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RatingRecordModel() when $default != null:
return $default(_that.id,_that.playerId,_that.gameId,_that.gameName,_that.table,_that.ratedBy,_that.averageBet,_that.minutes,_that.decisionsPerHour,_that.effectiveAdvantage,_that.theo,_that.actualCasinoWin,_that.sd,_that.players,_that.type,_that.at);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String playerId,  String gameId,  String gameName,  String table,  String ratedBy,  double averageBet,  double minutes,  double decisionsPerHour,  double effectiveAdvantage,  double theo,  double actualCasinoWin,  double sd,  int players,  String type,  DateTime at)  $default,) {final _that = this;
switch (_that) {
case _RatingRecordModel():
return $default(_that.id,_that.playerId,_that.gameId,_that.gameName,_that.table,_that.ratedBy,_that.averageBet,_that.minutes,_that.decisionsPerHour,_that.effectiveAdvantage,_that.theo,_that.actualCasinoWin,_that.sd,_that.players,_that.type,_that.at);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String playerId,  String gameId,  String gameName,  String table,  String ratedBy,  double averageBet,  double minutes,  double decisionsPerHour,  double effectiveAdvantage,  double theo,  double actualCasinoWin,  double sd,  int players,  String type,  DateTime at)?  $default,) {final _that = this;
switch (_that) {
case _RatingRecordModel() when $default != null:
return $default(_that.id,_that.playerId,_that.gameId,_that.gameName,_that.table,_that.ratedBy,_that.averageBet,_that.minutes,_that.decisionsPerHour,_that.effectiveAdvantage,_that.theo,_that.actualCasinoWin,_that.sd,_that.players,_that.type,_that.at);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RatingRecordModel extends RatingRecordModel {
  const _RatingRecordModel({required this.id, this.playerId = '', this.gameId = '', this.gameName = '', this.table = '', this.ratedBy = '', this.averageBet = 0, this.minutes = 0, this.decisionsPerHour = 0, this.effectiveAdvantage = 0, this.theo = 0, this.actualCasinoWin = 0, this.sd = 0, this.players = 1, this.type = 'average', required this.at}): super._();
  factory _RatingRecordModel.fromJson(Map<String, dynamic> json) => _$RatingRecordModelFromJson(json);

@override final  String id;
@override@JsonKey() final  String playerId;
@override@JsonKey() final  String gameId;
@override@JsonKey() final  String gameName;
@override@JsonKey() final  String table;
@override@JsonKey() final  String ratedBy;
@override@JsonKey() final  double averageBet;
@override@JsonKey() final  double minutes;
@override@JsonKey() final  double decisionsPerHour;
@override@JsonKey() final  double effectiveAdvantage;
@override@JsonKey() final  double theo;
@override@JsonKey() final  double actualCasinoWin;
@override@JsonKey() final  double sd;
@override@JsonKey() final  int players;
@override@JsonKey() final  String type;
@override final  DateTime at;

/// Create a copy of RatingRecordModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RatingRecordModelCopyWith<_RatingRecordModel> get copyWith => __$RatingRecordModelCopyWithImpl<_RatingRecordModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RatingRecordModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RatingRecordModel&&(identical(other.id, id) || other.id == id)&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.gameId, gameId) || other.gameId == gameId)&&(identical(other.gameName, gameName) || other.gameName == gameName)&&(identical(other.table, table) || other.table == table)&&(identical(other.ratedBy, ratedBy) || other.ratedBy == ratedBy)&&(identical(other.averageBet, averageBet) || other.averageBet == averageBet)&&(identical(other.minutes, minutes) || other.minutes == minutes)&&(identical(other.decisionsPerHour, decisionsPerHour) || other.decisionsPerHour == decisionsPerHour)&&(identical(other.effectiveAdvantage, effectiveAdvantage) || other.effectiveAdvantage == effectiveAdvantage)&&(identical(other.theo, theo) || other.theo == theo)&&(identical(other.actualCasinoWin, actualCasinoWin) || other.actualCasinoWin == actualCasinoWin)&&(identical(other.sd, sd) || other.sd == sd)&&(identical(other.players, players) || other.players == players)&&(identical(other.type, type) || other.type == type)&&(identical(other.at, at) || other.at == at));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,playerId,gameId,gameName,table,ratedBy,averageBet,minutes,decisionsPerHour,effectiveAdvantage,theo,actualCasinoWin,sd,players,type,at);
}

@override
String toString() {
    return 'RatingRecordModel(id: $id, playerId: $playerId, gameId: $gameId, gameName: $gameName, table: $table, ratedBy: $ratedBy, averageBet: $averageBet, minutes: $minutes, decisionsPerHour: $decisionsPerHour, effectiveAdvantage: $effectiveAdvantage, theo: $theo, actualCasinoWin: $actualCasinoWin, sd: $sd, players: $players, type: $type, at: $at)';
}


}

/// @nodoc
abstract mixin class _$RatingRecordModelCopyWith<$Res> implements $RatingRecordModelCopyWith<$Res> {
  factory _$RatingRecordModelCopyWith(_RatingRecordModel value, $Res Function(_RatingRecordModel) _then) = __$RatingRecordModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String playerId, String gameId, String gameName, String table, String ratedBy, double averageBet, double minutes, double decisionsPerHour, double effectiveAdvantage, double theo, double actualCasinoWin, double sd, int players, String type, DateTime at
});




}
/// @nodoc
class __$RatingRecordModelCopyWithImpl<$Res>
    implements _$RatingRecordModelCopyWith<$Res> {
  __$RatingRecordModelCopyWithImpl(this._self, this._then);

  final _RatingRecordModel _self;
  final $Res Function(_RatingRecordModel) _then;

/// Create a copy of RatingRecordModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? playerId = null,Object? gameId = null,Object? gameName = null,Object? table = null,Object? ratedBy = null,Object? averageBet = null,Object? minutes = null,Object? decisionsPerHour = null,Object? effectiveAdvantage = null,Object? theo = null,Object? actualCasinoWin = null,Object? sd = null,Object? players = null,Object? type = null,Object? at = null,}) {
  return _then(_RatingRecordModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,gameId: null == gameId ? _self.gameId : gameId // ignore: cast_nullable_to_non_nullable
as String,gameName: null == gameName ? _self.gameName : gameName // ignore: cast_nullable_to_non_nullable
as String,table: null == table ? _self.table : table // ignore: cast_nullable_to_non_nullable
as String,ratedBy: null == ratedBy ? _self.ratedBy : ratedBy // ignore: cast_nullable_to_non_nullable
as String,averageBet: null == averageBet ? _self.averageBet : averageBet // ignore: cast_nullable_to_non_nullable
as double,minutes: null == minutes ? _self.minutes : minutes // ignore: cast_nullable_to_non_nullable
as double,decisionsPerHour: null == decisionsPerHour ? _self.decisionsPerHour : decisionsPerHour // ignore: cast_nullable_to_non_nullable
as double,effectiveAdvantage: null == effectiveAdvantage ? _self.effectiveAdvantage : effectiveAdvantage // ignore: cast_nullable_to_non_nullable
as double,theo: null == theo ? _self.theo : theo // ignore: cast_nullable_to_non_nullable
as double,actualCasinoWin: null == actualCasinoWin ? _self.actualCasinoWin : actualCasinoWin // ignore: cast_nullable_to_non_nullable
as double,sd: null == sd ? _self.sd : sd // ignore: cast_nullable_to_non_nullable
as double,players: null == players ? _self.players : players // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,at: null == at ? _self.at : at // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
