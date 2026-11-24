// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AmlProfileModel {

 String get regime; double get ctrThreshold; double get mtlThreshold; double get cashForCashLimit; double get casinoCheckForCashLimit; double get sarThreshold; int get sarFileDays; int get sarExtensionDays; int get gamingDayStartHour; double get nearThresholdPct;
/// Create a copy of AmlProfileModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AmlProfileModelCopyWith<AmlProfileModel> get copyWith => _$AmlProfileModelCopyWithImpl<AmlProfileModel>(this as AmlProfileModel, _$identity);

  /// Serializes this AmlProfileModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AmlProfileModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AmlProfileModel&&(identical(other.regime, _this.regime) || other.regime == _this.regime)&&(identical(other.ctrThreshold, _this.ctrThreshold) || other.ctrThreshold == _this.ctrThreshold)&&(identical(other.mtlThreshold, _this.mtlThreshold) || other.mtlThreshold == _this.mtlThreshold)&&(identical(other.cashForCashLimit, _this.cashForCashLimit) || other.cashForCashLimit == _this.cashForCashLimit)&&(identical(other.casinoCheckForCashLimit, _this.casinoCheckForCashLimit) || other.casinoCheckForCashLimit == _this.casinoCheckForCashLimit)&&(identical(other.sarThreshold, _this.sarThreshold) || other.sarThreshold == _this.sarThreshold)&&(identical(other.sarFileDays, _this.sarFileDays) || other.sarFileDays == _this.sarFileDays)&&(identical(other.sarExtensionDays, _this.sarExtensionDays) || other.sarExtensionDays == _this.sarExtensionDays)&&(identical(other.gamingDayStartHour, _this.gamingDayStartHour) || other.gamingDayStartHour == _this.gamingDayStartHour)&&(identical(other.nearThresholdPct, _this.nearThresholdPct) || other.nearThresholdPct == _this.nearThresholdPct));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AmlProfileModel;
  return Object.hash(runtimeType,_this.regime,_this.ctrThreshold,_this.mtlThreshold,_this.cashForCashLimit,_this.casinoCheckForCashLimit,_this.sarThreshold,_this.sarFileDays,_this.sarExtensionDays,_this.gamingDayStartHour,_this.nearThresholdPct);
}

@override
String toString() {
  final _this = this as AmlProfileModel;
  return 'AmlProfileModel(regime: ${_this.regime}, ctrThreshold: ${_this.ctrThreshold}, mtlThreshold: ${_this.mtlThreshold}, cashForCashLimit: ${_this.cashForCashLimit}, casinoCheckForCashLimit: ${_this.casinoCheckForCashLimit}, sarThreshold: ${_this.sarThreshold}, sarFileDays: ${_this.sarFileDays}, sarExtensionDays: ${_this.sarExtensionDays}, gamingDayStartHour: ${_this.gamingDayStartHour}, nearThresholdPct: ${_this.nearThresholdPct})';
}


}

