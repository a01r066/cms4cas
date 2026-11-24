// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'access_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AccessRequestModel {

 String get id; String get uid; String get name; String get email; DateTime get requestedAt;
/// Create a copy of AccessRequestModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AccessRequestModelCopyWith<AccessRequestModel> get copyWith => _$AccessRequestModelCopyWithImpl<AccessRequestModel>(this as AccessRequestModel, _$identity);

  /// Serializes this AccessRequestModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AccessRequestModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccessRequestModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.uid, _this.uid) || other.uid == _this.uid)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.email, _this.email) || other.email == _this.email)&&(identical(other.requestedAt, _this.requestedAt) || other.requestedAt == _this.requestedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AccessRequestModel;
  return Object.hash(runtimeType,_this.id,_this.uid,_this.name,_this.email,_this.requestedAt);
}

@override
String toString() {
  final _this = this as AccessRequestModel;
  return 'AccessRequestModel(id: ${_this.id}, uid: ${_this.uid}, name: ${_this.name}, email: ${_this.email}, requestedAt: ${_this.requestedAt})';
}


}

/// @nodoc
abstract mixin class $AccessRequestModelCopyWith<$Res>  {
  factory $AccessRequestModelCopyWith(AccessRequestModel value, $Res Function(AccessRequestModel) _then) = _$AccessRequestModelCopyWithImpl;
@useResult
$Res call({
 String id, String uid, String name, String email, DateTime requestedAt
});




}
/// @nodoc
class _$AccessRequestModelCopyWithImpl<$Res>
    implements $AccessRequestModelCopyWith<$Res> {
  _$AccessRequestModelCopyWithImpl(this._self, this._then);

  final AccessRequestModel _self;
  final $Res Function(AccessRequestModel) _then;

/// Create a copy of AccessRequestModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? uid = null,Object? name = null,Object? email = null,Object? requestedAt = null,}) {
  return _then(AccessRequestModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,requestedAt: null == requestedAt ? _self.requestedAt : requestedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [AccessRequestModel].
extension AccessRequestModelPatterns on AccessRequestModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AccessRequestModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AccessRequestModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AccessRequestModel value)  $default,){
final _that = this;
switch (_that) {
case _AccessRequestModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AccessRequestModel value)?  $default,){
final _that = this;
switch (_that) {
case _AccessRequestModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String uid,  String name,  String email,  DateTime requestedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AccessRequestModel() when $default != null:
return $default(_that.id,_that.uid,_that.name,_that.email,_that.requestedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String uid,  String name,  String email,  DateTime requestedAt)  $default,) {final _that = this;
switch (_that) {
case _AccessRequestModel():
return $default(_that.id,_that.uid,_that.name,_that.email,_that.requestedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String uid,  String name,  String email,  DateTime requestedAt)?  $default,) {final _that = this;
switch (_that) {
case _AccessRequestModel() when $default != null:
return $default(_that.id,_that.uid,_that.name,_that.email,_that.requestedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AccessRequestModel extends AccessRequestModel {
  const _AccessRequestModel({required this.id, required this.uid, this.name = '', this.email = '', required this.requestedAt}): super._();
  factory _AccessRequestModel.fromJson(Map<String, dynamic> json) => _$AccessRequestModelFromJson(json);

@override final  String id;
@override final  String uid;
@override@JsonKey() final  String name;
@override@JsonKey() final  String email;
@override final  DateTime requestedAt;

/// Create a copy of AccessRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AccessRequestModelCopyWith<_AccessRequestModel> get copyWith => __$AccessRequestModelCopyWithImpl<_AccessRequestModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AccessRequestModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AccessRequestModel&&(identical(other.id, id) || other.id == id)&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.requestedAt, requestedAt) || other.requestedAt == requestedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,uid,name,email,requestedAt);
}

@override
String toString() {
    return 'AccessRequestModel(id: $id, uid: $uid, name: $name, email: $email, requestedAt: $requestedAt)';
}


}

/// @nodoc
abstract mixin class _$AccessRequestModelCopyWith<$Res> implements $AccessRequestModelCopyWith<$Res> {
  factory _$AccessRequestModelCopyWith(_AccessRequestModel value, $Res Function(_AccessRequestModel) _then) = __$AccessRequestModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String uid, String name, String email, DateTime requestedAt
});




}
/// @nodoc
class __$AccessRequestModelCopyWithImpl<$Res>
    implements _$AccessRequestModelCopyWith<$Res> {
  __$AccessRequestModelCopyWithImpl(this._self, this._then);

  final _AccessRequestModel _self;
  final $Res Function(_AccessRequestModel) _then;

/// Create a copy of AccessRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? uid = null,Object? name = null,Object? email = null,Object? requestedAt = null,}) {
  return _then(_AccessRequestModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,requestedAt: null == requestedAt ? _self.requestedAt : requestedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
