// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'compliance_entities.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CashTxRecord {

 String get id;/// Player id, or `desc:<description>` for an unidentified patron.
 String get patronKey; String get patronLabel; String get area; String get recordedBy; CashTxType get type; double get amount; DateTime get at;/// Continuous appearance at one location (single-visit rule, p.71).
 String? get visitId;
/// Create a copy of CashTxRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CashTxRecordCopyWith<CashTxRecord> get copyWith => _$CashTxRecordCopyWithImpl<CashTxRecord>(this as CashTxRecord, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CashTxRecord;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CashTxRecord&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.patronKey, _this.patronKey) || other.patronKey == _this.patronKey)&&(identical(other.patronLabel, _this.patronLabel) || other.patronLabel == _this.patronLabel)&&(identical(other.area, _this.area) || other.area == _this.area)&&(identical(other.recordedBy, _this.recordedBy) || other.recordedBy == _this.recordedBy)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.amount, _this.amount) || other.amount == _this.amount)&&(identical(other.at, _this.at) || other.at == _this.at)&&(identical(other.visitId, _this.visitId) || other.visitId == _this.visitId));
}


@override
int get hashCode {
  final _this = this as CashTxRecord;
  return Object.hash(runtimeType,_this.id,_this.patronKey,_this.patronLabel,_this.area,_this.recordedBy,_this.type,_this.amount,_this.at,_this.visitId);
}

@override
String toString() {
  final _this = this as CashTxRecord;
  return 'CashTxRecord(id: ${_this.id}, patronKey: ${_this.patronKey}, patronLabel: ${_this.patronLabel}, area: ${_this.area}, recordedBy: ${_this.recordedBy}, type: ${_this.type}, amount: ${_this.amount}, at: ${_this.at}, visitId: ${_this.visitId})';
}


}

/// @nodoc
abstract mixin class $CashTxRecordCopyWith<$Res>  {
  factory $CashTxRecordCopyWith(CashTxRecord value, $Res Function(CashTxRecord) _then) = _$CashTxRecordCopyWithImpl;
@useResult
$Res call({
 String id, String patronKey, String patronLabel, String area, String recordedBy, CashTxType type, double amount, DateTime at, String? visitId
});




}
/// @nodoc
class _$CashTxRecordCopyWithImpl<$Res>
    implements $CashTxRecordCopyWith<$Res> {
  _$CashTxRecordCopyWithImpl(this._self, this._then);

  final CashTxRecord _self;
  final $Res Function(CashTxRecord) _then;

/// Create a copy of CashTxRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? patronKey = null,Object? patronLabel = null,Object? area = null,Object? recordedBy = null,Object? type = null,Object? amount = null,Object? at = null,Object? visitId = freezed,}) {
  return _then(CashTxRecord(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,patronKey: null == patronKey ? _self.patronKey : patronKey // ignore: cast_nullable_to_non_nullable
as String,patronLabel: null == patronLabel ? _self.patronLabel : patronLabel // ignore: cast_nullable_to_non_nullable
as String,area: null == area ? _self.area : area // ignore: cast_nullable_to_non_nullable
as String,recordedBy: null == recordedBy ? _self.recordedBy : recordedBy // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as CashTxType,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,at: null == at ? _self.at : at // ignore: cast_nullable_to_non_nullable
as DateTime,visitId: freezed == visitId ? _self.visitId : visitId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CashTxRecord].
extension CashTxRecordPatterns on CashTxRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CashTxRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CashTxRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CashTxRecord value)  $default,){
final _that = this;
switch (_that) {
case _CashTxRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CashTxRecord value)?  $default,){
final _that = this;
switch (_that) {
case _CashTxRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String patronKey,  String patronLabel,  String area,  String recordedBy,  CashTxType type,  double amount,  DateTime at,  String? visitId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CashTxRecord() when $default != null:
return $default(_that.id,_that.patronKey,_that.patronLabel,_that.area,_that.recordedBy,_that.type,_that.amount,_that.at,_that.visitId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String patronKey,  String patronLabel,  String area,  String recordedBy,  CashTxType type,  double amount,  DateTime at,  String? visitId)  $default,) {final _that = this;
switch (_that) {
case _CashTxRecord():
return $default(_that.id,_that.patronKey,_that.patronLabel,_that.area,_that.recordedBy,_that.type,_that.amount,_that.at,_that.visitId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String patronKey,  String patronLabel,  String area,  String recordedBy,  CashTxType type,  double amount,  DateTime at,  String? visitId)?  $default,) {final _that = this;
switch (_that) {
case _CashTxRecord() when $default != null:
return $default(_that.id,_that.patronKey,_that.patronLabel,_that.area,_that.recordedBy,_that.type,_that.amount,_that.at,_that.visitId);case _:
  return null;

}
}

}

/// @nodoc


class _CashTxRecord extends CashTxRecord {
  const _CashTxRecord({required this.id, required this.patronKey, required this.patronLabel, required this.area, required this.recordedBy, required this.type, required this.amount, required this.at, this.visitId}): super._();
  

@override final  String id;
/// Player id, or `desc:<description>` for an unidentified patron.
@override final  String patronKey;
@override final  String patronLabel;
@override final  String area;
@override final  String recordedBy;
@override final  CashTxType type;
@override final  double amount;
@override final  DateTime at;
/// Continuous appearance at one location (single-visit rule, p.71).
@override final  String? visitId;

/// Create a copy of CashTxRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CashTxRecordCopyWith<_CashTxRecord> get copyWith => __$CashTxRecordCopyWithImpl<_CashTxRecord>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CashTxRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.patronKey, patronKey) || other.patronKey == patronKey)&&(identical(other.patronLabel, patronLabel) || other.patronLabel == patronLabel)&&(identical(other.area, area) || other.area == area)&&(identical(other.recordedBy, recordedBy) || other.recordedBy == recordedBy)&&(identical(other.type, type) || other.type == type)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.at, at) || other.at == at)&&(identical(other.visitId, visitId) || other.visitId == visitId));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,patronKey,patronLabel,area,recordedBy,type,amount,at,visitId);
}

@override
String toString() {
    return 'CashTxRecord(id: $id, patronKey: $patronKey, patronLabel: $patronLabel, area: $area, recordedBy: $recordedBy, type: $type, amount: $amount, at: $at, visitId: $visitId)';
}


}