/// @nodoc
abstract mixin class $AmlProfileModelCopyWith<$Res>  {
  factory $AmlProfileModelCopyWith(AmlProfileModel value, $Res Function(AmlProfileModel) _then) = _$AmlProfileModelCopyWithImpl;
@useResult
$Res call({
 String regime, double ctrThreshold, double mtlThreshold, double cashForCashLimit, double casinoCheckForCashLimit, double sarThreshold, int sarFileDays, int sarExtensionDays, int gamingDayStartHour, double nearThresholdPct
});




}
/// @nodoc
class _$AmlProfileModelCopyWithImpl<$Res>
    implements $AmlProfileModelCopyWith<$Res> {
  _$AmlProfileModelCopyWithImpl(this._self, this._then);

  final AmlProfileModel _self;
  final $Res Function(AmlProfileModel) _then;

/// Create a copy of AmlProfileModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? regime = null,Object? ctrThreshold = null,Object? mtlThreshold = null,Object? cashForCashLimit = null,Object? casinoCheckForCashLimit = null,Object? sarThreshold = null,Object? sarFileDays = null,Object? sarExtensionDays = null,Object? gamingDayStartHour = null,Object? nearThresholdPct = null,}) {
  return _then(AmlProfileModel(
regime: null == regime ? _self.regime : regime // ignore: cast_nullable_to_non_nullable
as String,ctrThreshold: null == ctrThreshold ? _self.ctrThreshold : ctrThreshold // ignore: cast_nullable_to_non_nullable
as double,mtlThreshold: null == mtlThreshold ? _self.mtlThreshold : mtlThreshold // ignore: cast_nullable_to_non_nullable
as double,cashForCashLimit: null == cashForCashLimit ? _self.cashForCashLimit : cashForCashLimit // ignore: cast_nullable_to_non_nullable
as double,casinoCheckForCashLimit: null == casinoCheckForCashLimit ? _self.casinoCheckForCashLimit : casinoCheckForCashLimit // ignore: cast_nullable_to_non_nullable
as double,sarThreshold: null == sarThreshold ? _self.sarThreshold : sarThreshold // ignore: cast_nullable_to_non_nullable
as double,sarFileDays: null == sarFileDays ? _self.sarFileDays : sarFileDays // ignore: cast_nullable_to_non_nullable
as int,sarExtensionDays: null == sarExtensionDays ? _self.sarExtensionDays : sarExtensionDays // ignore: cast_nullable_to_non_nullable
as int,gamingDayStartHour: null == gamingDayStartHour ? _self.gamingDayStartHour : gamingDayStartHour // ignore: cast_nullable_to_non_nullable
as int,nearThresholdPct: null == nearThresholdPct ? _self.nearThresholdPct : nearThresholdPct // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [AmlProfileModel].
extension AmlProfileModelPatterns on AmlProfileModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AmlProfileModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AmlProfileModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AmlProfileModel value)  $default,){
final _that = this;
switch (_that) {
case _AmlProfileModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AmlProfileModel value)?  $default,){
final _that = this;
switch (_that) {
case _AmlProfileModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String regime,  double ctrThreshold,  double mtlThreshold,  double cashForCashLimit,  double casinoCheckForCashLimit,  double sarThreshold,  int sarFileDays,  int sarExtensionDays,  int gamingDayStartHour,  double nearThresholdPct)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AmlProfileModel() when $default != null:
return $default(_that.regime,_that.ctrThreshold,_that.mtlThreshold,_that.cashForCashLimit,_that.casinoCheckForCashLimit,_that.sarThreshold,_that.sarFileDays,_that.sarExtensionDays,_that.gamingDayStartHour,_that.nearThresholdPct);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String regime,  double ctrThreshold,  double mtlThreshold,  double cashForCashLimit,  double casinoCheckForCashLimit,  double sarThreshold,  int sarFileDays,  int sarExtensionDays,  int gamingDayStartHour,  double nearThresholdPct)  $default,) {final _that = this;
switch (_that) {
case _AmlProfileModel():
return $default(_that.regime,_that.ctrThreshold,_that.mtlThreshold,_that.cashForCashLimit,_that.casinoCheckForCashLimit,_that.sarThreshold,_that.sarFileDays,_that.sarExtensionDays,_that.gamingDayStartHour,_that.nearThresholdPct);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String regime,  double ctrThreshold,  double mtlThreshold,  double cashForCashLimit,  double casinoCheckForCashLimit,  double sarThreshold,  int sarFileDays,  int sarExtensionDays,  int gamingDayStartHour,  double nearThresholdPct)?  $default,) {final _that = this;
switch (_that) {
case _AmlProfileModel() when $default != null:
return $default(_that.regime,_that.ctrThreshold,_that.mtlThreshold,_that.cashForCashLimit,_that.casinoCheckForCashLimit,_that.sarThreshold,_that.sarFileDays,_that.sarExtensionDays,_that.gamingDayStartHour,_that.nearThresholdPct);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AmlProfileModel extends AmlProfileModel {
  const _AmlProfileModel({this.regime = 'reg6a', this.ctrThreshold = 10000, this.mtlThreshold = 3000, this.cashForCashLimit = 3000, this.casinoCheckForCashLimit = 3000, this.sarThreshold = 5000, this.sarFileDays = 30, this.sarExtensionDays = 30, this.gamingDayStartHour = 6, this.nearThresholdPct = 0.8}): super._();
  factory _AmlProfileModel.fromJson(Map<String, dynamic> json) => _$AmlProfileModelFromJson(json);

@override@JsonKey() final  String regime;
@override@JsonKey() final  double ctrThreshold;
@override@JsonKey() final  double mtlThreshold;
@override@JsonKey() final  double cashForCashLimit;
@override@JsonKey() final  double casinoCheckForCashLimit;
@override@JsonKey() final  double sarThreshold;
@override@JsonKey() final  int sarFileDays;
@override@JsonKey() final  int sarExtensionDays;
@override@JsonKey() final  int gamingDayStartHour;
@override@JsonKey() final  double nearThresholdPct;

/// Create a copy of AmlProfileModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AmlProfileModelCopyWith<_AmlProfileModel> get copyWith => __$AmlProfileModelCopyWithImpl<_AmlProfileModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AmlProfileModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AmlProfileModel&&(identical(other.regime, regime) || other.regime == regime)&&(identical(other.ctrThreshold, ctrThreshold) || other.ctrThreshold == ctrThreshold)&&(identical(other.mtlThreshold, mtlThreshold) || other.mtlThreshold == mtlThreshold)&&(identical(other.cashForCashLimit, cashForCashLimit) || other.cashForCashLimit == cashForCashLimit)&&(identical(other.casinoCheckForCashLimit, casinoCheckForCashLimit) || other.casinoCheckForCashLimit == casinoCheckForCashLimit)&&(identical(other.sarThreshold, sarThreshold) || other.sarThreshold == sarThreshold)&&(identical(other.sarFileDays, sarFileDays) || other.sarFileDays == sarFileDays)&&(identical(other.sarExtensionDays, sarExtensionDays) || other.sarExtensionDays == sarExtensionDays)&&(identical(other.gamingDayStartHour, gamingDayStartHour) || other.gamingDayStartHour == gamingDayStartHour)&&(identical(other.nearThresholdPct, nearThresholdPct) || other.nearThresholdPct == nearThresholdPct));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,regime,ctrThreshold,mtlThreshold,cashForCashLimit,casinoCheckForCashLimit,sarThreshold,sarFileDays,sarExtensionDays,gamingDayStartHour,nearThresholdPct);
}

@override
String toString() {
    return 'AmlProfileModel(regime: $regime, ctrThreshold: $ctrThreshold, mtlThreshold: $mtlThreshold, cashForCashLimit: $cashForCashLimit, casinoCheckForCashLimit: $casinoCheckForCashLimit, sarThreshold: $sarThreshold, sarFileDays: $sarFileDays, sarExtensionDays: $sarExtensionDays, gamingDayStartHour: $gamingDayStartHour, nearThresholdPct: $nearThresholdPct)';
}


}

/// @nodoc
abstract mixin class _$AmlProfileModelCopyWith<$Res> implements $AmlProfileModelCopyWith<$Res> {
  factory _$AmlProfileModelCopyWith(_AmlProfileModel value, $Res Function(_AmlProfileModel) _then) = __$AmlProfileModelCopyWithImpl;
@override @useResult
$Res call({
 String regime, double ctrThreshold, double mtlThreshold, double cashForCashLimit, double casinoCheckForCashLimit, double sarThreshold, int sarFileDays, int sarExtensionDays, int gamingDayStartHour, double nearThresholdPct
});




}
/// @nodoc
class __$AmlProfileModelCopyWithImpl<$Res>
    implements _$AmlProfileModelCopyWith<$Res> {
  __$AmlProfileModelCopyWithImpl(this._self, this._then);

  final _AmlProfileModel _self;
  final $Res Function(_AmlProfileModel) _then;

/// Create a copy of AmlProfileModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? regime = null,Object? ctrThreshold = null,Object? mtlThreshold = null,Object? cashForCashLimit = null,Object? casinoCheckForCashLimit = null,Object? sarThreshold = null,Object? sarFileDays = null,Object? sarExtensionDays = null,Object? gamingDayStartHour = null,Object? nearThresholdPct = null,}) {
  return _then(_AmlProfileModel(
regime: null == regime ? _self.regime : regime // ignore: cast_nullable_to_non_nullable
as String,ctrThreshold: null == ctrThreshold ? _self.ctrThreshold : ctrThreshold // ignore: cast_nullable_to_non_nullable
as double,mtlThreshold: null == mtlThreshold ? _self.mtlThreshold : mtlThreshold // ignore: cast_nullable_to_non_nullable
as double,cashForCashLimit: null == cashForCashLimit ? _self.cashForCashLimit : cashForCashLimit // ignore: cast_nullable_to_non_nullable
as double,casinoCheckForCashLimit: null == casinoCheckForCashLimit ? _self.casinoCheckForCashLimit : casinoCheckForCashLimit // ignore: cast_nullable_to_non_nullable
as double,sarThreshold: null == sarThreshold ? _self.sarThreshold : sarThreshold // ignore: cast_nullable_to_non_nullable
as double,sarFileDays: null == sarFileDays ? _self.sarFileDays : sarFileDays // ignore: cast_nullable_to_non_nullable
as int,sarExtensionDays: null == sarExtensionDays ? _self.sarExtensionDays : sarExtensionDays // ignore: cast_nullable_to_non_nullable
as int,gamingDayStartHour: null == gamingDayStartHour ? _self.gamingDayStartHour : gamingDayStartHour // ignore: cast_nullable_to_non_nullable
as int,nearThresholdPct: null == nearThresholdPct ? _self.nearThresholdPct : nearThresholdPct // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$CompPolicyModel {

 double get pctOfTheo; double get quickLossPctOfActual; bool get quickLossEnabled;
/// Create a copy of CompPolicyModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompPolicyModelCopyWith<CompPolicyModel> get copyWith => _$CompPolicyModelCopyWithImpl<CompPolicyModel>(this as CompPolicyModel, _$identity);

  /// Serializes this CompPolicyModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CompPolicyModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompPolicyModel&&(identical(other.pctOfTheo, _this.pctOfTheo) || other.pctOfTheo == _this.pctOfTheo)&&(identical(other.quickLossPctOfActual, _this.quickLossPctOfActual) || other.quickLossPctOfActual == _this.quickLossPctOfActual)&&(identical(other.quickLossEnabled, _this.quickLossEnabled) || other.quickLossEnabled == _this.quickLossEnabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CompPolicyModel;
  return Object.hash(runtimeType,_this.pctOfTheo,_this.quickLossPctOfActual,_this.quickLossEnabled);
}

@override
String toString() {
  final _this = this as CompPolicyModel;
  return 'CompPolicyModel(pctOfTheo: ${_this.pctOfTheo}, quickLossPctOfActual: ${_this.quickLossPctOfActual}, quickLossEnabled: ${_this.quickLossEnabled})';
}


}

/// @nodoc
abstract mixin class $CompPolicyModelCopyWith<$Res>  {
  factory $CompPolicyModelCopyWith(CompPolicyModel value, $Res Function(CompPolicyModel) _then) = _$CompPolicyModelCopyWithImpl;
@useResult
$Res call({
 double pctOfTheo, double quickLossPctOfActual, bool quickLossEnabled
});




}
/// @nodoc
class _$CompPolicyModelCopyWithImpl<$Res>
    implements $CompPolicyModelCopyWith<$Res> {
  _$CompPolicyModelCopyWithImpl(this._self, this._then);

  final CompPolicyModel _self;
  final $Res Function(CompPolicyModel) _then;

/// Create a copy of CompPolicyModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pctOfTheo = null,Object? quickLossPctOfActual = null,Object? quickLossEnabled = null,}) {
  return _then(CompPolicyModel(
pctOfTheo: null == pctOfTheo ? _self.pctOfTheo : pctOfTheo // ignore: cast_nullable_to_non_nullable
as double,quickLossPctOfActual: null == quickLossPctOfActual ? _self.quickLossPctOfActual : quickLossPctOfActual // ignore: cast_nullable_to_non_nullable
as double,quickLossEnabled: null == quickLossEnabled ? _self.quickLossEnabled : quickLossEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CompPolicyModel].
extension CompPolicyModelPatterns on CompPolicyModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CompPolicyModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CompPolicyModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CompPolicyModel value)  $default,){
final _that = this;
switch (_that) {
case _CompPolicyModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CompPolicyModel value)?  $default,){
final _that = this;
switch (_that) {
case _CompPolicyModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double pctOfTheo,  double quickLossPctOfActual,  bool quickLossEnabled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CompPolicyModel() when $default != null:
return $default(_that.pctOfTheo,_that.quickLossPctOfActual,_that.quickLossEnabled);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double pctOfTheo,  double quickLossPctOfActual,  bool quickLossEnabled)  $default,) {final _that = this;
switch (_that) {
case _CompPolicyModel():
return $default(_that.pctOfTheo,_that.quickLossPctOfActual,_that.quickLossEnabled);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double pctOfTheo,  double quickLossPctOfActual,  bool quickLossEnabled)?  $default,) {final _that = this;
switch (_that) {
case _CompPolicyModel() when $default != null:
return $default(_that.pctOfTheo,_that.quickLossPctOfActual,_that.quickLossEnabled);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CompPolicyModel extends CompPolicyModel {
  const _CompPolicyModel({this.pctOfTheo = 0.45, this.quickLossPctOfActual = 0.15, this.quickLossEnabled = true}): super._();
  factory _CompPolicyModel.fromJson(Map<String, dynamic> json) => _$CompPolicyModelFromJson(json);

@override@JsonKey() final  double pctOfTheo;
@override@JsonKey() final  double quickLossPctOfActual;
@override@JsonKey() final  bool quickLossEnabled;

/// Create a copy of CompPolicyModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CompPolicyModelCopyWith<_CompPolicyModel> get copyWith => __$CompPolicyModelCopyWithImpl<_CompPolicyModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CompPolicyModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CompPolicyModel&&(identical(other.pctOfTheo, pctOfTheo) || other.pctOfTheo == pctOfTheo)&&(identical(other.quickLossPctOfActual, quickLossPctOfActual) || other.quickLossPctOfActual == quickLossPctOfActual)&&(identical(other.quickLossEnabled, quickLossEnabled) || other.quickLossEnabled == quickLossEnabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,pctOfTheo,quickLossPctOfActual,quickLossEnabled);
}

@override
String toString() {
    return 'CompPolicyModel(pctOfTheo: $pctOfTheo, quickLossPctOfActual: $quickLossPctOfActual, quickLossEnabled: $quickLossEnabled)';
}


}

/// @nodoc
abstract mixin class _$CompPolicyModelCopyWith<$Res> implements $CompPolicyModelCopyWith<$Res> {
  factory _$CompPolicyModelCopyWith(_CompPolicyModel value, $Res Function(_CompPolicyModel) _then) = __$CompPolicyModelCopyWithImpl;
@override @useResult
$Res call({
 double pctOfTheo, double quickLossPctOfActual, bool quickLossEnabled
});




}
/// @nodoc
class __$CompPolicyModelCopyWithImpl<$Res>
    implements _$CompPolicyModelCopyWith<$Res> {
  __$CompPolicyModelCopyWithImpl(this._self, this._then);

  final _CompPolicyModel _self;
  final $Res Function(_CompPolicyModel) _then;

/// Create a copy of CompPolicyModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pctOfTheo = null,Object? quickLossPctOfActual = null,Object? quickLossEnabled = null,}) {
  return _then(_CompPolicyModel(
pctOfTheo: null == pctOfTheo ? _self.pctOfTheo : pctOfTheo // ignore: cast_nullable_to_non_nullable
as double,quickLossPctOfActual: null == quickLossPctOfActual ? _self.quickLossPctOfActual : quickLossPctOfActual // ignore: cast_nullable_to_non_nullable
as double,quickLossEnabled: null == quickLossEnabled ? _self.quickLossEnabled : quickLossEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$SettingsModel {

 String get casinoName; String get jurisdictionLabel; AmlProfileModel get aml; CompPolicyModel get comps; double get gamingTaxRate; double get holdTolerance; Map<String, double> get houseAdvantage; Map<String, Map<String, double?>> get multipliers; double get ratingHitThreshold;
/// Create a copy of SettingsModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SettingsModelCopyWith<SettingsModel> get copyWith => _$SettingsModelCopyWithImpl<SettingsModel>(this as SettingsModel, _$identity);

  /// Serializes this SettingsModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SettingsModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingsModel&&(identical(other.casinoName, _this.casinoName) || other.casinoName == _this.casinoName)&&(identical(other.jurisdictionLabel, _this.jurisdictionLabel) || other.jurisdictionLabel == _this.jurisdictionLabel)&&(identical(other.aml, _this.aml) || other.aml == _this.aml)&&(identical(other.comps, _this.comps) || other.comps == _this.comps)&&(identical(other.gamingTaxRate, _this.gamingTaxRate) || other.gamingTaxRate == _this.gamingTaxRate)&&(identical(other.holdTolerance, _this.holdTolerance) || other.holdTolerance == _this.holdTolerance)&&const DeepCollectionEquality().equals(other.houseAdvantage, _this.houseAdvantage)&&const DeepCollectionEquality().equals(other.multipliers, _this.multipliers)&&(identical(other.ratingHitThreshold, _this.ratingHitThreshold) || other.ratingHitThreshold == _this.ratingHitThreshold));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SettingsModel;
  return Object.hash(runtimeType,_this.casinoName,_this.jurisdictionLabel,_this.aml,_this.comps,_this.gamingTaxRate,_this.holdTolerance,const DeepCollectionEquality().hash(_this.houseAdvantage),const DeepCollectionEquality().hash(_this.multipliers),_this.ratingHitThreshold);
}

@override
String toString() {
  final _this = this as SettingsModel;
  return 'SettingsModel(casinoName: ${_this.casinoName}, jurisdictionLabel: ${_this.jurisdictionLabel}, aml: ${_this.aml}, comps: ${_this.comps}, gamingTaxRate: ${_this.gamingTaxRate}, holdTolerance: ${_this.holdTolerance}, houseAdvantage: ${_this.houseAdvantage}, multipliers: ${_this.multipliers}, ratingHitThreshold: ${_this.ratingHitThreshold})';
}


}

/// @nodoc
abstract mixin class $SettingsModelCopyWith<$Res>  {
  factory $SettingsModelCopyWith(SettingsModel value, $Res Function(SettingsModel) _then) = _$SettingsModelCopyWithImpl;
@useResult
$Res call({
 String casinoName, String jurisdictionLabel, AmlProfileModel aml, CompPolicyModel comps, double gamingTaxRate, double holdTolerance, Map<String, double> houseAdvantage, Map<String, Map<String, double?>> multipliers, double ratingHitThreshold
});


$AmlProfileModelCopyWith<$Res> get aml;$CompPolicyModelCopyWith<$Res> get comps;

}
/// @nodoc
class _$SettingsModelCopyWithImpl<$Res>
    implements $SettingsModelCopyWith<$Res> {
  _$SettingsModelCopyWithImpl(this._self, this._then);

  final SettingsModel _self;
  final $Res Function(SettingsModel) _then;

/// Create a copy of SettingsModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? casinoName = null,Object? jurisdictionLabel = null,Object? aml = null,Object? comps = null,Object? gamingTaxRate = null,Object? holdTolerance = null,Object? houseAdvantage = null,Object? multipliers = null,Object? ratingHitThreshold = null,}) {
  return _then(SettingsModel(
casinoName: null == casinoName ? _self.casinoName : casinoName // ignore: cast_nullable_to_non_nullable
as String,jurisdictionLabel: null == jurisdictionLabel ? _self.jurisdictionLabel : jurisdictionLabel // ignore: cast_nullable_to_non_nullable
as String,aml: null == aml ? _self.aml : aml // ignore: cast_nullable_to_non_nullable
as AmlProfileModel,comps: null == comps ? _self.comps : comps // ignore: cast_nullable_to_non_nullable
as CompPolicyModel,gamingTaxRate: null == gamingTaxRate ? _self.gamingTaxRate : gamingTaxRate // ignore: cast_nullable_to_non_nullable
as double,holdTolerance: null == holdTolerance ? _self.holdTolerance : holdTolerance // ignore: cast_nullable_to_non_nullable
as double,houseAdvantage: null == houseAdvantage ? _self.houseAdvantage : houseAdvantage // ignore: cast_nullable_to_non_nullable
as Map<String, double>,multipliers: null == multipliers ? _self.multipliers : multipliers // ignore: cast_nullable_to_non_nullable
as Map<String, Map<String, double?>>,ratingHitThreshold: null == ratingHitThreshold ? _self.ratingHitThreshold : ratingHitThreshold // ignore: cast_nullable_to_non_nullable
as double,
  ));
}
/// Create a copy of SettingsModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AmlProfileModelCopyWith<$Res> get aml {
  
  return $AmlProfileModelCopyWith<$Res>(_self.aml, (value) {
    return _then(_self.copyWith(aml: value));
  });
}/// Create a copy of SettingsModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CompPolicyModelCopyWith<$Res> get comps {
  
  return $CompPolicyModelCopyWith<$Res>(_self.comps, (value) {
    return _then(_self.copyWith(comps: value));
  });
}
}


/// Adds pattern-matching-related methods to [SettingsModel].
extension SettingsModelPatterns on SettingsModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SettingsModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SettingsModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SettingsModel value)  $default,){
final _that = this;
switch (_that) {
case _SettingsModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SettingsModel value)?  $default,){
final _that = this;
switch (_that) {
case _SettingsModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String casinoName,  String jurisdictionLabel,  AmlProfileModel aml,  CompPolicyModel comps,  double gamingTaxRate,  double holdTolerance,  Map<String, double> houseAdvantage,  Map<String, Map<String, double?>> multipliers,  double ratingHitThreshold)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SettingsModel() when $default != null:
return $default(_that.casinoName,_that.jurisdictionLabel,_that.aml,_that.comps,_that.gamingTaxRate,_that.holdTolerance,_that.houseAdvantage,_that.multipliers,_that.ratingHitThreshold);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String casinoName,  String jurisdictionLabel,  AmlProfileModel aml,  CompPolicyModel comps,  double gamingTaxRate,  double holdTolerance,  Map<String, double> houseAdvantage,  Map<String, Map<String, double?>> multipliers,  double ratingHitThreshold)  $default,) {final _that = this;
switch (_that) {
case _SettingsModel():
return $default(_that.casinoName,_that.jurisdictionLabel,_that.aml,_that.comps,_that.gamingTaxRate,_that.holdTolerance,_that.houseAdvantage,_that.multipliers,_that.ratingHitThreshold);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String casinoName,  String jurisdictionLabel,  AmlProfileModel aml,  CompPolicyModel comps,  double gamingTaxRate,  double holdTolerance,  Map<String, double> houseAdvantage,  Map<String, Map<String, double?>> multipliers,  double ratingHitThreshold)?  $default,) {final _that = this;
switch (_that) {
case _SettingsModel() when $default != null:
return $default(_that.casinoName,_that.jurisdictionLabel,_that.aml,_that.comps,_that.gamingTaxRate,_that.holdTolerance,_that.houseAdvantage,_that.multipliers,_that.ratingHitThreshold);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SettingsModel extends SettingsModel {
  const _SettingsModel({this.casinoName = 'My Casino', this.jurisdictionLabel = 'Book reference (Nevada, 2003)', this.aml = const AmlProfileModel(), this.comps = const CompPolicyModel(), this.gamingTaxRate = 0.0625, this.holdTolerance = 0.03,  Map<String, double> houseAdvantage = const <String, double>{},  Map<String, Map<String, double?>> multipliers = const <String, Map<String, double?>>{}, this.ratingHitThreshold = 10000}): _houseAdvantage = houseAdvantage,_multipliers = multipliers,super._();
  factory _SettingsModel.fromJson(Map<String, dynamic> json) => _$SettingsModelFromJson(json);

@override@JsonKey() final  String casinoName;
@override@JsonKey() final  String jurisdictionLabel;
@override@JsonKey() final  AmlProfileModel aml;
@override@JsonKey() final  CompPolicyModel comps;
@override@JsonKey() final  double gamingTaxRate;
@override@JsonKey() final  double holdTolerance;
 final  Map<String, double> _houseAdvantage;
@override@JsonKey() Map<String, double> get houseAdvantage {
  if (_houseAdvantage is EqualUnmodifiableMapView) return _houseAdvantage;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_houseAdvantage);
}

 final  Map<String, Map<String, double?>> _multipliers;
@override@JsonKey() Map<String, Map<String, double?>> get multipliers {
  if (_multipliers is EqualUnmodifiableMapView) return _multipliers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_multipliers);
}

@override@JsonKey() final  double ratingHitThreshold;

/// Create a copy of SettingsModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SettingsModelCopyWith<_SettingsModel> get copyWith => __$SettingsModelCopyWithImpl<_SettingsModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SettingsModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SettingsModel&&(identical(other.casinoName, casinoName) || other.casinoName == casinoName)&&(identical(other.jurisdictionLabel, jurisdictionLabel) || other.jurisdictionLabel == jurisdictionLabel)&&(identical(other.aml, aml) || other.aml == aml)&&(identical(other.comps, comps) || other.comps == comps)&&(identical(other.gamingTaxRate, gamingTaxRate) || other.gamingTaxRate == gamingTaxRate)&&(identical(other.holdTolerance, holdTolerance) || other.holdTolerance == holdTolerance)&&const DeepCollectionEquality().equals(other.houseAdvantage, _houseAdvantage)&&const DeepCollectionEquality().equals(other.multipliers, _multipliers)&&(identical(other.ratingHitThreshold, ratingHitThreshold) || other.ratingHitThreshold == ratingHitThreshold));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,casinoName,jurisdictionLabel,aml,comps,gamingTaxRate,holdTolerance,const DeepCollectionEquality().hash(_houseAdvantage),const DeepCollectionEquality().hash(_multipliers),ratingHitThreshold);
}

