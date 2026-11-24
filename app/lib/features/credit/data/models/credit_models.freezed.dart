// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'credit_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SignatureModel {

 String get userId; String get userName; String get role; DateTime get at;
/// Create a copy of SignatureModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignatureModelCopyWith<SignatureModel> get copyWith => _$SignatureModelCopyWithImpl<SignatureModel>(this as SignatureModel, _$identity);

  /// Serializes this SignatureModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SignatureModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignatureModel&&(identical(other.userId, _this.userId) || other.userId == _this.userId)&&(identical(other.userName, _this.userName) || other.userName == _this.userName)&&(identical(other.role, _this.role) || other.role == _this.role)&&(identical(other.at, _this.at) || other.at == _this.at));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SignatureModel;
  return Object.hash(runtimeType,_this.userId,_this.userName,_this.role,_this.at);
}

@override
String toString() {
  final _this = this as SignatureModel;
  return 'SignatureModel(userId: ${_this.userId}, userName: ${_this.userName}, role: ${_this.role}, at: ${_this.at})';
}


}

/// @nodoc
abstract mixin class $SignatureModelCopyWith<$Res>  {
  factory $SignatureModelCopyWith(SignatureModel value, $Res Function(SignatureModel) _then) = _$SignatureModelCopyWithImpl;
@useResult
$Res call({
 String userId, String userName, String role, DateTime at
});




}
/// @nodoc
class _$SignatureModelCopyWithImpl<$Res>
    implements $SignatureModelCopyWith<$Res> {
  _$SignatureModelCopyWithImpl(this._self, this._then);

  final SignatureModel _self;
  final $Res Function(SignatureModel) _then;

/// Create a copy of SignatureModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? userName = null,Object? role = null,Object? at = null,}) {
  return _then(SignatureModel(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,at: null == at ? _self.at : at // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [SignatureModel].
extension SignatureModelPatterns on SignatureModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SignatureModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SignatureModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SignatureModel value)  $default,){
final _that = this;
switch (_that) {
case _SignatureModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SignatureModel value)?  $default,){
final _that = this;
switch (_that) {
case _SignatureModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  String userName,  String role,  DateTime at)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SignatureModel() when $default != null:
return $default(_that.userId,_that.userName,_that.role,_that.at);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  String userName,  String role,  DateTime at)  $default,) {final _that = this;
switch (_that) {
case _SignatureModel():
return $default(_that.userId,_that.userName,_that.role,_that.at);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  String userName,  String role,  DateTime at)?  $default,) {final _that = this;
switch (_that) {
case _SignatureModel() when $default != null:
return $default(_that.userId,_that.userName,_that.role,_that.at);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SignatureModel extends SignatureModel {
  const _SignatureModel({required this.userId, this.userName = '', this.role = 'host', required this.at}): super._();
  factory _SignatureModel.fromJson(Map<String, dynamic> json) => _$SignatureModelFromJson(json);

@override final  String userId;
@override@JsonKey() final  String userName;
@override@JsonKey() final  String role;
@override final  DateTime at;

/// Create a copy of SignatureModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignatureModelCopyWith<_SignatureModel> get copyWith => __$SignatureModelCopyWithImpl<_SignatureModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SignatureModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignatureModel&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.role, role) || other.role == role)&&(identical(other.at, at) || other.at == at));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,userId,userName,role,at);
}

@override
String toString() {
    return 'SignatureModel(userId: $userId, userName: $userName, role: $role, at: $at)';
}


}

/// @nodoc
abstract mixin class _$SignatureModelCopyWith<$Res> implements $SignatureModelCopyWith<$Res> {
  factory _$SignatureModelCopyWith(_SignatureModel value, $Res Function(_SignatureModel) _then) = __$SignatureModelCopyWithImpl;
@override @useResult
$Res call({
 String userId, String userName, String role, DateTime at
});




}
/// @nodoc
class __$SignatureModelCopyWithImpl<$Res>
    implements _$SignatureModelCopyWith<$Res> {
  __$SignatureModelCopyWithImpl(this._self, this._then);

  final _SignatureModel _self;
  final $Res Function(_SignatureModel) _then;

/// Create a copy of SignatureModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? userName = null,Object? role = null,Object? at = null,}) {
  return _then(_SignatureModel(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,at: null == at ? _self.at : at // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$CreditApplicationModel {

 String get id; String get playerId; String get createdBy; String get lineType; double get amount; String get status; String get disposition; Map<String, bool> get answers; String? get outcome; List<String> get referrals; List<SignatureModel> get signatures; DateTime get createdAt; DateTime? get decidedAt; String get declineReason;
/// Create a copy of CreditApplicationModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreditApplicationModelCopyWith<CreditApplicationModel> get copyWith => _$CreditApplicationModelCopyWithImpl<CreditApplicationModel>(this as CreditApplicationModel, _$identity);

  /// Serializes this CreditApplicationModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CreditApplicationModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreditApplicationModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.playerId, _this.playerId) || other.playerId == _this.playerId)&&(identical(other.createdBy, _this.createdBy) || other.createdBy == _this.createdBy)&&(identical(other.lineType, _this.lineType) || other.lineType == _this.lineType)&&(identical(other.amount, _this.amount) || other.amount == _this.amount)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.disposition, _this.disposition) || other.disposition == _this.disposition)&&const DeepCollectionEquality().equals(other.answers, _this.answers)&&(identical(other.outcome, _this.outcome) || other.outcome == _this.outcome)&&const DeepCollectionEquality().equals(other.referrals, _this.referrals)&&const DeepCollectionEquality().equals(other.signatures, _this.signatures)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.decidedAt, _this.decidedAt) || other.decidedAt == _this.decidedAt)&&(identical(other.declineReason, _this.declineReason) || other.declineReason == _this.declineReason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CreditApplicationModel;
  return Object.hash(runtimeType,_this.id,_this.playerId,_this.createdBy,_this.lineType,_this.amount,_this.status,_this.disposition,const DeepCollectionEquality().hash(_this.answers),_this.outcome,const DeepCollectionEquality().hash(_this.referrals),const DeepCollectionEquality().hash(_this.signatures),_this.createdAt,_this.decidedAt,_this.declineReason);
}

@override
String toString() {
  final _this = this as CreditApplicationModel;
  return 'CreditApplicationModel(id: ${_this.id}, playerId: ${_this.playerId}, createdBy: ${_this.createdBy}, lineType: ${_this.lineType}, amount: ${_this.amount}, status: ${_this.status}, disposition: ${_this.disposition}, answers: ${_this.answers}, outcome: ${_this.outcome}, referrals: ${_this.referrals}, signatures: ${_this.signatures}, createdAt: ${_this.createdAt}, decidedAt: ${_this.decidedAt}, declineReason: ${_this.declineReason})';
}


}

/// @nodoc
abstract mixin class $CreditApplicationModelCopyWith<$Res>  {
  factory $CreditApplicationModelCopyWith(CreditApplicationModel value, $Res Function(CreditApplicationModel) _then) = _$CreditApplicationModelCopyWithImpl;
@useResult
$Res call({
 String id, String playerId, String createdBy, String lineType, double amount, String status, String disposition, Map<String, bool> answers, String? outcome, List<String> referrals, List<SignatureModel> signatures, DateTime createdAt, DateTime? decidedAt, String declineReason
});




}
/// @nodoc
class _$CreditApplicationModelCopyWithImpl<$Res>
    implements $CreditApplicationModelCopyWith<$Res> {
  _$CreditApplicationModelCopyWithImpl(this._self, this._then);

  final CreditApplicationModel _self;
  final $Res Function(CreditApplicationModel) _then;

/// Create a copy of CreditApplicationModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? playerId = null,Object? createdBy = null,Object? lineType = null,Object? amount = null,Object? status = null,Object? disposition = null,Object? answers = null,Object? outcome = freezed,Object? referrals = null,Object? signatures = null,Object? createdAt = null,Object? decidedAt = freezed,Object? declineReason = null,}) {
  return _then(CreditApplicationModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,lineType: null == lineType ? _self.lineType : lineType // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,disposition: null == disposition ? _self.disposition : disposition // ignore: cast_nullable_to_non_nullable
as String,answers: null == answers ? _self.answers : answers // ignore: cast_nullable_to_non_nullable
as Map<String, bool>,outcome: freezed == outcome ? _self.outcome : outcome // ignore: cast_nullable_to_non_nullable
as String?,referrals: null == referrals ? _self.referrals : referrals // ignore: cast_nullable_to_non_nullable
as List<String>,signatures: null == signatures ? _self.signatures : signatures // ignore: cast_nullable_to_non_nullable
as List<SignatureModel>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,decidedAt: freezed == decidedAt ? _self.decidedAt : decidedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,declineReason: null == declineReason ? _self.declineReason : declineReason // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CreditApplicationModel].
extension CreditApplicationModelPatterns on CreditApplicationModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreditApplicationModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreditApplicationModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreditApplicationModel value)  $default,){
final _that = this;
switch (_that) {
case _CreditApplicationModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreditApplicationModel value)?  $default,){
final _that = this;
switch (_that) {
case _CreditApplicationModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String playerId,  String createdBy,  String lineType,  double amount,  String status,  String disposition,  Map<String, bool> answers,  String? outcome,  List<String> referrals,  List<SignatureModel> signatures,  DateTime createdAt,  DateTime? decidedAt,  String declineReason)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreditApplicationModel() when $default != null:
return $default(_that.id,_that.playerId,_that.createdBy,_that.lineType,_that.amount,_that.status,_that.disposition,_that.answers,_that.outcome,_that.referrals,_that.signatures,_that.createdAt,_that.decidedAt,_that.declineReason);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String playerId,  String createdBy,  String lineType,  double amount,  String status,  String disposition,  Map<String, bool> answers,  String? outcome,  List<String> referrals,  List<SignatureModel> signatures,  DateTime createdAt,  DateTime? decidedAt,  String declineReason)  $default,) {final _that = this;
switch (_that) {
case _CreditApplicationModel():
return $default(_that.id,_that.playerId,_that.createdBy,_that.lineType,_that.amount,_that.status,_that.disposition,_that.answers,_that.outcome,_that.referrals,_that.signatures,_that.createdAt,_that.decidedAt,_that.declineReason);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String playerId,  String createdBy,  String lineType,  double amount,  String status,  String disposition,  Map<String, bool> answers,  String? outcome,  List<String> referrals,  List<SignatureModel> signatures,  DateTime createdAt,  DateTime? decidedAt,  String declineReason)?  $default,) {final _that = this;
switch (_that) {
case _CreditApplicationModel() when $default != null:
return $default(_that.id,_that.playerId,_that.createdBy,_that.lineType,_that.amount,_that.status,_that.disposition,_that.answers,_that.outcome,_that.referrals,_that.signatures,_that.createdAt,_that.decidedAt,_that.declineReason);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreditApplicationModel extends CreditApplicationModel {
  const _CreditApplicationModel({required this.id, this.playerId = '', this.createdBy = '', this.lineType = 'permanent', this.amount = 0, this.status = 'draft', this.disposition = kDefaultDisposition,  Map<String, bool> answers = const <String, bool>{}, this.outcome,  List<String> referrals = const <String>[],  List<SignatureModel> signatures = const <SignatureModel>[], required this.createdAt, this.decidedAt, this.declineReason = ''}): _answers = answers,_referrals = referrals,_signatures = signatures,super._();
  factory _CreditApplicationModel.fromJson(Map<String, dynamic> json) => _$CreditApplicationModelFromJson(json);

@override final  String id;
@override@JsonKey() final  String playerId;
@override@JsonKey() final  String createdBy;
@override@JsonKey() final  String lineType;
@override@JsonKey() final  double amount;
@override@JsonKey() final  String status;
@override@JsonKey() final  String disposition;
 final  Map<String, bool> _answers;
@override@JsonKey() Map<String, bool> get answers {
  if (_answers is EqualUnmodifiableMapView) return _answers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_answers);
}

@override final  String? outcome;
 final  List<String> _referrals;
@override@JsonKey() List<String> get referrals {
  if (_referrals is EqualUnmodifiableListView) return _referrals;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_referrals);
}

 final  List<SignatureModel> _signatures;
@override@JsonKey() List<SignatureModel> get signatures {
  if (_signatures is EqualUnmodifiableListView) return _signatures;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_signatures);
}

@override final  DateTime createdAt;
@override final  DateTime? decidedAt;
@override@JsonKey() final  String declineReason;

/// Create a copy of CreditApplicationModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreditApplicationModelCopyWith<_CreditApplicationModel> get copyWith => __$CreditApplicationModelCopyWithImpl<_CreditApplicationModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreditApplicationModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreditApplicationModel&&(identical(other.id, id) || other.id == id)&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.lineType, lineType) || other.lineType == lineType)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.status, status) || other.status == status)&&(identical(other.disposition, disposition) || other.disposition == disposition)&&const DeepCollectionEquality().equals(other.answers, _answers)&&(identical(other.outcome, outcome) || other.outcome == outcome)&&const DeepCollectionEquality().equals(other.referrals, _referrals)&&const DeepCollectionEquality().equals(other.signatures, _signatures)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.decidedAt, decidedAt) || other.decidedAt == decidedAt)&&(identical(other.declineReason, declineReason) || other.declineReason == declineReason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,playerId,createdBy,lineType,amount,status,disposition,const DeepCollectionEquality().hash(_answers),outcome,const DeepCollectionEquality().hash(_referrals),const DeepCollectionEquality().hash(_signatures),createdAt,decidedAt,declineReason);
}