/// @nodoc
abstract mixin class _$CashTxRecordCopyWith<$Res> implements $CashTxRecordCopyWith<$Res> {
  factory _$CashTxRecordCopyWith(_CashTxRecord value, $Res Function(_CashTxRecord) _then) = __$CashTxRecordCopyWithImpl;
@override @useResult
$Res call({
 String id, String patronKey, String patronLabel, String area, String recordedBy, CashTxType type, double amount, DateTime at, String? visitId
});




}
/// @nodoc
class __$CashTxRecordCopyWithImpl<$Res>
    implements _$CashTxRecordCopyWith<$Res> {
  __$CashTxRecordCopyWithImpl(this._self, this._then);

  final _CashTxRecord _self;
  final $Res Function(_CashTxRecord) _then;

/// Create a copy of CashTxRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? patronKey = null,Object? patronLabel = null,Object? area = null,Object? recordedBy = null,Object? type = null,Object? amount = null,Object? at = null,Object? visitId = freezed,}) {
  return _then(_CashTxRecord(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,patronKey: null == patronKey ? _self.patronKey : patronKey // ignore: cast_nullable_to_non_nullable
as String,patronLabel: null == patronLabel ? _self.patronLabel : patronLabel // ignore: cast_nullable_to_non_nullable
as String,area: null == area ? _self.area : area // ignore: cast_nullable_to_non_nullable
as String,recordedBy: null == recordedBy ? _self.recordedBy : recordedBy // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as CashTxType,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,at: null == at ? _self.at : at // ignore: cast_nullable_to_non_nullable
as DateTime,visitId: freezed == visitId ? _self.visitId : visitId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$CtrReport {

 String get id; String get patronKey; String get patronLabel; String get aggregateLabel; String get direction; DateTime get gamingDay; double get total; List<String> get txIds; Map<String, bool> get fields; CtrStatus get status; String get preparedBy; String get preparedById; String get reviewedBy; String get reviewedById; DateTime? get filedAt;
/// Create a copy of CtrReport
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CtrReportCopyWith<CtrReport> get copyWith => _$CtrReportCopyWithImpl<CtrReport>(this as CtrReport, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CtrReport;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CtrReport&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.patronKey, _this.patronKey) || other.patronKey == _this.patronKey)&&(identical(other.patronLabel, _this.patronLabel) || other.patronLabel == _this.patronLabel)&&(identical(other.aggregateLabel, _this.aggregateLabel) || other.aggregateLabel == _this.aggregateLabel)&&(identical(other.direction, _this.direction) || other.direction == _this.direction)&&(identical(other.gamingDay, _this.gamingDay) || other.gamingDay == _this.gamingDay)&&(identical(other.total, _this.total) || other.total == _this.total)&&const DeepCollectionEquality().equals(other.txIds, _this.txIds)&&const DeepCollectionEquality().equals(other.fields, _this.fields)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.preparedBy, _this.preparedBy) || other.preparedBy == _this.preparedBy)&&(identical(other.preparedById, _this.preparedById) || other.preparedById == _this.preparedById)&&(identical(other.reviewedBy, _this.reviewedBy) || other.reviewedBy == _this.reviewedBy)&&(identical(other.reviewedById, _this.reviewedById) || other.reviewedById == _this.reviewedById)&&(identical(other.filedAt, _this.filedAt) || other.filedAt == _this.filedAt));
}