@override
String toString() {
    return 'SettingsModel(casinoName: $casinoName, jurisdictionLabel: $jurisdictionLabel, aml: $aml, comps: $comps, gamingTaxRate: $gamingTaxRate, holdTolerance: $holdTolerance, houseAdvantage: $houseAdvantage, multipliers: $multipliers, ratingHitThreshold: $ratingHitThreshold)';
}


}

/// @nodoc
abstract mixin class _$SettingsModelCopyWith<$Res> implements $SettingsModelCopyWith<$Res> {
  factory _$SettingsModelCopyWith(_SettingsModel value, $Res Function(_SettingsModel) _then) = __$SettingsModelCopyWithImpl;
@override @useResult
$Res call({
 String casinoName, String jurisdictionLabel, AmlProfileModel aml, CompPolicyModel comps, double gamingTaxRate, double holdTolerance, Map<String, double> houseAdvantage, Map<String, Map<String, double?>> multipliers, double ratingHitThreshold
});


@override $AmlProfileModelCopyWith<$Res> get aml;@override $CompPolicyModelCopyWith<$Res> get comps;

}
/// @nodoc
class __$SettingsModelCopyWithImpl<$Res>
    implements _$SettingsModelCopyWith<$Res> {
  __$SettingsModelCopyWithImpl(this._self, this._then);

  final _SettingsModel _self;
  final $Res Function(_SettingsModel) _then;

/// Create a copy of SettingsModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? casinoName = null,Object? jurisdictionLabel = null,Object? aml = null,Object? comps = null,Object? gamingTaxRate = null,Object? holdTolerance = null,Object? houseAdvantage = null,Object? multipliers = null,Object? ratingHitThreshold = null,}) {
  return _then(_SettingsModel(
casinoName: null == casinoName ? _self.casinoName : casinoName // ignore: cast_nullable_to_non_nullable
as String,jurisdictionLabel: null == jurisdictionLabel ? _self.jurisdictionLabel : jurisdictionLabel // ignore: cast_nullable_to_non_nullable
as String,aml: null == aml ? _self.aml : aml // ignore: cast_nullable_to_non_nullable
as AmlProfileModel,comps: null == comps ? _self.comps : comps // ignore: cast_nullable_to_non_nullable
as CompPolicyModel,gamingTaxRate: null == gamingTaxRate ? _self.gamingTaxRate : gamingTaxRate // ignore: cast_nullable_to_non_nullable
as double,holdTolerance: null == holdTolerance ? _self.holdTolerance : holdTolerance // ignore: cast_nullable_to_non_nullable
as double,houseAdvantage: null == houseAdvantage ? _self._houseAdvantage : houseAdvantage // ignore: cast_nullable_to_non_nullable
as Map<String, double>,multipliers: null == multipliers ? _self._multipliers : multipliers // ignore: cast_nullable_to_non_nullable
as Map<String, Map<String, double?>>,ratingHitThreshold: null == ratingHitThreshold ? _self.ratingHitThreshold : ratingHitThreshold // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

/// Create a copy of SettingsModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AmlProfileModelCopyWith<$Res> get aml {
  
  return $AmlProfileModelCopyWith<$Res>(_self.aml, (value) {
    return _then(_self.copyWith(aml: value));
  });
}/// Create a copy of SettingsModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CompPolicyModelCopyWith<$Res> get comps {
  
  return $CompPolicyModelCopyWith<$Res>(_self.comps, (value) {
    return _then(_self.copyWith(comps: value));
  });
}
}

// dart format on
