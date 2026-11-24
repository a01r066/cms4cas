// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'compliance_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CashTxModel {

 String get id; String get patronKey; String get patronLabel; String get area; String get recordedBy; String get type; double get amount; DateTime get at; String? get visitId;
/// Create a copy of CashTxModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CashTxModelCopyWith<CashTxModel> get copyWith => _$CashTxModelCopyWithImpl<CashTxModel>(this as CashTxModel, _$identity);

  /// Serializes this CashTxModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CashTxModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CashTxModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.patronKey, _this.patronKey) || other.patronKey == _this.patronKey)&&(identical(other.patronLabel, _this.patronLabel) || other.patronLabel == _this.patronLabel)&&(identical(other.area, _this.area) || other.area == _this.area)&&(identical(other.recordedBy, _this.recordedBy) || other.recordedBy == _this.recordedBy)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.amount, _this.amount) || other.amount == _this.amount)&&(identical(other.at, _this.at) || other.at == _this.at)&&(identical(other.visitId, _this.visitId) || other.visitId == _this.visitId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CashTxModel;
  return Object.hash(runtimeType,_this.id,_this.patronKey,_this.patronLabel,_this.area,_this.recordedBy,_this.type,_this.amount,_this.at,_this.visitId);
}

@override
String toString() {
  final _this = this as CashTxModel;
  return 'CashTxModel(id: ${_this.id}, patronKey: ${_this.patronKey}, patronLabel: ${_this.patronLabel}, area: ${_this.area}, recordedBy: ${_this.recordedBy}, type: ${_this.type}, amount: ${_this.amount}, at: ${_this.at}, visitId: ${_this.visitId})';
}


}