@override
int get hashCode {
  final _this = this as CtrReport;
  return Object.hash(runtimeType,_this.id,_this.patronKey,_this.patronLabel,_this.aggregateLabel,_this.direction,_this.gamingDay,_this.total,const DeepCollectionEquality().hash(_this.txIds),const DeepCollectionEquality().hash(_this.fields),_this.status,_this.preparedBy,_this.preparedById,_this.reviewedBy,_this.reviewedById,_this.filedAt);
}

@override
String toString() {
  final _this = this as CtrReport;
  return 'CtrReport(id: ${_this.id}, patronKey: ${_this.patronKey}, patronLabel: ${_this.patronLabel}, aggregateLabel: ${_this.aggregateLabel}, direction: ${_this.direction}, gamingDay: ${_this.gamingDay}, total: ${_this.total}, txIds: ${_this.txIds}, fields: ${_this.fields}, status: ${_this.status}, preparedBy: ${_this.preparedBy}, preparedById: ${_this.preparedById}, reviewedBy: ${_this.reviewedBy}, reviewedById: ${_this.reviewedById}, filedAt: ${_this.filedAt})';
}


}

/// @nodoc
abstract mixin class $CtrReportCopyWith<$Res>  {
  factory $CtrReportCopyWith(CtrReport value, $Res Function(CtrReport) _then) = _$CtrReportCopyWithImpl;
@useResult
$Res call({
 String id, String patronKey, String patronLabel, String aggregateLabel, String direction, DateTime gamingDay, double total, List<String> txIds, Map<String, bool> fields, CtrStatus status, String preparedBy, String preparedById, String reviewedBy, String reviewedById, DateTime? filedAt
});




}
/// @nodoc
class _$CtrReportCopyWithImpl<$Res>
    implements $CtrReportCopyWith<$Res> {
  _$CtrReportCopyWithImpl(this._self, this._then);

  final CtrReport _self;
  final $Res Function(CtrReport) _then;

/// Create a copy of CtrReport
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? patronKey = null,Object? patronLabel = null,Object? aggregateLabel = null,Object? direction = null,Object? gamingDay = null,Object? total = null,Object? txIds = null,Object? fields = null,Object? status = null,Object? preparedBy = null,Object? preparedById = null,Object? reviewedBy = null,Object? reviewedById = null,Object? filedAt = freezed,}) {
  return _then(CtrReport(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,patronKey: null == patronKey ? _self.patronKey : patronKey // ignore: cast_nullable_to_non_nullable
as String,patronLabel: null == patronLabel ? _self.patronLabel : patronLabel // ignore: cast_nullable_to_non_nullable
as String,aggregateLabel: null == aggregateLabel ? _self.aggregateLabel : aggregateLabel // ignore: cast_nullable_to_non_nullable
as String,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as String,gamingDay: null == gamingDay ? _self.gamingDay : gamingDay // ignore: cast_nullable_to_non_nullable
as DateTime,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,txIds: null == txIds ? _self.txIds : txIds // ignore: cast_nullable_to_non_nullable
as List<String>,fields: null == fields ? _self.fields : fields // ignore: cast_nullable_to_non_nullable
as Map<String, bool>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CtrStatus,preparedBy: null == preparedBy ? _self.preparedBy : preparedBy // ignore: cast_nullable_to_non_nullable
as String,preparedById: null == preparedById ? _self.preparedById : preparedById // ignore: cast_nullable_to_non_nullable
as String,reviewedBy: null == reviewedBy ? _self.reviewedBy : reviewedBy // ignore: cast_nullable_to_non_nullable
as String,reviewedById: null == reviewedById ? _self.reviewedById : reviewedById // ignore: cast_nullable_to_non_nullable
as String,filedAt: freezed == filedAt ? _self.filedAt : filedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [CtrReport].
extension CtrReportPatterns on CtrReport {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CtrReport value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CtrReport() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CtrReport value)  $default,){
final _that = this;
switch (_that) {
case _CtrReport():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CtrReport value)?  $default,){
final _that = this;
switch (_that) {
case _CtrReport() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String patronKey,  String patronLabel,  String aggregateLabel,  String direction,  DateTime gamingDay,  double total,  List<String> txIds,  Map<String, bool> fields,  CtrStatus status,  String preparedBy,  String preparedById,  String reviewedBy,  String reviewedById,  DateTime? filedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CtrReport() when $default != null:
return $default(_that.id,_that.patronKey,_that.patronLabel,_that.aggregateLabel,_that.direction,_that.gamingDay,_that.total,_that.txIds,_that.fields,_that.status,_that.preparedBy,_that.preparedById,_that.reviewedBy,_that.reviewedById,_that.filedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String patronKey,  String patronLabel,  String aggregateLabel,  String direction,  DateTime gamingDay,  double total,  List<String> txIds,  Map<String, bool> fields,  CtrStatus status,  String preparedBy,  String preparedById,  String reviewedBy,  String reviewedById,  DateTime? filedAt)  $default,) {final _that = this;
switch (_that) {
case _CtrReport():
return $default(_that.id,_that.patronKey,_that.patronLabel,_that.aggregateLabel,_that.direction,_that.gamingDay,_that.total,_that.txIds,_that.fields,_that.status,_that.preparedBy,_that.preparedById,_that.reviewedBy,_that.reviewedById,_that.filedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String patronKey,  String patronLabel,  String aggregateLabel,  String direction,  DateTime gamingDay,  double total,  List<String> txIds,  Map<String, bool> fields,  CtrStatus status,  String preparedBy,  String preparedById,  String reviewedBy,  String reviewedById,  DateTime? filedAt)?  $default,) {final _that = this;
switch (_that) {
case _CtrReport() when $default != null:
return $default(_that.id,_that.patronKey,_that.patronLabel,_that.aggregateLabel,_that.direction,_that.gamingDay,_that.total,_that.txIds,_that.fields,_that.status,_that.preparedBy,_that.preparedById,_that.reviewedBy,_that.reviewedById,_that.filedAt);case _:
  return null;

}
}

}

/// @nodoc


class _CtrReport extends CtrReport {
  const _CtrReport({required this.id, required this.patronKey, required this.patronLabel, required this.aggregateLabel, required this.direction, required this.gamingDay, required this.total, required  List<String> txIds,  Map<String, bool> fields = const <String, bool>{}, this.status = CtrStatus.draft, this.preparedBy = '', this.preparedById = '', this.reviewedBy = '', this.reviewedById = '', this.filedAt}): _txIds = txIds,_fields = fields,super._();
  

@override final  String id;
@override final  String patronKey;
@override final  String patronLabel;
@override final  String aggregateLabel;
@override final  String direction;
@override final  DateTime gamingDay;
@override final  double total;
 final  List<String> _txIds;
@override List<String> get txIds {
  if (_txIds is EqualUnmodifiableListView) return _txIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_txIds);
}

 final  Map<String, bool> _fields;
@override@JsonKey() Map<String, bool> get fields {
  if (_fields is EqualUnmodifiableMapView) return _fields;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_fields);
}

@override@JsonKey() final  CtrStatus status;
@override@JsonKey() final  String preparedBy;
@override@JsonKey() final  String preparedById;
@override@JsonKey() final  String reviewedBy;
@override@JsonKey() final  String reviewedById;
@override final  DateTime? filedAt;

/// Create a copy of CtrReport
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CtrReportCopyWith<_CtrReport> get copyWith => __$CtrReportCopyWithImpl<_CtrReport>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CtrReport&&(identical(other.id, id) || other.id == id)&&(identical(other.patronKey, patronKey) || other.patronKey == patronKey)&&(identical(other.patronLabel, patronLabel) || other.patronLabel == patronLabel)&&(identical(other.aggregateLabel, aggregateLabel) || other.aggregateLabel == aggregateLabel)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.gamingDay, gamingDay) || other.gamingDay == gamingDay)&&(identical(other.total, total) || other.total == total)&&const DeepCollectionEquality().equals(other.txIds, _txIds)&&const DeepCollectionEquality().equals(other.fields, _fields)&&(identical(other.status, status) || other.status == status)&&(identical(other.preparedBy, preparedBy) || other.preparedBy == preparedBy)&&(identical(other.preparedById, preparedById) || other.preparedById == preparedById)&&(identical(other.reviewedBy, reviewedBy) || other.reviewedBy == reviewedBy)&&(identical(other.reviewedById, reviewedById) || other.reviewedById == reviewedById)&&(identical(other.filedAt, filedAt) || other.filedAt == filedAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,patronKey,patronLabel,aggregateLabel,direction,gamingDay,total,const DeepCollectionEquality().hash(_txIds),const DeepCollectionEquality().hash(_fields),status,preparedBy,preparedById,reviewedBy,reviewedById,filedAt);
}