@override
String toString() {
    return 'CreditApplicationModel(id: $id, playerId: $playerId, createdBy: $createdBy, lineType: $lineType, amount: $amount, status: $status, disposition: $disposition, answers: $answers, outcome: $outcome, referrals: $referrals, signatures: $signatures, createdAt: $createdAt, decidedAt: $decidedAt, declineReason: $declineReason)';
}


}

/// @nodoc
abstract mixin class _$CreditApplicationModelCopyWith<$Res> implements $CreditApplicationModelCopyWith<$Res> {
  factory _$CreditApplicationModelCopyWith(_CreditApplicationModel value, $Res Function(_CreditApplicationModel) _then) = __$CreditApplicationModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String playerId, String createdBy, String lineType, double amount, String status, String disposition, Map<String, bool> answers, String? outcome, List<String> referrals, List<SignatureModel> signatures, DateTime createdAt, DateTime? decidedAt, String declineReason
});




}
/// @nodoc
class __$CreditApplicationModelCopyWithImpl<$Res>
    implements _$CreditApplicationModelCopyWith<$Res> {
  __$CreditApplicationModelCopyWithImpl(this._self, this._then);

  final _CreditApplicationModel _self;
  final $Res Function(_CreditApplicationModel) _then;

/// Create a copy of CreditApplicationModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? playerId = null,Object? createdBy = null,Object? lineType = null,Object? amount = null,Object? status = null,Object? disposition = null,Object? answers = null,Object? outcome = freezed,Object? referrals = null,Object? signatures = null,Object? createdAt = null,Object? decidedAt = freezed,Object? declineReason = null,}) {
  return _then(_CreditApplicationModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,lineType: null == lineType ? _self.lineType : lineType // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,disposition: null == disposition ? _self.disposition : disposition // ignore: cast_nullable_to_non_nullable
as String,answers: null == answers ? _self._answers : answers // ignore: cast_nullable_to_non_nullable
as Map<String, bool>,outcome: freezed == outcome ? _self.outcome : outcome // ignore: cast_nullable_to_non_nullable
as String?,referrals: null == referrals ? _self._referrals : referrals // ignore: cast_nullable_to_non_nullable
as List<String>,signatures: null == signatures ? _self._signatures : signatures // ignore: cast_nullable_to_non_nullable
as List<SignatureModel>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,decidedAt: freezed == decidedAt ? _self.decidedAt : decidedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,declineReason: null == declineReason ? _self.declineReason : declineReason // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$MarkerPaymentModel {

 double get amount; String get method; String get recordedBy; DateTime get at;
/// Create a copy of MarkerPaymentModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MarkerPaymentModelCopyWith<MarkerPaymentModel> get copyWith => _$MarkerPaymentModelCopyWithImpl<MarkerPaymentModel>(this as MarkerPaymentModel, _$identity);

  /// Serializes this MarkerPaymentModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MarkerPaymentModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MarkerPaymentModel&&(identical(other.amount, _this.amount) || other.amount == _this.amount)&&(identical(other.method, _this.method) || other.method == _this.method)&&(identical(other.recordedBy, _this.recordedBy) || other.recordedBy == _this.recordedBy)&&(identical(other.at, _this.at) || other.at == _this.at));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MarkerPaymentModel;
  return Object.hash(runtimeType,_this.amount,_this.method,_this.recordedBy,_this.at);
}

@override
String toString() {
  final _this = this as MarkerPaymentModel;
  return 'MarkerPaymentModel(amount: ${_this.amount}, method: ${_this.method}, recordedBy: ${_this.recordedBy}, at: ${_this.at})';
}


}

