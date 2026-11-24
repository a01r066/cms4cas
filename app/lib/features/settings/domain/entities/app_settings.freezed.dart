// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppSettings {

 String get casinoName; String get jurisdictionLabel; AmlProfile get aml; CompPolicy get comps;/// Flat rate used by the promotion calculators.
 double get gamingTaxRate;/// ±3 points around base hold (Nevada).
 double get holdTolerance;/// gameId → house advantage override.
 Map<String, double> get houseAdvantage;/// gameId → player type wire → multiplier override (null = type not offered).
 Map<String, Map<String, double?>> get multipliers;/// Documented "hit" threshold for hold adjustment (Ch13 p.249).
 double get ratingHitThreshold;
/// Create a copy of AppSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppSettingsCopyWith<AppSettings> get copyWith => _$AppSettingsCopyWithImpl<AppSettings>(this as AppSettings, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AppSettings;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppSettings&&(identical(other.casinoName, _this.casinoName) || other.casinoName == _this.casinoName)&&(identical(other.jurisdictionLabel, _this.jurisdictionLabel) || other.jurisdictionLabel == _this.jurisdictionLabel)&&(identical(other.aml, _this.aml) || other.aml == _this.aml)&&(identical(other.comps, _this.comps) || other.comps == _this.comps)&&(identical(other.gamingTaxRate, _this.gamingTaxRate) || other.gamingTaxRate == _this.gamingTaxRate)&&(identical(other.holdTolerance, _this.holdTolerance) || other.holdTolerance == _this.holdTolerance)&&const DeepCollectionEquality().equals(other.houseAdvantage, _this.houseAdvantage)&&const DeepCollectionEquality().equals(other.multipliers, _this.multipliers)&&(identical(other.ratingHitThreshold, _this.ratingHitThreshold) || other.ratingHitThreshold == _this.ratingHitThreshold));
}


@override
int get hashCode {
  final _this = this as AppSettings;
  return Object.hash(runtimeType,_this.casinoName,_this.jurisdictionLabel,_this.aml,_this.comps,_this.gamingTaxRate,_this.holdTolerance,const DeepCollectionEquality().hash(_this.houseAdvantage),const DeepCollectionEquality().hash(_this.multipliers),_this.ratingHitThreshold);
}

@override
String toString() {
  final _this = this as AppSettings;
  return 'AppSettings(casinoName: ${_this.casinoName}, jurisdictionLabel: ${_this.jurisdictionLabel}, aml: ${_this.aml}, comps: ${_this.comps}, gamingTaxRate: ${_this.gamingTaxRate}, holdTolerance: ${_this.holdTolerance}, houseAdvantage: ${_this.houseAdvantage}, multipliers: ${_this.multipliers}, ratingHitThreshold: ${_this.ratingHitThreshold})';
}


}