@override
String toString() {
    return 'CtrReport(id: $id, patronKey: $patronKey, patronLabel: $patronLabel, aggregateLabel: $aggregateLabel, direction: $direction, gamingDay: $gamingDay, total: $total, txIds: $txIds, fields: $fields, status: $status, preparedBy: $preparedBy, preparedById: $preparedById, reviewedBy: $reviewedBy, reviewedById: $reviewedById, filedAt: $filedAt)';
}


}

/// @nodoc
abstract mixin class _$CtrReportCopyWith<$Res> implements $CtrReportCopyWith<$Res> {
  factory _$CtrReportCopyWith(_CtrReport value, $Res Function(_CtrReport) _then) = __$CtrReportCopyWithImpl;
@override @useResult
$Res call({
 String id, String patronKey, String patronLabel, String aggregateLabel, String direction, DateTime gamingDay, double total, List<String> txIds, Map<String, bool> fields, CtrStatus status, String preparedBy, String preparedById, String reviewedBy, String reviewedById, DateTime? filedAt
});




}
/// @nodoc
class __$CtrReportCopyWithImpl<$Res>
    implements _$CtrReportCopyWith<$Res> {
  __$CtrReportCopyWithImpl(this._self, this._then);

  final _CtrReport _self;
  final $Res Function(_CtrReport) _then;

/// Create a copy of CtrReport
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? patronKey = null,Object? patronLabel = null,Object? aggregateLabel = null,Object? direction = null,Object? gamingDay = null,Object? total = null,Object? txIds = null,Object? fields = null,Object? status = null,Object? preparedBy = null,Object? preparedById = null,Object? reviewedBy = null,Object? reviewedById = null,Object? filedAt = freezed,}) {
  return _then(_CtrReport(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,patronKey: null == patronKey ? _self.patronKey : patronKey // ignore: cast_nullable_to_non_nullable
as String,patronLabel: null == patronLabel ? _self.patronLabel : patronLabel // ignore: cast_nullable_to_non_nullable
as String,aggregateLabel: null == aggregateLabel ? _self.aggregateLabel : aggregateLabel // ignore: cast_nullable_to_non_nullable
as String,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as String,gamingDay: null == gamingDay ? _self.gamingDay : gamingDay // ignore: cast_nullable_to_non_nullable
as DateTime,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,txIds: null == txIds ? _self._txIds : txIds // ignore: cast_nullable_to_non_nullable
as List<String>,fields: null == fields ? _self._fields : fields // ignore: cast_nullable_to_non_nullable
as Map<String, bool>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CtrStatus,preparedBy: null == preparedBy ? _self.preparedBy : preparedBy // ignore: cast_nullable_to_non_nullable
as String,preparedById: null == preparedById ? _self.preparedById : preparedById // ignore: cast_nullable_to_non_nullable
as String,reviewedBy: null == reviewedBy ? _self.reviewedBy : reviewedBy // ignore: cast_nullable_to_non_nullable
as String,reviewedById: null == reviewedById ? _self.reviewedById : reviewedById // ignore: cast_nullable_to_non_nullable
as String,filedAt: freezed == filedAt ? _self.filedAt : filedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc
mixin _$BarredPatron {

 String get id; String get description; String get reason; String get playerId; String get addedBy; DateTime get since; bool get active;
/// Create a copy of BarredPatron
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BarredPatronCopyWith<BarredPatron> get copyWith => _$BarredPatronCopyWithImpl<BarredPatron>(this as BarredPatron, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as BarredPatron;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BarredPatron&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.reason, _this.reason) || other.reason == _this.reason)&&(identical(other.playerId, _this.playerId) || other.playerId == _this.playerId)&&(identical(other.addedBy, _this.addedBy) || other.addedBy == _this.addedBy)&&(identical(other.since, _this.since) || other.since == _this.since)&&(identical(other.active, _this.active) || other.active == _this.active));
}


@override
int get hashCode {
  final _this = this as BarredPatron;
  return Object.hash(runtimeType,_this.id,_this.description,_this.reason,_this.playerId,_this.addedBy,_this.since,_this.active);
}

@override
String toString() {
  final _this = this as BarredPatron;
  return 'BarredPatron(id: ${_this.id}, description: ${_this.description}, reason: ${_this.reason}, playerId: ${_this.playerId}, addedBy: ${_this.addedBy}, since: ${_this.since}, active: ${_this.active})';
}


}