/// @nodoc
abstract mixin class $MarkerPaymentModelCopyWith<$Res>  {
  factory $MarkerPaymentModelCopyWith(MarkerPaymentModel value, $Res Function(MarkerPaymentModel) _then) = _$MarkerPaymentModelCopyWithImpl;
@useResult
$Res call({
 double amount, String method, String recordedBy, DateTime at
});




}
/// @nodoc
class _$MarkerPaymentModelCopyWithImpl<$Res>
    implements $MarkerPaymentModelCopyWith<$Res> {
  _$MarkerPaymentModelCopyWithImpl(this._self, this._then);

  final MarkerPaymentModel _self;
  final $Res Function(MarkerPaymentModel) _then;

/// Create a copy of MarkerPaymentModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? amount = null,Object? method = null,Object? recordedBy = null,Object? at = null,}) {
  return _then(MarkerPaymentModel(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,method: null == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as String,recordedBy: null == recordedBy ? _self.recordedBy : recordedBy // ignore: cast_nullable_to_non_nullable
as String,at: null == at ? _self.at : at // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [MarkerPaymentModel].
extension MarkerPaymentModelPatterns on MarkerPaymentModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MarkerPaymentModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MarkerPaymentModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MarkerPaymentModel value)  $default,){
final _that = this;
switch (_that) {
case _MarkerPaymentModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MarkerPaymentModel value)?  $default,){
final _that = this;
switch (_that) {
case _MarkerPaymentModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double amount,  String method,  String recordedBy,  DateTime at)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MarkerPaymentModel() when $default != null:
return $default(_that.amount,_that.method,_that.recordedBy,_that.at);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double amount,  String method,  String recordedBy,  DateTime at)  $default,) {final _that = this;
switch (_that) {
case _MarkerPaymentModel():
return $default(_that.amount,_that.method,_that.recordedBy,_that.at);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double amount,  String method,  String recordedBy,  DateTime at)?  $default,) {final _that = this;
switch (_that) {
case _MarkerPaymentModel() when $default != null:
return $default(_that.amount,_that.method,_that.recordedBy,_that.at);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MarkerPaymentModel extends MarkerPaymentModel {
  const _MarkerPaymentModel({this.amount = 0, this.method = '', this.recordedBy = '', required this.at}): super._();
  factory _MarkerPaymentModel.fromJson(Map<String, dynamic> json) => _$MarkerPaymentModelFromJson(json);

@override@JsonKey() final  double amount;
@override@JsonKey() final  String method;
@override@JsonKey() final  String recordedBy;
@override final  DateTime at;

/// Create a copy of MarkerPaymentModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MarkerPaymentModelCopyWith<_MarkerPaymentModel> get copyWith => __$MarkerPaymentModelCopyWithImpl<_MarkerPaymentModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MarkerPaymentModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MarkerPaymentModel&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.method, method) || other.method == method)&&(identical(other.recordedBy, recordedBy) || other.recordedBy == recordedBy)&&(identical(other.at, at) || other.at == at));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,amount,method,recordedBy,at);
}

@override
String toString() {
    return 'MarkerPaymentModel(amount: $amount, method: $method, recordedBy: $recordedBy, at: $at)';
}


}

/// @nodoc
abstract mixin class _$MarkerPaymentModelCopyWith<$Res> implements $MarkerPaymentModelCopyWith<$Res> {
  factory _$MarkerPaymentModelCopyWith(_MarkerPaymentModel value, $Res Function(_MarkerPaymentModel) _then) = __$MarkerPaymentModelCopyWithImpl;
@override @useResult
$Res call({
 double amount, String method, String recordedBy, DateTime at
});




}
/// @nodoc
class __$MarkerPaymentModelCopyWithImpl<$Res>
    implements _$MarkerPaymentModelCopyWith<$Res> {
  __$MarkerPaymentModelCopyWithImpl(this._self, this._then);

  final _MarkerPaymentModel _self;
  final $Res Function(_MarkerPaymentModel) _then;

/// Create a copy of MarkerPaymentModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? amount = null,Object? method = null,Object? recordedBy = null,Object? at = null,}) {
  return _then(_MarkerPaymentModel(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,method: null == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as String,recordedBy: null == recordedBy ? _self.recordedBy : recordedBy // ignore: cast_nullable_to_non_nullable
as String,at: null == at ? _self.at : at // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$MarkerModel {

 String get id; String get playerId; String get number; String get table; String get issuedBy; double get amount; DateTime get issuedAt; List<MarkerPaymentModel> get payments; String get status; double get writeOffAmount; String get writeOffReason; List<SignatureModel> get writeOffSignatures; String get collectionNote;
/// Create a copy of MarkerModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MarkerModelCopyWith<MarkerModel> get copyWith => _$MarkerModelCopyWithImpl<MarkerModel>(this as MarkerModel, _$identity);

  /// Serializes this MarkerModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MarkerModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MarkerModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.playerId, _this.playerId) || other.playerId == _this.playerId)&&(identical(other.number, _this.number) || other.number == _this.number)&&(identical(other.table, _this.table) || other.table == _this.table)&&(identical(other.issuedBy, _this.issuedBy) || other.issuedBy == _this.issuedBy)&&(identical(other.amount, _this.amount) || other.amount == _this.amount)&&(identical(other.issuedAt, _this.issuedAt) || other.issuedAt == _this.issuedAt)&&const DeepCollectionEquality().equals(other.payments, _this.payments)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.writeOffAmount, _this.writeOffAmount) || other.writeOffAmount == _this.writeOffAmount)&&(identical(other.writeOffReason, _this.writeOffReason) || other.writeOffReason == _this.writeOffReason)&&const DeepCollectionEquality().equals(other.writeOffSignatures, _this.writeOffSignatures)&&(identical(other.collectionNote, _this.collectionNote) || other.collectionNote == _this.collectionNote));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MarkerModel;
  return Object.hash(runtimeType,_this.id,_this.playerId,_this.number,_this.table,_this.issuedBy,_this.amount,_this.issuedAt,const DeepCollectionEquality().hash(_this.payments),_this.status,_this.writeOffAmount,_this.writeOffReason,const DeepCollectionEquality().hash(_this.writeOffSignatures),_this.collectionNote);
}

@override
String toString() {
  final _this = this as MarkerModel;
  return 'MarkerModel(id: ${_this.id}, playerId: ${_this.playerId}, number: ${_this.number}, table: ${_this.table}, issuedBy: ${_this.issuedBy}, amount: ${_this.amount}, issuedAt: ${_this.issuedAt}, payments: ${_this.payments}, status: ${_this.status}, writeOffAmount: ${_this.writeOffAmount}, writeOffReason: ${_this.writeOffReason}, writeOffSignatures: ${_this.writeOffSignatures}, collectionNote: ${_this.collectionNote})';
}


}

/// @nodoc
abstract mixin class $MarkerModelCopyWith<$Res>  {
  factory $MarkerModelCopyWith(MarkerModel value, $Res Function(MarkerModel) _then) = _$MarkerModelCopyWithImpl;
@useResult
$Res call({
 String id, String playerId, String number, String table, String issuedBy, double amount, DateTime issuedAt, List<MarkerPaymentModel> payments, String status, double writeOffAmount, String writeOffReason, List<SignatureModel> writeOffSignatures, String collectionNote
});




}
/// @nodoc
class _$MarkerModelCopyWithImpl<$Res>
    implements $MarkerModelCopyWith<$Res> {
  _$MarkerModelCopyWithImpl(this._self, this._then);

  final MarkerModel _self;
  final $Res Function(MarkerModel) _then;

/// Create a copy of MarkerModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? playerId = null,Object? number = null,Object? table = null,Object? issuedBy = null,Object? amount = null,Object? issuedAt = null,Object? payments = null,Object? status = null,Object? writeOffAmount = null,Object? writeOffReason = null,Object? writeOffSignatures = null,Object? collectionNote = null,}) {
  return _then(MarkerModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as String,table: null == table ? _self.table : table // ignore: cast_nullable_to_non_nullable
as String,issuedBy: null == issuedBy ? _self.issuedBy : issuedBy // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,issuedAt: null == issuedAt ? _self.issuedAt : issuedAt // ignore: cast_nullable_to_non_nullable
as DateTime,payments: null == payments ? _self.payments : payments // ignore: cast_nullable_to_non_nullable
as List<MarkerPaymentModel>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,writeOffAmount: null == writeOffAmount ? _self.writeOffAmount : writeOffAmount // ignore: cast_nullable_to_non_nullable
as double,writeOffReason: null == writeOffReason ? _self.writeOffReason : writeOffReason // ignore: cast_nullable_to_non_nullable
as String,writeOffSignatures: null == writeOffSignatures ? _self.writeOffSignatures : writeOffSignatures // ignore: cast_nullable_to_non_nullable
as List<SignatureModel>,collectionNote: null == collectionNote ? _self.collectionNote : collectionNote // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MarkerModel].
extension MarkerModelPatterns on MarkerModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MarkerModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MarkerModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MarkerModel value)  $default,){
final _that = this;
switch (_that) {
case _MarkerModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MarkerModel value)?  $default,){
final _that = this;
switch (_that) {
case _MarkerModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String playerId,  String number,  String table,  String issuedBy,  double amount,  DateTime issuedAt,  List<MarkerPaymentModel> payments,  String status,  double writeOffAmount,  String writeOffReason,  List<SignatureModel> writeOffSignatures,  String collectionNote)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MarkerModel() when $default != null:
return $default(_that.id,_that.playerId,_that.number,_that.table,_that.issuedBy,_that.amount,_that.issuedAt,_that.payments,_that.status,_that.writeOffAmount,_that.writeOffReason,_that.writeOffSignatures,_that.collectionNote);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String playerId,  String number,  String table,  String issuedBy,  double amount,  DateTime issuedAt,  List<MarkerPaymentModel> payments,  String status,  double writeOffAmount,  String writeOffReason,  List<SignatureModel> writeOffSignatures,  String collectionNote)  $default,) {final _that = this;
switch (_that) {
case _MarkerModel():
return $default(_that.id,_that.playerId,_that.number,_that.table,_that.issuedBy,_that.amount,_that.issuedAt,_that.payments,_that.status,_that.writeOffAmount,_that.writeOffReason,_that.writeOffSignatures,_that.collectionNote);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String playerId,  String number,  String table,  String issuedBy,  double amount,  DateTime issuedAt,  List<MarkerPaymentModel> payments,  String status,  double writeOffAmount,  String writeOffReason,  List<SignatureModel> writeOffSignatures,  String collectionNote)?  $default,) {final _that = this;
switch (_that) {
case _MarkerModel() when $default != null:
return $default(_that.id,_that.playerId,_that.number,_that.table,_that.issuedBy,_that.amount,_that.issuedAt,_that.payments,_that.status,_that.writeOffAmount,_that.writeOffReason,_that.writeOffSignatures,_that.collectionNote);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MarkerModel extends MarkerModel {
  const _MarkerModel({required this.id, this.playerId = '', this.number = '', this.table = '', this.issuedBy = '', this.amount = 0, required this.issuedAt,  List<MarkerPaymentModel> payments = const <MarkerPaymentModel>[], this.status = 'open', this.writeOffAmount = 0, this.writeOffReason = '',  List<SignatureModel> writeOffSignatures = const <SignatureModel>[], this.collectionNote = ''}): _payments = payments,_writeOffSignatures = writeOffSignatures,super._();
  factory _MarkerModel.fromJson(Map<String, dynamic> json) => _$MarkerModelFromJson(json);

@override final  String id;
@override@JsonKey() final  String playerId;
@override@JsonKey() final  String number;
@override@JsonKey() final  String table;
@override@JsonKey() final  String issuedBy;
@override@JsonKey() final  double amount;
@override final  DateTime issuedAt;
 final  List<MarkerPaymentModel> _payments;
@override@JsonKey() List<MarkerPaymentModel> get payments {
  if (_payments is EqualUnmodifiableListView) return _payments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_payments);
}

@override@JsonKey() final  String status;
@override@JsonKey() final  double writeOffAmount;
@override@JsonKey() final  String writeOffReason;
 final  List<SignatureModel> _writeOffSignatures;
@override@JsonKey() List<SignatureModel> get writeOffSignatures {
  if (_writeOffSignatures is EqualUnmodifiableListView) return _writeOffSignatures;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_writeOffSignatures);
}

@override@JsonKey() final  String collectionNote;

/// Create a copy of MarkerModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MarkerModelCopyWith<_MarkerModel> get copyWith => __$MarkerModelCopyWithImpl<_MarkerModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MarkerModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MarkerModel&&(identical(other.id, id) || other.id == id)&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.number, number) || other.number == number)&&(identical(other.table, table) || other.table == table)&&(identical(other.issuedBy, issuedBy) || other.issuedBy == issuedBy)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.issuedAt, issuedAt) || other.issuedAt == issuedAt)&&const DeepCollectionEquality().equals(other.payments, _payments)&&(identical(other.status, status) || other.status == status)&&(identical(other.writeOffAmount, writeOffAmount) || other.writeOffAmount == writeOffAmount)&&(identical(other.writeOffReason, writeOffReason) || other.writeOffReason == writeOffReason)&&const DeepCollectionEquality().equals(other.writeOffSignatures, _writeOffSignatures)&&(identical(other.collectionNote, collectionNote) || other.collectionNote == collectionNote));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,playerId,number,table,issuedBy,amount,issuedAt,const DeepCollectionEquality().hash(_payments),status,writeOffAmount,writeOffReason,const DeepCollectionEquality().hash(_writeOffSignatures),collectionNote);
}

@override
String toString() {
    return 'MarkerModel(id: $id, playerId: $playerId, number: $number, table: $table, issuedBy: $issuedBy, amount: $amount, issuedAt: $issuedAt, payments: $payments, status: $status, writeOffAmount: $writeOffAmount, writeOffReason: $writeOffReason, writeOffSignatures: $writeOffSignatures, collectionNote: $collectionNote)';
}


}

