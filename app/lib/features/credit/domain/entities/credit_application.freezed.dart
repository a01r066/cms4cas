// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'credit_application.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CreditApplication {

 String get id; String get playerId; String get createdBy; LineType get lineType; double get amount; CreditStatus get status; DateTime get createdAt; String get disposition; Map<String, bool> get answers; CreditOutcome? get outcome; List<String> get referrals; List<Signature> get signatures; DateTime? get decidedAt; String get declineReason;
/// Create a copy of CreditApplication
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreditApplicationCopyWith<CreditApplication> get copyWith => _$CreditApplicationCopyWithImpl<CreditApplication>(this as CreditApplication, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CreditApplication;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreditApplication&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.playerId, _this.playerId) || other.playerId == _this.playerId)&&(identical(other.createdBy, _this.createdBy) || other.createdBy == _this.createdBy)&&(identical(other.lineType, _this.lineType) || other.lineType == _this.lineType)&&(identical(other.amount, _this.amount) || other.amount == _this.amount)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.disposition, _this.disposition) || other.disposition == _this.disposition)&&const DeepCollectionEquality().equals(other.answers, _this.answers)&&(identical(other.outcome, _this.outcome) || other.outcome == _this.outcome)&&const DeepCollectionEquality().equals(other.referrals, _this.referrals)&&const DeepCollectionEquality().equals(other.signatures, _this.signatures)&&(identical(other.decidedAt, _this.decidedAt) || other.decidedAt == _this.decidedAt)&&(identical(other.declineReason, _this.declineReason) || other.declineReason == _this.declineReason));
}


@override
int get hashCode {
  final _this = this as CreditApplication;
  return Object.hash(runtimeType,_this.id,_this.playerId,_this.createdBy,_this.lineType,_this.amount,_this.status,_this.createdAt,_this.disposition,const DeepCollectionEquality().hash(_this.answers),_this.outcome,const DeepCollectionEquality().hash(_this.referrals),const DeepCollectionEquality().hash(_this.signatures),_this.decidedAt,_this.declineReason);
}

@override
String toString() {
  final _this = this as CreditApplication;
  return 'CreditApplication(id: ${_this.id}, playerId: ${_this.playerId}, createdBy: ${_this.createdBy}, lineType: ${_this.lineType}, amount: ${_this.amount}, status: ${_this.status}, createdAt: ${_this.createdAt}, disposition: ${_this.disposition}, answers: ${_this.answers}, outcome: ${_this.outcome}, referrals: ${_this.referrals}, signatures: ${_this.signatures}, decidedAt: ${_this.decidedAt}, declineReason: ${_this.declineReason})';
}


}