/// @nodoc
abstract mixin class $BarredPatronCopyWith<$Res>  {
  factory $BarredPatronCopyWith(BarredPatron value, $Res Function(BarredPatron) _then) = _$BarredPatronCopyWithImpl;
@useResult
$Res call({
 String id, String description, String reason, String playerId, String addedBy, DateTime since, bool active
});




}
/// @nodoc
class _$BarredPatronCopyWithImpl<$Res>
    implements $BarredPatronCopyWith<$Res> {
  _$BarredPatronCopyWithImpl(this._self, this._then);

  final BarredPatron _self;
  final $Res Function(BarredPatron) _then;

/// Create a copy of BarredPatron
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? description = null,Object? reason = null,Object? playerId = null,Object? addedBy = null,Object? since = null,Object? active = null,}) {
  return _then(BarredPatron(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,addedBy: null == addedBy ? _self.addedBy : addedBy // ignore: cast_nullable_to_non_nullable
as String,since: null == since ? _self.since : since // ignore: cast_nullable_to_non_nullable
as DateTime,active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [BarredPatron].
extension BarredPatronPatterns on BarredPatron {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BarredPatron value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BarredPatron() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BarredPatron value)  $default,){
final _that = this;
switch (_that) {
case _BarredPatron():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BarredPatron value)?  $default,){
final _that = this;
switch (_that) {
case _BarredPatron() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String description,  String reason,  String playerId,  String addedBy,  DateTime since,  bool active)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BarredPatron() when $default != null:
return $default(_that.id,_that.description,_that.reason,_that.playerId,_that.addedBy,_that.since,_that.active);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String description,  String reason,  String playerId,  String addedBy,  DateTime since,  bool active)  $default,) {final _that = this;
switch (_that) {
case _BarredPatron():
return $default(_that.id,_that.description,_that.reason,_that.playerId,_that.addedBy,_that.since,_that.active);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String description,  String reason,  String playerId,  String addedBy,  DateTime since,  bool active)?  $default,) {final _that = this;
switch (_that) {
case _BarredPatron() when $default != null:
return $default(_that.id,_that.description,_that.reason,_that.playerId,_that.addedBy,_that.since,_that.active);case _:
  return null;

}
}

}