/// @nodoc
abstract mixin class $AppSettingsCopyWith<$Res>  {
  factory $AppSettingsCopyWith(AppSettings value, $Res Function(AppSettings) _then) = _$AppSettingsCopyWithImpl;
@useResult
$Res call({
 String casinoName, String jurisdictionLabel, AmlProfile aml, CompPolicy comps, double gamingTaxRate, double holdTolerance, Map<String, double> houseAdvantage, Map<String, Map<String, double?>> multipliers, double ratingHitThreshold
});




}
/// @nodoc
class _$AppSettingsCopyWithImpl<$Res>
    implements $AppSettingsCopyWith<$Res> {
  _$AppSettingsCopyWithImpl(this._self, this._then);

  final AppSettings _self;
  final $Res Function(AppSettings) _then;

/// Create a copy of AppSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? casinoName = null,Object? jurisdictionLabel = null,Object? aml = null,Object? comps = null,Object? gamingTaxRate = null,Object? holdTolerance = null,Object? houseAdvantage = null,Object? multipliers = null,Object? ratingHitThreshold = null,}) {
  return _then(AppSettings(
casinoName: null == casinoName ? _self.casinoName : casinoName // ignore: cast_nullable_to_non_nullable
as String,jurisdictionLabel: null == jurisdictionLabel ? _self.jurisdictionLabel : jurisdictionLabel // ignore: cast_nullable_to_non_nullable
as String,aml: null == aml ? _self.aml : aml // ignore: cast_nullable_to_non_nullable
as AmlProfile,comps: null == comps ? _self.comps : comps // ignore: cast_nullable_to_non_nullable
as CompPolicy,gamingTaxRate: null == gamingTaxRate ? _self.gamingTaxRate : gamingTaxRate // ignore: cast_nullable_to_non_nullable
as double,holdTolerance: null == holdTolerance ? _self.holdTolerance : holdTolerance // ignore: cast_nullable_to_non_nullable
as double,houseAdvantage: null == houseAdvantage ? _self.houseAdvantage : houseAdvantage // ignore: cast_nullable_to_non_nullable
as Map<String, double>,multipliers: null == multipliers ? _self.multipliers : multipliers // ignore: cast_nullable_to_non_nullable
as Map<String, Map<String, double?>>,ratingHitThreshold: null == ratingHitThreshold ? _self.ratingHitThreshold : ratingHitThreshold // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [AppSettings].
extension AppSettingsPatterns on AppSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppSettings value)  $default,){
final _that = this;
switch (_that) {
case _AppSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppSettings value)?  $default,){
final _that = this;
switch (_that) {
case _AppSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String casinoName,  String jurisdictionLabel,  AmlProfile aml,  CompPolicy comps,  double gamingTaxRate,  double holdTolerance,  Map<String, double> houseAdvantage,  Map<String, Map<String, double?>> multipliers,  double ratingHitThreshold)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppSettings() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String casinoName,  String jurisdictionLabel,  AmlProfile aml,  CompPolicy comps,  double gamingTaxRate,  double holdTolerance,  Map<String, double> houseAdvantage,  Map<String, Map<String, double?>> multipliers,  double ratingHitThreshold)  $default,) {final _that = this;
switch (_that) {
case _AppSettings():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String casinoName,  String jurisdictionLabel,  AmlProfile aml,  CompPolicy comps,  double gamingTaxRate,  double holdTolerance,  Map<String, double> houseAdvantage,  Map<String, Map<String, double?>> multipliers,  double ratingHitThreshold)?  $default,) {final _that = this;
switch (_that) {
case _AppSettings() when $default != null:
return $default(_that.casinoName,_that.jurisdictionLabel,_that.aml,_that.comps,_that.gamingTaxRate,_that.holdTolerance,_that.houseAdvantage,_that.multipliers,_that.ratingHitThreshold);case _:
  return null;

}
}

}

/// @nodoc


class _AppSettings extends AppSettings {
  const _AppSettings({this.casinoName = 'My Casino', this.jurisdictionLabel = 'Book reference (Nevada, 2003)', this.aml = AmlProfile.bookNevada2003, this.comps = const CompPolicy(), this.gamingTaxRate = 0.0625, this.holdTolerance = 0.03,  Map<String, double> houseAdvantage = const <String, double>{},  Map<String, Map<String, double?>> multipliers = const <String, Map<String, double?>>{}, this.ratingHitThreshold = 10000}): _houseAdvantage = houseAdvantage,_multipliers = multipliers,super._();
  

@override@JsonKey() final  String casinoName;
@override@JsonKey() final  String jurisdictionLabel;
@override@JsonKey() final  AmlProfile aml;
@override@JsonKey() final  CompPolicy comps;
/// Flat rate used by the promotion calculators.
@override@JsonKey() final  double gamingTaxRate;
/// ±3 points around base hold (Nevada).
@override@JsonKey() final  double holdTolerance;
/// gameId → house advantage override.
 final  Map<String, double> _houseAdvantage;
/// gameId → house advantage override.
@override@JsonKey() Map<String, double> get houseAdvantage {
  if (_houseAdvantage is EqualUnmodifiableMapView) return _houseAdvantage;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_houseAdvantage);
}

/// gameId → player type wire → multiplier override (null = type not offered).
 final  Map<String, Map<String, double?>> _multipliers;
/// gameId → player type wire → multiplier override (null = type not offered).
@override@JsonKey() Map<String, Map<String, double?>> get multipliers {
  if (_multipliers is EqualUnmodifiableMapView) return _multipliers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_multipliers);
}