/// @nodoc
abstract mixin class _$MarkerModelCopyWith<$Res> implements $MarkerModelCopyWith<$Res> {
  factory _$MarkerModelCopyWith(_MarkerModel value, $Res Function(_MarkerModel) _then) = __$MarkerModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String playerId, String number, String table, String issuedBy, double amount, DateTime issuedAt, List<MarkerPaymentModel> payments, String status, double writeOffAmount, String writeOffReason, List<SignatureModel> writeOffSignatures, String collectionNote
});




}
/// @nodoc
class __$MarkerModelCopyWithImpl<$Res>
    implements _$MarkerModelCopyWith<$Res> {
  __$MarkerModelCopyWithImpl(this._self, this._then);

  final _MarkerModel _self;
  final $Res Function(_MarkerModel) _then;

/// Create a copy of MarkerModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? playerId = null,Object? number = null,Object? table = null,Object? issuedBy = null,Object? amount = null,Object? issuedAt = null,Object? payments = null,Object? status = null,Object? writeOffAmount = null,Object? writeOffReason = null,Object? writeOffSignatures = null,Object? collectionNote = null,}) {
  return _then(_MarkerModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as String,table: null == table ? _self.table : table // ignore: cast_nullable_to_non_nullable
as String,issuedBy: null == issuedBy ? _self.issuedBy : issuedBy // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,issuedAt: null == issuedAt ? _self.issuedAt : issuedAt // ignore: cast_nullable_to_non_nullable
as DateTime,payments: null == payments ? _self._payments : payments // ignore: cast_nullable_to_non_nullable
as List<MarkerPaymentModel>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,writeOffAmount: null == writeOffAmount ? _self.writeOffAmount : writeOffAmount // ignore: cast_nullable_to_non_nullable
as double,writeOffReason: null == writeOffReason ? _self.writeOffReason : writeOffReason // ignore: cast_nullable_to_non_nullable
as String,writeOffSignatures: null == writeOffSignatures ? _self._writeOffSignatures : writeOffSignatures // ignore: cast_nullable_to_non_nullable
as List<SignatureModel>,collectionNote: null == collectionNote ? _self.collectionNote : collectionNote // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