/// @nodoc


class _BarredPatron implements BarredPatron {
  const _BarredPatron({required this.id, required this.description, required this.reason, this.playerId = '', this.addedBy = '', required this.since, this.active = true});
  

@override final  String id;
@override final  String description;
@override final  String reason;
@override@JsonKey() final  String playerId;
@override@JsonKey() final  String addedBy;
@override final  DateTime since;
@override@JsonKey() final  bool active;

/// Create a copy of BarredPatron
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BarredPatronCopyWith<_BarredPatron> get copyWith => __$BarredPatronCopyWithImpl<_BarredPatron>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BarredPatron&&(identical(other.id, id) || other.id == id)&&(identical(other.description, description) || other.description == description)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.addedBy, addedBy) || other.addedBy == addedBy)&&(identical(other.since, since) || other.since == since)&&(identical(other.active, active) || other.active == active));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,description,reason,playerId,addedBy,since,active);
}

@override
String toString() {
    return 'BarredPatron(id: $id, description: $description, reason: $reason, playerId: $playerId, addedBy: $addedBy, since: $since, active: $active)';
}


}

/// @nodoc
abstract mixin class _$BarredPatronCopyWith<$Res> implements $BarredPatronCopyWith<$Res> {
  factory _$BarredPatronCopyWith(_BarredPatron value, $Res Function(_BarredPatron) _then) = __$BarredPatronCopyWithImpl;
@override @useResult
$Res call({
 String id, String description, String reason, String playerId, String addedBy, DateTime since, bool active
});




}
/// @nodoc
class __$BarredPatronCopyWithImpl<$Res>
    implements _$BarredPatronCopyWith<$Res> {
  __$BarredPatronCopyWithImpl(this._self, this._then);

  final _BarredPatron _self;
  final $Res Function(_BarredPatron) _then;

/// Create a copy of BarredPatron
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? description = null,Object? reason = null,Object? playerId = null,Object? addedBy = null,Object? since = null,Object? active = null,}) {
  return _then(_BarredPatron(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,addedBy: null == addedBy ? _self.addedBy : addedBy // ignore: cast_nullable_to_non_nullable
as String,since: null == since ? _self.since : since // ignore: cast_nullable_to_non_nullable
as DateTime,active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$SarCase {

 String get id; String get subject; String get summary; String get openedBy; double get amount; DateTime get detectedAt;/// +30 days when the subject is not yet identified.
 bool get extended; DateTime? get filedAt;
/// Create a copy of SarCase
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SarCaseCopyWith<SarCase> get copyWith => _$SarCaseCopyWithImpl<SarCase>(this as SarCase, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SarCase;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SarCase&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.subject, _this.subject) || other.subject == _this.subject)&&(identical(other.summary, _this.summary) || other.summary == _this.summary)&&(identical(other.openedBy, _this.openedBy) || other.openedBy == _this.openedBy)&&(identical(other.amount, _this.amount) || other.amount == _this.amount)&&(identical(other.detectedAt, _this.detectedAt) || other.detectedAt == _this.detectedAt)&&(identical(other.extended, _this.extended) || other.extended == _this.extended)&&(identical(other.filedAt, _this.filedAt) || other.filedAt == _this.filedAt));
}


@override
int get hashCode {
  final _this = this as SarCase;
  return Object.hash(runtimeType,_this.id,_this.subject,_this.summary,_this.openedBy,_this.amount,_this.detectedAt,_this.extended,_this.filedAt);
}

@override
String toString() {
  final _this = this as SarCase;
  return 'SarCase(id: ${_this.id}, subject: ${_this.subject}, summary: ${_this.summary}, openedBy: ${_this.openedBy}, amount: ${_this.amount}, detectedAt: ${_this.detectedAt}, extended: ${_this.extended}, filedAt: ${_this.filedAt})';
}


}