/// @nodoc
abstract mixin class $CreditApplicationCopyWith<$Res>  {
  factory $CreditApplicationCopyWith(CreditApplication value, $Res Function(CreditApplication) _then) = _$CreditApplicationCopyWithImpl;
@useResult
$Res call({
 String id, String playerId, String createdBy, LineType lineType, double amount, CreditStatus status, DateTime createdAt, String disposition, Map<String, bool> answers, CreditOutcome? outcome, List<String> referrals, List<Signature> signatures, DateTime? decidedAt, String declineReason
});




}
/// @nodoc
class _$CreditApplicationCopyWithImpl<$Res>
    implements $CreditApplicationCopyWith<$Res> {
  _$CreditApplicationCopyWithImpl(this._self, this._then);

  final CreditApplication _self;
  final $Res Function(CreditApplication) _then;

/// Create a copy of CreditApplication
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? playerId = null,Object? createdBy = null,Object? lineType = null,Object? amount = null,Object? status = null,Object? createdAt = null,Object? disposition = null,Object? answers = null,Object? outcome = freezed,Object? referrals = null,Object? signatures = null,Object? decidedAt = freezed,Object? declineReason = null,}) {
  return _then(CreditApplication(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,lineType: null == lineType ? _self.lineType : lineType // ignore: cast_nullable_to_non_nullable
as LineType,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CreditStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,disposition: null == disposition ? _self.disposition : disposition // ignore: cast_nullable_to_non_nullable
as String,answers: null == answers ? _self.answers : answers // ignore: cast_nullable_to_non_nullable
as Map<String, bool>,outcome: freezed == outcome ? _self.outcome : outcome // ignore: cast_nullable_to_non_nullable
as CreditOutcome?,referrals: null == referrals ? _self.referrals : referrals // ignore: cast_nullable_to_non_nullable
as List<String>,signatures: null == signatures ? _self.signatures : signatures // ignore: cast_nullable_to_non_nullable
as List<Signature>,decidedAt: freezed == decidedAt ? _self.decidedAt : decidedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,declineReason: null == declineReason ? _self.declineReason : declineReason // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CreditApplication].
extension CreditApplicationPatterns on CreditApplication {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreditApplication value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreditApplication() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreditApplication value)  $default,){
final _that = this;
switch (_that) {
case _CreditApplication():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreditApplication value)?  $default,){
final _that = this;
switch (_that) {
case _CreditApplication() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String playerId,  String createdBy,  LineType lineType,  double amount,  CreditStatus status,  DateTime createdAt,  String disposition,  Map<String, bool> answers,  CreditOutcome? outcome,  List<String> referrals,  List<Signature> signatures,  DateTime? decidedAt,  String declineReason)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreditApplication() when $default != null:
return $default(_that.id,_that.playerId,_that.createdBy,_that.lineType,_that.amount,_that.status,_that.createdAt,_that.disposition,_that.answers,_that.outcome,_that.referrals,_that.signatures,_that.decidedAt,_that.declineReason);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String playerId,  String createdBy,  LineType lineType,  double amount,  CreditStatus status,  DateTime createdAt,  String disposition,  Map<String, bool> answers,  CreditOutcome? outcome,  List<String> referrals,  List<Signature> signatures,  DateTime? decidedAt,  String declineReason)  $default,) {final _that = this;
switch (_that) {
case _CreditApplication():
return $default(_that.id,_that.playerId,_that.createdBy,_that.lineType,_that.amount,_that.status,_that.createdAt,_that.disposition,_that.answers,_that.outcome,_that.referrals,_that.signatures,_that.decidedAt,_that.declineReason);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String playerId,  String createdBy,  LineType lineType,  double amount,  CreditStatus status,  DateTime createdAt,  String disposition,  Map<String, bool> answers,  CreditOutcome? outcome,  List<String> referrals,  List<Signature> signatures,  DateTime? decidedAt,  String declineReason)?  $default,) {final _that = this;
switch (_that) {
case _CreditApplication() when $default != null:
return $default(_that.id,_that.playerId,_that.createdBy,_that.lineType,_that.amount,_that.status,_that.createdAt,_that.disposition,_that.answers,_that.outcome,_that.referrals,_that.signatures,_that.decidedAt,_that.declineReason);case _:
  return null;

}
}

}

/// @nodoc


class _CreditApplication extends CreditApplication {
  const _CreditApplication({required this.id, required this.playerId, required this.createdBy, required this.lineType, required this.amount, required this.status, required this.createdAt, this.disposition = kDefaultDisposition,  Map<String, bool> answers = const <String, bool>{}, this.outcome,  List<String> referrals = const <String>[],  List<Signature> signatures = const <Signature>[], this.decidedAt, this.declineReason = ''}): _answers = answers,_referrals = referrals,_signatures = signatures,super._();
  

@override final  String id;
@override final  String playerId;
@override final  String createdBy;
@override final  LineType lineType;
@override final  double amount;
@override final  CreditStatus status;
@override final  DateTime createdAt;
@override@JsonKey() final  String disposition;
 final  Map<String, bool> _answers;
@override@JsonKey() Map<String, bool> get answers {
  if (_answers is EqualUnmodifiableMapView) return _answers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_answers);
}

@override final  CreditOutcome? outcome;
 final  List<String> _referrals;
