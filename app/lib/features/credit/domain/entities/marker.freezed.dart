// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'marker.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MarkerPayment {

 double get amount;/// Cash, Cheques (in pit), Check, Wire.
 String get method; String get recordedBy; DateTime get at;
/// Create a copy of MarkerPayment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MarkerPaymentCopyWith<MarkerPayment> get copyWith => _$MarkerPaymentCopyWithImpl<MarkerPayment>(this as MarkerPayment, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as MarkerPayment;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MarkerPayment&&(identical(other.amount, _this.amount) || other.amount == _this.amount)&&(identical(other.method, _this.method) || other.method == _this.method)&&(identical(other.recordedBy, _this.recordedBy) || other.recordedBy == _this.recordedBy)&&(identical(other.at, _this.at) || other.at == _this.at));
}


@override
int get hashCode {
  final _this = this as MarkerPayment;
  return Object.hash(runtimeType,_this.amount,_this.method,_this.recordedBy,_this.at);
}

@override
String toString() {
  final _this = this as MarkerPayment;
  return 'MarkerPayment(amount: ${_this.amount}, method: ${_this.method}, recordedBy: ${_this.recordedBy}, at: ${_this.at})';
}


}

/// @nodoc
abstract mixin class $MarkerPaymentCopyWith<$Res>  {
  factory $MarkerPaymentCopyWith(MarkerPayment value, $Res Function(MarkerPayment) _then) = _$MarkerPaymentCopyWithImpl;
@useResult
$Res call({
 double amount, String method, String recordedBy, DateTime at
});




}
/// @nodoc
class _$MarkerPaymentCopyWithImpl<$Res>
    implements $MarkerPaymentCopyWith<$Res> {
  _$MarkerPaymentCopyWithImpl(this._self, this._then);

  final MarkerPayment _self;
  final $Res Function(MarkerPayment) _then;

/// Create a copy of MarkerPayment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? amount = null,Object? method = null,Object? recordedBy = null,Object? at = null,}) {
  return _then(MarkerPayment(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,method: null == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as String,recordedBy: null == recordedBy ? _self.recordedBy : recordedBy // ignore: cast_nullable_to_non_nullable
as String,at: null == at ? _self.at : at // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [MarkerPayment].
extension MarkerPaymentPatterns on MarkerPayment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MarkerPayment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MarkerPayment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MarkerPayment value)  $default,){
final _that = this;
switch (_that) {
case _MarkerPayment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MarkerPayment value)?  $default,){
final _that = this;
switch (_that) {
case _MarkerPayment() when $default != null:
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
case _MarkerPayment() when $default != null:
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
case _MarkerPayment():
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
case _MarkerPayment() when $default != null:
return $default(_that.amount,_that.method,_that.recordedBy,_that.at);case _:
  return null;

}
}

}

/// @nodoc


class _MarkerPayment implements MarkerPayment {
  const _MarkerPayment({required this.amount, required this.method, required this.recordedBy, required this.at});
  

@override final  double amount;
/// Cash, Cheques (in pit), Check, Wire.
@override final  String method;
@override final  String recordedBy;
@override final  DateTime at;

/// Create a copy of MarkerPayment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MarkerPaymentCopyWith<_MarkerPayment> get copyWith => __$MarkerPaymentCopyWithImpl<_MarkerPayment>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MarkerPayment&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.method, method) || other.method == method)&&(identical(other.recordedBy, recordedBy) || other.recordedBy == recordedBy)&&(identical(other.at, at) || other.at == at));
}


@override
int get hashCode {
    return Object.hash(runtimeType,amount,method,recordedBy,at);
}

@override
String toString() {
    return 'MarkerPayment(amount: $amount, method: $method, recordedBy: $recordedBy, at: $at)';
}


}