/// @nodoc
abstract mixin class $SarCaseCopyWith<$Res>  {
  factory $SarCaseCopyWith(SarCase value, $Res Function(SarCase) _then) = _$SarCaseCopyWithImpl;
@useResult
$Res call({
 String id, String subject, String summary, String openedBy, double amount, DateTime detectedAt, bool extended, DateTime? filedAt
});




}
/// @nodoc
class _$SarCaseCopyWithImpl<$Res>
    implements $SarCaseCopyWith<$Res> {
  _$SarCaseCopyWithImpl(this._self, this._then);

  final SarCase _self;
  final $Res Function(SarCase) _then;

/// Create a copy of SarCase
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? subject = null,Object? summary = null,Object? openedBy = null,Object? amount = null,Object? detectedAt = null,Object? extended = null,Object? filedAt = freezed,}) {
  return _then(SarCase(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,subject: null == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,openedBy: null == openedBy ? _self.openedBy : openedBy // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,detectedAt: null == detectedAt ? _self.detectedAt : detectedAt // ignore: cast_nullable_to_non_nullable
as DateTime,extended: null == extended ? _self.extended : extended // ignore: cast_nullable_to_non_nullable
as bool,filedAt: freezed == filedAt ? _self.filedAt : filedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [SarCase].
extension SarCasePatterns on SarCase {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SarCase value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SarCase() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SarCase value)  $default,){
final _that = this;
switch (_that) {
case _SarCase():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SarCase value)?  $default,){
final _that = this;
switch (_that) {
case _SarCase() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String subject,  String summary,  String openedBy,  double amount,  DateTime detectedAt,  bool extended,  DateTime? filedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SarCase() when $default != null:
return $default(_that.id,_that.subject,_that.summary,_that.openedBy,_that.amount,_that.detectedAt,_that.extended,_that.filedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String subject,  String summary,  String openedBy,  double amount,  DateTime detectedAt,  bool extended,  DateTime? filedAt)  $default,) {final _that = this;
switch (_that) {
case _SarCase():
return $default(_that.id,_that.subject,_that.summary,_that.openedBy,_that.amount,_that.detectedAt,_that.extended,_that.filedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String subject,  String summary,  String openedBy,  double amount,  DateTime detectedAt,  bool extended,  DateTime? filedAt)?  $default,) {final _that = this;
switch (_that) {
case _SarCase() when $default != null:
return $default(_that.id,_that.subject,_that.summary,_that.openedBy,_that.amount,_that.detectedAt,_that.extended,_that.filedAt);case _:
  return null;

}
}

}

/// @nodoc


class _SarCase extends SarCase {
  const _SarCase({required this.id, required this.subject, required this.summary, required this.openedBy, required this.amount, required this.detectedAt, this.extended = false, this.filedAt}): super._();
  

@override final  String id;
@override final  String subject;
@override final  String summary;
@override final  String openedBy;
@override final  double amount;
@override final  DateTime detectedAt;
/// +30 days when the subject is not yet identified.
@override@JsonKey() final  bool extended;
@override final  DateTime? filedAt;

/// Create a copy of SarCase
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SarCaseCopyWith<_SarCase> get copyWith => __$SarCaseCopyWithImpl<_SarCase>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SarCase&&(identical(other.id, id) || other.id == id)&&(identical(other.subject, subject) || other.subject == subject)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.openedBy, openedBy) || other.openedBy == openedBy)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.detectedAt, detectedAt) || other.detectedAt == detectedAt)&&(identical(other.extended, extended) || other.extended == extended)&&(identical(other.filedAt, filedAt) || other.filedAt == filedAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,subject,summary,openedBy,amount,detectedAt,extended,filedAt);
}