/// Documented "hit" threshold for hold adjustment (Ch13 p.249).
@override@JsonKey() final  double ratingHitThreshold;

/// Create a copy of AppSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppSettingsCopyWith<_AppSettings> get copyWith => __$AppSettingsCopyWithImpl<_AppSettings>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppSettings&&(identical(other.casinoName, casinoName) || other.casinoName == casinoName)&&(identical(other.jurisdictionLabel, jurisdictionLabel) || other.jurisdictionLabel == jurisdictionLabel)&&(identical(other.aml, aml) || other.aml == aml)&&(identical(other.comps, comps) || other.comps == comps)&&(identical(other.gamingTaxRate, gamingTaxRate) || other.gamingTaxRate == gamingTaxRate)&&(identical(other.holdTolerance, holdTolerance) || other.holdTolerance == holdTolerance)&&const DeepCollectionEquality().equals(other.houseAdvantage, _houseAdvantage)&&const DeepCollectionEquality().equals(other.multipliers, _multipliers)&&(identical(other.ratingHitThreshold, ratingHitThreshold) || other.ratingHitThreshold == ratingHitThreshold));
}


@override
int get hashCode {
    return Object.hash(runtimeType,casinoName,jurisdictionLabel,aml,comps,gamingTaxRate,holdTolerance,const DeepCollectionEquality().hash(_houseAdvantage),const DeepCollectionEquality().hash(_multipliers),ratingHitThreshold);
}

@override
String toString() {
    return 'AppSettings(casinoName: $casinoName, jurisdictionLabel: $jurisdictionLabel, aml: $aml, comps: $comps, gamingTaxRate: $gamingTaxRate, holdTolerance: $holdTolerance, houseAdvantage: $houseAdvantage, multipliers: $multipliers, ratingHitThreshold: $ratingHitThreshold)';
}


}

/// @nodoc
abstract mixin class _$AppSettingsCopyWith<$Res> implements $AppSettingsCopyWith<$Res> {
  factory _$AppSettingsCopyWith(_AppSettings value, $Res Function(_AppSettings) _then) = __$AppSettingsCopyWithImpl;
@override @useResult
$Res call({
 String casinoName, String jurisdictionLabel, AmlProfile aml, CompPolicy comps, double gamingTaxRate, double holdTolerance, Map<String, double> houseAdvantage, Map<String, Map<String, double?>> multipliers, double ratingHitThreshold
});




}
/// @nodoc
class __$AppSettingsCopyWithImpl<$Res>
    implements _$AppSettingsCopyWith<$Res> {
  __$AppSettingsCopyWithImpl(this._self, this._then);

  final _AppSettings _self;
  final $Res Function(_AppSettings) _then;

/// Create a copy of AppSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? casinoName = null,Object? jurisdictionLabel = null,Object? aml = null,Object? comps = null,Object? gamingTaxRate = null,Object? holdTolerance = null,Object? houseAdvantage = null,Object? multipliers = null,Object? ratingHitThreshold = null,}) {
  return _then(_AppSettings(
casinoName: null == casinoName ? _self.casinoName : casinoName // ignore: cast_nullable_to_non_nullable
as String,jurisdictionLabel: null == jurisdictionLabel ? _self.jurisdictionLabel : jurisdictionLabel // ignore: cast_nullable_to_non_nullable
as String,aml: null == aml ? _self.aml : aml // ignore: cast_nullable_to_non_nullable
as AmlProfile,comps: null == comps ? _self.comps : comps // ignore: cast_nullable_to_non_nullable
as CompPolicy,gamingTaxRate: null == gamingTaxRate ? _self.gamingTaxRate : gamingTaxRate // ignore: cast_nullable_to_non_nullable
as double,holdTolerance: null == holdTolerance ? _self.holdTolerance : holdTolerance // ignore: cast_nullable_to_non_nullable
as double,houseAdvantage: null == houseAdvantage ? _self._houseAdvantage : houseAdvantage // ignore: cast_nullable_to_non_nullable
as Map<String, double>,multipliers: null == multipliers ? _self._multipliers : multipliers // ignore: cast_nullable_to_non_nullable
as Map<String, Map<String, double?>>,ratingHitThreshold: null == ratingHitThreshold ? _self.ratingHitThreshold : ratingHitThreshold // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