@override@JsonKey() List<String> get referrals {
  if (_referrals is EqualUnmodifiableListView) return _referrals;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_referrals);
}

 final  List<Signature> _signatures;
@override@JsonKey() List<Signature> get signatures {
  if (_signatures is EqualUnmodifiableListView) return _signatures;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_signatures);
}

@override final  DateTime? decidedAt;
@override@JsonKey() final  String declineReason;

/// Create a copy of CreditApplication
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreditApplicationCopyWith<_CreditApplication> get copyWith => __$CreditApplicationCopyWithImpl<_CreditApplication>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreditApplication&&(identical(other.id, id) || other.id == id)&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.lineType, lineType) || other.lineType == lineType)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.disposition, disposition) || other.disposition == disposition)&&const DeepCollectionEquality().equals(other.answers, _answers)&&(identical(other.outcome, outcome) || other.outcome == outcome)&&const DeepCollectionEquality().equals(other.referrals, _referrals)&&const DeepCollectionEquality().equals(other.signatures, _signatures)&&(identical(other.decidedAt, decidedAt) || other.decidedAt == decidedAt)&&(identical(other.declineReason, declineReason) || other.declineReason == declineReason));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,playerId,createdBy,lineType,amount,status,createdAt,disposition,const DeepCollectionEquality().hash(_answers),outcome,const DeepCollectionEquality().hash(_referrals),const DeepCollectionEquality().hash(_signatures),decidedAt,declineReason);
}

@override
String toString() {
    return 'CreditApplication(id: $id, playerId: $playerId, createdBy: $createdBy, lineType: $lineType, amount: $amount, status: $status, createdAt: $createdAt, disposition: $disposition, answers: $answers, outcome: $outcome, referrals: $referrals, signatures: $signatures, decidedAt: $decidedAt, declineReason: $declineReason)';
}


}

/// @nodoc
abstract mixin class _$CreditApplicationCopyWith<$Res> implements $CreditApplicationCopyWith<$Res> {
  factory _$CreditApplicationCopyWith(_CreditApplication value, $Res Function(_CreditApplication) _then) = __$CreditApplicationCopyWithImpl;
@override @useResult
$Res call({
 String id, String playerId, String createdBy, LineType lineType, double amount, CreditStatus status, DateTime createdAt, String disposition, Map<String, bool> answers, CreditOutcome? outcome, List<String> referrals, List<Signature> signatures, DateTime? decidedAt, String declineReason
});




}
/// @nodoc
class __$CreditApplicationCopyWithImpl<$Res>
    implements _$CreditApplicationCopyWith<$Res> {
  __$CreditApplicationCopyWithImpl(this._self, this._then);

  final _CreditApplication _self;
  final $Res Function(_CreditApplication) _then;

/// Create a copy of CreditApplication
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? playerId = null,Object? createdBy = null,Object? lineType = null,Object? amount = null,Object? status = null,Object? createdAt = null,Object? disposition = null,Object? answers = null,Object? outcome = freezed,Object? referrals = null,Object? signatures = null,Object? decidedAt = freezed,Object? declineReason = null,}) {
  return _then(_CreditApplication(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,lineType: null == lineType ? _self.lineType : lineType // ignore: cast_nullable_to_non_nullable
as LineType,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CreditStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,disposition: null == disposition ? _self.disposition : disposition // ignore: cast_nullable_to_non_nullable
as String,answers: null == answers ? _self._answers : answers // ignore: cast_nullable_to_non_nullable
as Map<String, bool>,outcome: freezed == outcome ? _self.outcome : outcome // ignore: cast_nullable_to_non_nullable
as CreditOutcome?,referrals: null == referrals ? _self._referrals : referrals // ignore: cast_nullable_to_non_nullable
as List<String>,signatures: null == signatures ? _self._signatures : signatures // ignore: cast_nullable_to_non_nullable
as List<Signature>,decidedAt: freezed == decidedAt ? _self.decidedAt : decidedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,declineReason: null == declineReason ? _self.declineReason : declineReason // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