@override
String toString() {
    return 'SarCase(id: $id, subject: $subject, summary: $summary, openedBy: $openedBy, amount: $amount, detectedAt: $detectedAt, extended: $extended, filedAt: $filedAt)';
}


}

/// @nodoc
abstract mixin class _$SarCaseCopyWith<$Res> implements $SarCaseCopyWith<$Res> {
  factory _$SarCaseCopyWith(_SarCase value, $Res Function(_SarCase) _then) = __$SarCaseCopyWithImpl;
@override @useResult
$Res call({
 String id, String subject, String summary, String openedBy, double amount, DateTime detectedAt, bool extended, DateTime? filedAt
});




}
/// @nodoc
class __$SarCaseCopyWithImpl<$Res>
    implements _$SarCaseCopyWith<$Res> {
  __$SarCaseCopyWithImpl(this._self, this._then);

  final _SarCase _self;
  final $Res Function(_SarCase) _then;

/// Create a copy of SarCase
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? subject = null,Object? summary = null,Object? openedBy = null,Object? amount = null,Object? detectedAt = null,Object? extended = null,Object? filedAt = freezed,}) {
  return _then(_SarCase(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,subject: null == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,openedBy: null == openedBy ? _self.openedBy : openedBy // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,detectedAt: null == detectedAt ? _self.detectedAt : detectedAt // ignore: cast_nullable_to_non_nullable
as DateTime,extended: null == extended ? _self.extended : extended // ignore: cast_nullable_to_non_nullable
as bool,filedAt: freezed == filedAt ? _self.filedAt : filedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