/// @nodoc
abstract mixin class _$MarkerPaymentCopyWith<$Res> implements $MarkerPaymentCopyWith<$Res> {
  factory _$MarkerPaymentCopyWith(_MarkerPayment value, $Res Function(_MarkerPayment) _then) = __$MarkerPaymentCopyWithImpl;
@override @useResult
$Res call({
 double amount, String method, String recordedBy, DateTime at
});




}
/// @nodoc
class __$MarkerPaymentCopyWithImpl<$Res>
    implements _$MarkerPaymentCopyWith<$Res> {
  __$MarkerPaymentCopyWithImpl(this._self, this._then);

  final _MarkerPayment _self;
  final $Res Function(_MarkerPayment) _then;

/// Create a copy of MarkerPayment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? amount = null,Object? method = null,Object? recordedBy = null,Object? at = null,}) {
  return _then(_MarkerPayment(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,method: null == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as String,recordedBy: null == recordedBy ? _self.recordedBy : recordedBy // ignore: cast_nullable_to_non_nullable
as String,at: null == at ? _self.at : at // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

/// @nodoc
mixin _$Marker {

 String get id; String get playerId; String get number; String get table; String get issuedBy; double get amount; DateTime get issuedAt; List<MarkerPayment> get payments; MarkerStatus get status; double get writeOffAmount; String get writeOffReason; List<Signature> get writeOffSignatures; String get collectionNote;
/// Create a copy of Marker
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MarkerCopyWith<Marker> get copyWith => _$MarkerCopyWithImpl<Marker>(this as Marker, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Marker;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Marker&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.playerId, _this.playerId) || other.playerId == _this.playerId)&&(identical(other.number, _this.number) || other.number == _this.number)&&(identical(other.table, _this.table) || other.table == _this.table)&&(identical(other.issuedBy, _this.issuedBy) || other.issuedBy == _this.issuedBy)&&(identical(other.amount, _this.amount) || other.amount == _this.amount)&&(identical(other.issuedAt, _this.issuedAt) || other.issuedAt == _this.issuedAt)&&const DeepCollectionEquality().equals(other.payments, _this.payments)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.writeOffAmount, _this.writeOffAmount) || other.writeOffAmount == _this.writeOffAmount)&&(identical(other.writeOffReason, _this.writeOffReason) || other.writeOffReason == _this.writeOffReason)&&const DeepCollectionEquality().equals(other.writeOffSignatures, _this.writeOffSignatures)&&(identical(other.collectionNote, _this.collectionNote) || other.collectionNote == _this.collectionNote));
}


@override
int get hashCode {
  final _this = this as Marker;
  return Object.hash(runtimeType,_this.id,_this.playerId,_this.number,_this.table,_this.issuedBy,_this.amount,_this.issuedAt,const DeepCollectionEquality().hash(_this.payments),_this.status,_this.writeOffAmount,_this.writeOffReason,const DeepCollectionEquality().hash(_this.writeOffSignatures),_this.collectionNote);
}

@override
String toString() {
  final _this = this as Marker;
  return 'Marker(id: ${_this.id}, playerId: ${_this.playerId}, number: ${_this.number}, table: ${_this.table}, issuedBy: ${_this.issuedBy}, amount: ${_this.amount}, issuedAt: ${_this.issuedAt}, payments: ${_this.payments}, status: ${_this.status}, writeOffAmount: ${_this.writeOffAmount}, writeOffReason: ${_this.writeOffReason}, writeOffSignatures: ${_this.writeOffSignatures}, collectionNote: ${_this.collectionNote})';
}


}