/// @nodoc
abstract mixin class $CashTxModelCopyWith<$Res>  {
  factory $CashTxModelCopyWith(CashTxModel value, $Res Function(CashTxModel) _then) = _$CashTxModelCopyWithImpl;
@useResult
$Res call({
 String id, String patronKey, String patronLabel, String area, String recordedBy, String type, double amount, DateTime at, String? visitId
});




}
/// @nodoc
class _$CashTxModelCopyWithImpl<$Res>
    implements $CashTxModelCopyWith<$Res> {
  _$CashTxModelCopyWithImpl(this._self, this._then);

  final CashTxModel _self;
  final $Res Function(CashTxModel) _then;

/// Create a copy of CashTxModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? patronKey = null,Object? patronLabel = null,Object? area = null,Object? recordedBy = null,Object? type = null,Object? amount = null,Object? at = null,Object? visitId = freezed,}) {
  return _then(CashTxModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,patronKey: null == patronKey ? _self.patronKey : patronKey // ignore: cast_nullable_to_non_nullable
as String,patronLabel: null == patronLabel ? _self.patronLabel : patronLabel // ignore: cast_nullable_to_non_nullable
as String,area: null == area ? _self.area : area // ignore: cast_nullable_to_non_nullable
as String,recordedBy: null == recordedBy ? _self.recordedBy : recordedBy // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,at: null == at ? _self.at : at // ignore: cast_nullable_to_non_nullable
as DateTime,visitId: freezed == visitId ? _self.visitId : visitId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CashTxModel].
extension CashTxModelPatterns on CashTxModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CashTxModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CashTxModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CashTxModel value)  $default,){
final _that = this;
switch (_that) {
case _CashTxModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CashTxModel value)?  $default,){
final _that = this;
switch (_that) {
case _CashTxModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String patronKey,  String patronLabel,  String area,  String recordedBy,  String type,  double amount,  DateTime at,  String? visitId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CashTxModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String patronKey,  String patronLabel,  String area,  String recordedBy,  String type,  double amount,  DateTime at,  String? visitId)  $default,) {final _that = this;
switch (_that) {
case _CashTxModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String patronKey,  String patronLabel,  String area,  String recordedBy,  String type,  double amount,  DateTime at,  String? visitId)?  $default,) {final _that = this;
switch (_that) {
case _CashTxModel() when $default != null:
return $default(_that.id,_that.patronKey,_that.patronLabel,_that.area,_that.recordedBy,_that.type,_that.amount,_that.at,_that.visitId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CashTxModel extends CashTxModel {
  const _CashTxModel({required this.id, this.patronKey = '', this.patronLabel = '', this.area = '', this.recordedBy = '', this.type = '', this.amount = 0, required this.at, this.visitId}): super._();
  factory _CashTxModel.fromJson(Map<String, dynamic> json) => _$CashTxModelFromJson(json);

@override final  String id;
@override@JsonKey() final  String patronKey;
@override@JsonKey() final  String patronLabel;
@override@JsonKey() final  String area;
@override@JsonKey() final  String recordedBy;
@override@JsonKey() final  String type;
@override@JsonKey() final  double amount;
@override final  DateTime at;
@override final  String? visitId;

/// Create a copy of CashTxModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CashTxModelCopyWith<_CashTxModel> get copyWith => __$CashTxModelCopyWithImpl<_CashTxModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CashTxModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CashTxModel&&(identical(other.id, id) || other.id == id)&&(identical(other.patronKey, patronKey) || other.patronKey == patronKey)&&(identical(other.patronLabel, patronLabel) || other.patronLabel == patronLabel)&&(identical(other.area, area) || other.area == area)&&(identical(other.recordedBy, recordedBy) || other.recordedBy == recordedBy)&&(identical(other.type, type) || other.type == type)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.at, at) || other.at == at)&&(identical(other.visitId, visitId) || other.visitId == visitId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,patronKey,patronLabel,area,recordedBy,type,amount,at,visitId);
}

@override
String toString() {
    return 'CashTxModel(id: $id, patronKey: $patronKey, patronLabel: $patronLabel, area: $area, recordedBy: $recordedBy, type: $type, amount: $amount, at: $at, visitId: $visitId)';
}


}

/// @nodoc
abstract mixin class _$CashTxModelCopyWith<$Res> implements $CashTxModelCopyWith<$Res> {
  factory _$CashTxModelCopyWith(_CashTxModel value, $Res Function(_CashTxModel) _then) = __$CashTxModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String patronKey, String patronLabel, String area, String recordedBy, String type, double amount, DateTime at, String? visitId
});




}
/// @nodoc
class __$CashTxModelCopyWithImpl<$Res>
    implements _$CashTxModelCopyWith<$Res> {
  __$CashTxModelCopyWithImpl(this._self, this._then);

  final _CashTxModel _self;
  final $Res Function(_CashTxModel) _then;

/// Create a copy of CashTxModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? patronKey = null,Object? patronLabel = null,Object? area = null,Object? recordedBy = null,Object? type = null,Object? amount = null,Object? at = null,Object? visitId = freezed,}) {
  return _then(_CashTxModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,patronKey: null == patronKey ? _self.patronKey : patronKey // ignore: cast_nullable_to_non_nullable
as String,patronLabel: null == patronLabel ? _self.patronLabel : patronLabel // ignore: cast_nullable_to_non_nullable
as String,area: null == area ? _self.area : area // ignore: cast_nullable_to_non_nullable
as String,recordedBy: null == recordedBy ? _self.recordedBy : recordedBy // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,at: null == at ? _self.at : at // ignore: cast_nullable_to_non_nullable
as DateTime,visitId: freezed == visitId ? _self.visitId : visitId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$CtrReportModel {

 String get id; String get patronKey; String get patronLabel; String get aggregateLabel; String get direction; DateTime get gamingDay; double get total; List<String> get txIds; Map<String, bool> get fields; String get status; String get preparedBy; String get preparedById; String get reviewedBy; String get reviewedById; DateTime? get filedAt;
/// Create a copy of CtrReportModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CtrReportModelCopyWith<CtrReportModel> get copyWith => _$CtrReportModelCopyWithImpl<CtrReportModel>(this as CtrReportModel, _$identity);

  /// Serializes this CtrReportModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CtrReportModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CtrReportModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.patronKey, _this.patronKey) || other.patronKey == _this.patronKey)&&(identical(other.patronLabel, _this.patronLabel) || other.patronLabel == _this.patronLabel)&&(identical(other.aggregateLabel, _this.aggregateLabel) || other.aggregateLabel == _this.aggregateLabel)&&(identical(other.direction, _this.direction) || other.direction == _this.direction)&&(identical(other.gamingDay, _this.gamingDay) || other.gamingDay == _this.gamingDay)&&(identical(other.total, _this.total) || other.total == _this.total)&&const DeepCollectionEquality().equals(other.txIds, _this.txIds)&&const DeepCollectionEquality().equals(other.fields, _this.fields)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.preparedBy, _this.preparedBy) || other.preparedBy == _this.preparedBy)&&(identical(other.preparedById, _this.preparedById) || other.preparedById == _this.preparedById)&&(identical(other.reviewedBy, _this.reviewedBy) || other.reviewedBy == _this.reviewedBy)&&(identical(other.reviewedById, _this.reviewedById) || other.reviewedById == _this.reviewedById)&&(identical(other.filedAt, _this.filedAt) || other.filedAt == _this.filedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CtrReportModel;
  return Object.hash(runtimeType,_this.id,_this.patronKey,_this.patronLabel,_this.aggregateLabel,_this.direction,_this.gamingDay,_this.total,const DeepCollectionEquality().hash(_this.txIds),const DeepCollectionEquality().hash(_this.fields),_this.status,_this.preparedBy,_this.preparedById,_this.reviewedBy,_this.reviewedById,_this.filedAt);
}

@override
String toString() {
  final _this = this as CtrReportModel;
  return 'CtrReportModel(id: ${_this.id}, patronKey: ${_this.patronKey}, patronLabel: ${_this.patronLabel}, aggregateLabel: ${_this.aggregateLabel}, direction: ${_this.direction}, gamingDay: ${_this.gamingDay}, total: ${_this.total}, txIds: ${_this.txIds}, fields: ${_this.fields}, status: ${_this.status}, preparedBy: ${_this.preparedBy}, preparedById: ${_this.preparedById}, reviewedBy: ${_this.reviewedBy}, reviewedById: ${_this.reviewedById}, filedAt: ${_this.filedAt})';
}


}

/// @nodoc
abstract mixin class $CtrReportModelCopyWith<$Res>  {
  factory $CtrReportModelCopyWith(CtrReportModel value, $Res Function(CtrReportModel) _then) = _$CtrReportModelCopyWithImpl;
@useResult
$Res call({
 String id, String patronKey, String patronLabel, String aggregateLabel, String direction, DateTime gamingDay, double total, List<String> txIds, Map<String, bool> fields, String status, String preparedBy, String preparedById, String reviewedBy, String reviewedById, DateTime? filedAt
});




}
/// @nodoc
class _$CtrReportModelCopyWithImpl<$Res>
    implements $CtrReportModelCopyWith<$Res> {
  _$CtrReportModelCopyWithImpl(this._self, this._then);

  final CtrReportModel _self;
  final $Res Function(CtrReportModel) _then;

/// Create a copy of CtrReportModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? patronKey = null,Object? patronLabel = null,Object? aggregateLabel = null,Object? direction = null,Object? gamingDay = null,Object? total = null,Object? txIds = null,Object? fields = null,Object? status = null,Object? preparedBy = null,Object? preparedById = null,Object? reviewedBy = null,Object? reviewedById = null,Object? filedAt = freezed,}) {
  return _then(CtrReportModel(
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
as String,preparedBy: null == preparedBy ? _self.preparedBy : preparedBy // ignore: cast_nullable_to_non_nullable
as String,preparedById: null == preparedById ? _self.preparedById : preparedById // ignore: cast_nullable_to_non_nullable
as String,reviewedBy: null == reviewedBy ? _self.reviewedBy : reviewedBy // ignore: cast_nullable_to_non_nullable
as String,reviewedById: null == reviewedById ? _self.reviewedById : reviewedById // ignore: cast_nullable_to_non_nullable
as String,filedAt: freezed == filedAt ? _self.filedAt : filedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [CtrReportModel].
extension CtrReportModelPatterns on CtrReportModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CtrReportModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CtrReportModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CtrReportModel value)  $default,){
final _that = this;
switch (_that) {
case _CtrReportModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CtrReportModel value)?  $default,){
final _that = this;
switch (_that) {
case _CtrReportModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String patronKey,  String patronLabel,  String aggregateLabel,  String direction,  DateTime gamingDay,  double total,  List<String> txIds,  Map<String, bool> fields,  String status,  String preparedBy,  String preparedById,  String reviewedBy,  String reviewedById,  DateTime? filedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CtrReportModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String patronKey,  String patronLabel,  String aggregateLabel,  String direction,  DateTime gamingDay,  double total,  List<String> txIds,  Map<String, bool> fields,  String status,  String preparedBy,  String preparedById,  String reviewedBy,  String reviewedById,  DateTime? filedAt)  $default,) {final _that = this;
switch (_that) {
case _CtrReportModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String patronKey,  String patronLabel,  String aggregateLabel,  String direction,  DateTime gamingDay,  double total,  List<String> txIds,  Map<String, bool> fields,  String status,  String preparedBy,  String preparedById,  String reviewedBy,  String reviewedById,  DateTime? filedAt)?  $default,) {final _that = this;
switch (_that) {
case _CtrReportModel() when $default != null:
return $default(_that.id,_that.patronKey,_that.patronLabel,_that.aggregateLabel,_that.direction,_that.gamingDay,_that.total,_that.txIds,_that.fields,_that.status,_that.preparedBy,_that.preparedById,_that.reviewedBy,_that.reviewedById,_that.filedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CtrReportModel extends CtrReportModel {
  const _CtrReportModel({required this.id, this.patronKey = '', this.patronLabel = '', this.aggregateLabel = '', this.direction = '', required this.gamingDay, this.total = 0,  List<String> txIds = const <String>[],  Map<String, bool> fields = const <String, bool>{}, this.status = 'draft', this.preparedBy = '', this.preparedById = '', this.reviewedBy = '', this.reviewedById = '', this.filedAt}): _txIds = txIds,_fields = fields,super._();
  factory _CtrReportModel.fromJson(Map<String, dynamic> json) => _$CtrReportModelFromJson(json);

@override final  String id;
@override@JsonKey() final  String patronKey;
@override@JsonKey() final  String patronLabel;
@override@JsonKey() final  String aggregateLabel;
@override@JsonKey() final  String direction;
@override final  DateTime gamingDay;
@override@JsonKey() final  double total;
 final  List<String> _txIds;
@override@JsonKey() List<String> get txIds {
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

@override@JsonKey() final  String status;
@override@JsonKey() final  String preparedBy;
@override@JsonKey() final  String preparedById;
@override@JsonKey() final  String reviewedBy;
@override@JsonKey() final  String reviewedById;
@override final  DateTime? filedAt;

/// Create a copy of CtrReportModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CtrReportModelCopyWith<_CtrReportModel> get copyWith => __$CtrReportModelCopyWithImpl<_CtrReportModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CtrReportModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CtrReportModel&&(identical(other.id, id) || other.id == id)&&(identical(other.patronKey, patronKey) || other.patronKey == patronKey)&&(identical(other.patronLabel, patronLabel) || other.patronLabel == patronLabel)&&(identical(other.aggregateLabel, aggregateLabel) || other.aggregateLabel == aggregateLabel)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.gamingDay, gamingDay) || other.gamingDay == gamingDay)&&(identical(other.total, total) || other.total == total)&&const DeepCollectionEquality().equals(other.txIds, _txIds)&&const DeepCollectionEquality().equals(other.fields, _fields)&&(identical(other.status, status) || other.status == status)&&(identical(other.preparedBy, preparedBy) || other.preparedBy == preparedBy)&&(identical(other.preparedById, preparedById) || other.preparedById == preparedById)&&(identical(other.reviewedBy, reviewedBy) || other.reviewedBy == reviewedBy)&&(identical(other.reviewedById, reviewedById) || other.reviewedById == reviewedById)&&(identical(other.filedAt, filedAt) || other.filedAt == filedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,patronKey,patronLabel,aggregateLabel,direction,gamingDay,total,const DeepCollectionEquality().hash(_txIds),const DeepCollectionEquality().hash(_fields),status,preparedBy,preparedById,reviewedBy,reviewedById,filedAt);
}

@override
String toString() {
    return 'CtrReportModel(id: $id, patronKey: $patronKey, patronLabel: $patronLabel, aggregateLabel: $aggregateLabel, direction: $direction, gamingDay: $gamingDay, total: $total, txIds: $txIds, fields: $fields, status: $status, preparedBy: $preparedBy, preparedById: $preparedById, reviewedBy: $reviewedBy, reviewedById: $reviewedById, filedAt: $filedAt)';
}


}

/// @nodoc
abstract mixin class _$CtrReportModelCopyWith<$Res> implements $CtrReportModelCopyWith<$Res> {
  factory _$CtrReportModelCopyWith(_CtrReportModel value, $Res Function(_CtrReportModel) _then) = __$CtrReportModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String patronKey, String patronLabel, String aggregateLabel, String direction, DateTime gamingDay, double total, List<String> txIds, Map<String, bool> fields, String status, String preparedBy, String preparedById, String reviewedBy, String reviewedById, DateTime? filedAt
});




}
/// @nodoc
class __$CtrReportModelCopyWithImpl<$Res>
    implements _$CtrReportModelCopyWith<$Res> {
  __$CtrReportModelCopyWithImpl(this._self, this._then);

  final _CtrReportModel _self;
  final $Res Function(_CtrReportModel) _then;

/// Create a copy of CtrReportModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? patronKey = null,Object? patronLabel = null,Object? aggregateLabel = null,Object? direction = null,Object? gamingDay = null,Object? total = null,Object? txIds = null,Object? fields = null,Object? status = null,Object? preparedBy = null,Object? preparedById = null,Object? reviewedBy = null,Object? reviewedById = null,Object? filedAt = freezed,}) {
  return _then(_CtrReportModel(
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
as String,preparedBy: null == preparedBy ? _self.preparedBy : preparedBy // ignore: cast_nullable_to_non_nullable
as String,preparedById: null == preparedById ? _self.preparedById : preparedById // ignore: cast_nullable_to_non_nullable
as String,reviewedBy: null == reviewedBy ? _self.reviewedBy : reviewedBy // ignore: cast_nullable_to_non_nullable
as String,reviewedById: null == reviewedById ? _self.reviewedById : reviewedById // ignore: cast_nullable_to_non_nullable
as String,filedAt: freezed == filedAt ? _self.filedAt : filedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$BarredPatronModel {

 String get id; String get description; String get reason; String get playerId; String get addedBy; DateTime get since; bool get active;
/// Create a copy of BarredPatronModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BarredPatronModelCopyWith<BarredPatronModel> get copyWith => _$BarredPatronModelCopyWithImpl<BarredPatronModel>(this as BarredPatronModel, _$identity);

  /// Serializes this BarredPatronModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as BarredPatronModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BarredPatronModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.reason, _this.reason) || other.reason == _this.reason)&&(identical(other.playerId, _this.playerId) || other.playerId == _this.playerId)&&(identical(other.addedBy, _this.addedBy) || other.addedBy == _this.addedBy)&&(identical(other.since, _this.since) || other.since == _this.since)&&(identical(other.active, _this.active) || other.active == _this.active));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as BarredPatronModel;
  return Object.hash(runtimeType,_this.id,_this.description,_this.reason,_this.playerId,_this.addedBy,_this.since,_this.active);
}

@override
String toString() {
  final _this = this as BarredPatronModel;
  return 'BarredPatronModel(id: ${_this.id}, description: ${_this.description}, reason: ${_this.reason}, playerId: ${_this.playerId}, addedBy: ${_this.addedBy}, since: ${_this.since}, active: ${_this.active})';
}


}

/// @nodoc
abstract mixin class $BarredPatronModelCopyWith<$Res>  {
  factory $BarredPatronModelCopyWith(BarredPatronModel value, $Res Function(BarredPatronModel) _then) = _$BarredPatronModelCopyWithImpl;
@useResult
$Res call({
 String id, String description, String reason, String playerId, String addedBy, DateTime since, bool active
});




}
/// @nodoc
class _$BarredPatronModelCopyWithImpl<$Res>
    implements $BarredPatronModelCopyWith<$Res> {
  _$BarredPatronModelCopyWithImpl(this._self, this._then);

  final BarredPatronModel _self;
  final $Res Function(BarredPatronModel) _then;

/// Create a copy of BarredPatronModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? description = null,Object? reason = null,Object? playerId = null,Object? addedBy = null,Object? since = null,Object? active = null,}) {
  return _then(BarredPatronModel(
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


/// Adds pattern-matching-related methods to [BarredPatronModel].
extension BarredPatronModelPatterns on BarredPatronModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BarredPatronModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BarredPatronModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BarredPatronModel value)  $default,){
final _that = this;
switch (_that) {
case _BarredPatronModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BarredPatronModel value)?  $default,){
final _that = this;
switch (_that) {
case _BarredPatronModel() when $default != null:
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
case _BarredPatronModel() when $default != null:
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
case _BarredPatronModel():
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
case _BarredPatronModel() when $default != null:
return $default(_that.id,_that.description,_that.reason,_that.playerId,_that.addedBy,_that.since,_that.active);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BarredPatronModel extends BarredPatronModel {
  const _BarredPatronModel({required this.id, this.description = '', this.reason = '', this.playerId = '', this.addedBy = '', required this.since, this.active = true}): super._();
  factory _BarredPatronModel.fromJson(Map<String, dynamic> json) => _$BarredPatronModelFromJson(json);

@override final  String id;
@override@JsonKey() final  String description;
@override@JsonKey() final  String reason;
@override@JsonKey() final  String playerId;
@override@JsonKey() final  String addedBy;
@override final  DateTime since;
@override@JsonKey() final  bool active;

/// Create a copy of BarredPatronModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BarredPatronModelCopyWith<_BarredPatronModel> get copyWith => __$BarredPatronModelCopyWithImpl<_BarredPatronModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BarredPatronModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BarredPatronModel&&(identical(other.id, id) || other.id == id)&&(identical(other.description, description) || other.description == description)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.addedBy, addedBy) || other.addedBy == addedBy)&&(identical(other.since, since) || other.since == since)&&(identical(other.active, active) || other.active == active));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,description,reason,playerId,addedBy,since,active);
}

@override
String toString() {
    return 'BarredPatronModel(id: $id, description: $description, reason: $reason, playerId: $playerId, addedBy: $addedBy, since: $since, active: $active)';
}


}

/// @nodoc
abstract mixin class _$BarredPatronModelCopyWith<$Res> implements $BarredPatronModelCopyWith<$Res> {
  factory _$BarredPatronModelCopyWith(_BarredPatronModel value, $Res Function(_BarredPatronModel) _then) = __$BarredPatronModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String description, String reason, String playerId, String addedBy, DateTime since, bool active
});




}
/// @nodoc
class __$BarredPatronModelCopyWithImpl<$Res>
    implements _$BarredPatronModelCopyWith<$Res> {
  __$BarredPatronModelCopyWithImpl(this._self, this._then);

  final _BarredPatronModel _self;
  final $Res Function(_BarredPatronModel) _then;

/// Create a copy of BarredPatronModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? description = null,Object? reason = null,Object? playerId = null,Object? addedBy = null,Object? since = null,Object? active = null,}) {
  return _then(_BarredPatronModel(
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
mixin _$SarCaseModel {

 String get id; String get subject; String get summary; String get openedBy; double get amount; DateTime get detectedAt; bool get extended; DateTime? get filedAt;
/// Create a copy of SarCaseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SarCaseModelCopyWith<SarCaseModel> get copyWith => _$SarCaseModelCopyWithImpl<SarCaseModel>(this as SarCaseModel, _$identity);

  /// Serializes this SarCaseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SarCaseModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SarCaseModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.subject, _this.subject) || other.subject == _this.subject)&&(identical(other.summary, _this.summary) || other.summary == _this.summary)&&(identical(other.openedBy, _this.openedBy) || other.openedBy == _this.openedBy)&&(identical(other.amount, _this.amount) || other.amount == _this.amount)&&(identical(other.detectedAt, _this.detectedAt) || other.detectedAt == _this.detectedAt)&&(identical(other.extended, _this.extended) || other.extended == _this.extended)&&(identical(other.filedAt, _this.filedAt) || other.filedAt == _this.filedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SarCaseModel;
  return Object.hash(runtimeType,_this.id,_this.subject,_this.summary,_this.openedBy,_this.amount,_this.detectedAt,_this.extended,_this.filedAt);
}

@override
String toString() {
  final _this = this as SarCaseModel;
  return 'SarCaseModel(id: ${_this.id}, subject: ${_this.subject}, summary: ${_this.summary}, openedBy: ${_this.openedBy}, amount: ${_this.amount}, detectedAt: ${_this.detectedAt}, extended: ${_this.extended}, filedAt: ${_this.filedAt})';
}


}

/// @nodoc
abstract mixin class $SarCaseModelCopyWith<$Res>  {
  factory $SarCaseModelCopyWith(SarCaseModel value, $Res Function(SarCaseModel) _then) = _$SarCaseModelCopyWithImpl;
@useResult
$Res call({
 String id, String subject, String summary, String openedBy, double amount, DateTime detectedAt, bool extended, DateTime? filedAt
});




}
/// @nodoc
class _$SarCaseModelCopyWithImpl<$Res>
    implements $SarCaseModelCopyWith<$Res> {
  _$SarCaseModelCopyWithImpl(this._self, this._then);

  final SarCaseModel _self;
  final $Res Function(SarCaseModel) _then;

/// Create a copy of SarCaseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? subject = null,Object? summary = null,Object? openedBy = null,Object? amount = null,Object? detectedAt = null,Object? extended = null,Object? filedAt = freezed,}) {
  return _then(SarCaseModel(
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


/// Adds pattern-matching-related methods to [SarCaseModel].
extension SarCaseModelPatterns on SarCaseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SarCaseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SarCaseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SarCaseModel value)  $default,){
final _that = this;
switch (_that) {
case _SarCaseModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SarCaseModel value)?  $default,){
final _that = this;
switch (_that) {
case _SarCaseModel() when $default != null:
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
case _SarCaseModel() when $default != null:
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
case _SarCaseModel():
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
case _SarCaseModel() when $default != null:
return $default(_that.id,_that.subject,_that.summary,_that.openedBy,_that.amount,_that.detectedAt,_that.extended,_that.filedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SarCaseModel extends SarCaseModel {
  const _SarCaseModel({required this.id, this.subject = '', this.summary = '', this.openedBy = '', this.amount = 0, required this.detectedAt, this.extended = false, this.filedAt}): super._();
  factory _SarCaseModel.fromJson(Map<String, dynamic> json) => _$SarCaseModelFromJson(json);

@override final  String id;
@override@JsonKey() final  String subject;
@override@JsonKey() final  String summary;
@override@JsonKey() final  String openedBy;
@override@JsonKey() final  double amount;
@override final  DateTime detectedAt;
@override@JsonKey() final  bool extended;
@override final  DateTime? filedAt;

/// Create a copy of SarCaseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SarCaseModelCopyWith<_SarCaseModel> get copyWith => __$SarCaseModelCopyWithImpl<_SarCaseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SarCaseModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SarCaseModel&&(identical(other.id, id) || other.id == id)&&(identical(other.subject, subject) || other.subject == subject)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.openedBy, openedBy) || other.openedBy == openedBy)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.detectedAt, detectedAt) || other.detectedAt == detectedAt)&&(identical(other.extended, extended) || other.extended == extended)&&(identical(other.filedAt, filedAt) || other.filedAt == filedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,subject,summary,openedBy,amount,detectedAt,extended,filedAt);
}

@override
String toString() {
    return 'SarCaseModel(id: $id, subject: $subject, summary: $summary, openedBy: $openedBy, amount: $amount, detectedAt: $detectedAt, extended: $extended, filedAt: $filedAt)';
}


}

/// @nodoc
abstract mixin class _$SarCaseModelCopyWith<$Res> implements $SarCaseModelCopyWith<$Res> {
  factory _$SarCaseModelCopyWith(_SarCaseModel value, $Res Function(_SarCaseModel) _then) = __$SarCaseModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String subject, String summary, String openedBy, double amount, DateTime detectedAt, bool extended, DateTime? filedAt
});




}
/// @nodoc
class __$SarCaseModelCopyWithImpl<$Res>
    implements _$SarCaseModelCopyWith<$Res> {
  __$SarCaseModelCopyWithImpl(this._self, this._then);

  final _SarCaseModel _self;
  final $Res Function(_SarCaseModel) _then;

/// Create a copy of SarCaseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? subject = null,Object? summary = null,Object? openedBy = null,Object? amount = null,Object? detectedAt = null,Object? extended = null,Object? filedAt = freezed,}) {
  return _then(_SarCaseModel(
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