/// @nodoc
abstract mixin class $MarkerCopyWith<$Res>  {
  factory $MarkerCopyWith(Marker value, $Res Function(Marker) _then) = _$MarkerCopyWithImpl;
@useResult
$Res call({
 String id, String playerId, String number, String table, String issuedBy, double amount, DateTime issuedAt, List<MarkerPayment> payments, MarkerStatus status, double writeOffAmount, String writeOffReason, List<Signature> writeOffSignatures, String collectionNote
});




}
/// @nodoc
class _$MarkerCopyWithImpl<$Res>
    implements $MarkerCopyWith<$Res> {
  _$MarkerCopyWithImpl(this._self, this._then);

  final Marker _self;
  final $Res Function(Marker) _then;

/// Create a copy of Marker
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? playerId = null,Object? number = null,Object? table = null,Object? issuedBy = null,Object? amount = null,Object? issuedAt = null,Object? payments = null,Object? status = null,Object? writeOffAmount = null,Object? writeOffReason = null,Object? writeOffSignatures = null,Object? collectionNote = null,}) {
  return _then(Marker(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as String,table: null == table ? _self.table : table // ignore: cast_nullable_to_non_nullable
as String,issuedBy: null == issuedBy ? _self.issuedBy : issuedBy // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,issuedAt: null == issuedAt ? _self.issuedAt : issuedAt // ignore: cast_nullable_to_non_nullable
as DateTime,payments: null == payments ? _self.payments : payments // ignore: cast_nullable_to_non_nullable
as List<MarkerPayment>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as MarkerStatus,writeOffAmount: null == writeOffAmount ? _self.writeOffAmount : writeOffAmount // ignore: cast_nullable_to_non_nullable
as double,writeOffReason: null == writeOffReason ? _self.writeOffReason : writeOffReason // ignore: cast_nullable_to_non_nullable
as String,writeOffSignatures: null == writeOffSignatures ? _self.writeOffSignatures : writeOffSignatures // ignore: cast_nullable_to_non_nullable
as List<Signature>,collectionNote: null == collectionNote ? _self.collectionNote : collectionNote // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Marker].
extension MarkerPatterns on Marker {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Marker value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Marker() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Marker value)  $default,){
final _that = this;
switch (_that) {
case _Marker():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Marker value)?  $default,){
final _that = this;
switch (_that) {
case _Marker() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String playerId,  String number,  String table,  String issuedBy,  double amount,  DateTime issuedAt,  List<MarkerPayment> payments,  MarkerStatus status,  double writeOffAmount,  String writeOffReason,  List<Signature> writeOffSignatures,  String collectionNote)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Marker() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String playerId,  String number,  String table,  String issuedBy,  double amount,  DateTime issuedAt,  List<MarkerPayment> payments,  MarkerStatus status,  double writeOffAmount,  String writeOffReason,  List<Signature> writeOffSignatures,  String collectionNote)  $default,) {final _that = this;
switch (_that) {
case _Marker():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String playerId,  String number,  String table,  String issuedBy,  double amount,  DateTime issuedAt,  List<MarkerPayment> payments,  MarkerStatus status,  double writeOffAmount,  String writeOffReason,  List<Signature> writeOffSignatures,  String collectionNote)?  $default,) {final _that = this;
switch (_that) {
case _Marker() when $default != null:
return $default(_that.id,_that.playerId,_that.number,_that.table,_that.issuedBy,_that.amount,_that.issuedAt,_that.payments,_that.status,_that.writeOffAmount,_that.writeOffReason,_that.writeOffSignatures,_that.collectionNote);case _:
  return null;

}
}

}

/// @nodoc


class _Marker extends Marker {
  const _Marker({required this.id, required this.playerId, required this.number, required this.table, required this.issuedBy, required this.amount, required this.issuedAt,  List<MarkerPayment> payments = const <MarkerPayment>[], this.status = MarkerStatus.open, this.writeOffAmount = 0, this.writeOffReason = '',  List<Signature> writeOffSignatures = const <Signature>[], this.collectionNote = ''}): _payments = payments,_writeOffSignatures = writeOffSignatures,super._();
  

@override final  String id;
@override final  String playerId;
@override final  String number;
@override final  String table;
@override final  String issuedBy;
@override final  double amount;
@override final  DateTime issuedAt;
 final  List<MarkerPayment> _payments;
@override@JsonKey() List<MarkerPayment> get payments {
  if (_payments is EqualUnmodifiableListView) return _payments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_payments);
}

@override@JsonKey() final  MarkerStatus status;
@override@JsonKey() final  double writeOffAmount;
@override@JsonKey() final  String writeOffReason;
 final  List<Signature> _writeOffSignatures;
@override@JsonKey() List<Signature> get writeOffSignatures {
  if (_writeOffSignatures is EqualUnmodifiableListView) return _writeOffSignatures;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_writeOffSignatures);
}

@override@JsonKey() final  String collectionNote;

/// Create a copy of Marker
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MarkerCopyWith<_Marker> get copyWith => __$MarkerCopyWithImpl<_Marker>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Marker&&(identical(other.id, id) || other.id == id)&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.number, number) || other.number == number)&&(identical(other.table, table) || other.table == table)&&(identical(other.issuedBy, issuedBy) || other.issuedBy == issuedBy)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.issuedAt, issuedAt) || other.issuedAt == issuedAt)&&const DeepCollectionEquality().equals(other.payments, _payments)&&(identical(other.status, status) || other.status == status)&&(identical(other.writeOffAmount, writeOffAmount) || other.writeOffAmount == writeOffAmount)&&(identical(other.writeOffReason, writeOffReason) || other.writeOffReason == writeOffReason)&&const DeepCollectionEquality().equals(other.writeOffSignatures, _writeOffSignatures)&&(identical(other.collectionNote, collectionNote) || other.collectionNote == collectionNote));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,playerId,number,table,issuedBy,amount,issuedAt,const DeepCollectionEquality().hash(_payments),status,writeOffAmount,writeOffReason,const DeepCollectionEquality().hash(_writeOffSignatures),collectionNote);
}

@override
String toString() {
    return 'Marker(id: $id, playerId: $playerId, number: $number, table: $table, issuedBy: $issuedBy, amount: $amount, issuedAt: $issuedAt, payments: $payments, status: $status, writeOffAmount: $writeOffAmount, writeOffReason: $writeOffReason, writeOffSignatures: $writeOffSignatures, collectionNote: $collectionNote)';
}


}

/// @nodoc
abstract mixin class _$MarkerCopyWith<$Res> implements $MarkerCopyWith<$Res> {
  factory _$MarkerCopyWith(_Marker value, $Res Function(_Marker) _then) = __$MarkerCopyWithImpl;
@override @useResult
$Res call({
 String id, String playerId, String number, String table, String issuedBy, double amount, DateTime issuedAt, List<MarkerPayment> payments, MarkerStatus status, double writeOffAmount, String writeOffReason, List<Signature> writeOffSignatures, String collectionNote
});




}
/// @nodoc
class __$MarkerCopyWithImpl<$Res>
    implements _$MarkerCopyWith<$Res> {
  __$MarkerCopyWithImpl(this._self, this._then);

  final _Marker _self;
  final $Res Function(_Marker) _then;

/// Create a copy of Marker
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? playerId = null,Object? number = null,Object? table = null,Object? issuedBy = null,Object? amount = null,Object? issuedAt = null,Object? payments = null,Object? status = null,Object? writeOffAmount = null,Object? writeOffReason = null,Object? writeOffSignatures = null,Object? collectionNote = null,}) {
  return _then(_Marker(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as String,table: null == table ? _self.table : table // ignore: cast_nullable_to_non_nullable
as String,issuedBy: null == issuedBy ? _self.issuedBy : issuedBy // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,issuedAt: null == issuedAt ? _self.issuedAt : issuedAt // ignore: cast_nullable_to_non_nullable
as DateTime,payments: null == payments ? _self._payments : payments // ignore: cast_nullable_to_non_nullable
as List<MarkerPayment>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as MarkerStatus,writeOffAmount: null == writeOffAmount ? _self.writeOffAmount : writeOffAmount // ignore: cast_nullable_to_non_nullable
as double,writeOffReason: null == writeOffReason ? _self.writeOffReason : writeOffReason // ignore: cast_nullable_to_non_nullable
as String,writeOffSignatures: null == writeOffSignatures ? _self._writeOffSignatures : writeOffSignatures // ignore: cast_nullable_to_non_nullable
as List<Signature>,collectionNote: null == collectionNote ? _self.collectionNote : collectionNote // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
