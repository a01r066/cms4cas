// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'access_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AccessRequest {

 String get uid; String get name; String get email; DateTime get requestedAt;
/// Create a copy of AccessRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AccessRequestCopyWith<AccessRequest> get copyWith => _$AccessRequestCopyWithImpl<AccessRequest>(this as AccessRequest, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AccessRequest;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccessRequest&&(identical(other.uid, _this.uid) || other.uid == _this.uid)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.email, _this.email) || other.email == _this.email)&&(identical(other.requestedAt, _this.requestedAt) || other.requestedAt == _this.requestedAt));
}


@override
int get hashCode {
  final _this = this as AccessRequest;
  return Object.hash(runtimeType,_this.uid,_this.name,_this.email,_this.requestedAt);
}

@override
String toString() {
  final _this = this as AccessRequest;
  return 'AccessRequest(uid: ${_this.uid}, name: ${_this.name}, email: ${_this.email}, requestedAt: ${_this.requestedAt})';
}


}

/// @nodoc
abstract mixin class $AccessRequestCopyWith<$Res>  {
  factory $AccessRequestCopyWith(AccessRequest value, $Res Function(AccessRequest) _then) = _$AccessRequestCopyWithImpl;
@useResult
$Res call({
 String uid, String name, String email, DateTime requestedAt
});




}
/// @nodoc
class _$AccessRequestCopyWithImpl<$Res>
    implements $AccessRequestCopyWith<$Res> {
  _$AccessRequestCopyWithImpl(this._self, this._then);

  final AccessRequest _self;
  final $Res Function(AccessRequest) _then;

/// Create a copy of AccessRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? uid = null,Object? name = null,Object? email = null,Object? requestedAt = null,}) {
  return _then(AccessRequest(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,requestedAt: null == requestedAt ? _self.requestedAt : requestedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [AccessRequest].
extension AccessRequestPatterns on AccessRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AccessRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AccessRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AccessRequest value)  $default,){
final _that = this;
switch (_that) {
case _AccessRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AccessRequest value)?  $default,){
final _that = this;
switch (_that) {
case _AccessRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String uid,  String name,  String email,  DateTime requestedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AccessRequest() when $default != null:
return $default(_that.uid,_that.name,_that.email,_that.requestedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String uid,  String name,  String email,  DateTime requestedAt)  $default,) {final _that = this;
switch (_that) {
case _AccessRequest():
return $default(_that.uid,_that.name,_that.email,_that.requestedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String uid,  String name,  String email,  DateTime requestedAt)?  $default,) {final _that = this;
switch (_that) {
case _AccessRequest() when $default != null:
return $default(_that.uid,_that.name,_that.email,_that.requestedAt);case _:
  return null;

}
}

}

/// @nodoc


class _AccessRequest implements AccessRequest {
  const _AccessRequest({required this.uid, required this.name, required this.email, required this.requestedAt});
  

@override final  String uid;
@override final  String name;
@override final  String email;
@override final  DateTime requestedAt;

/// Create a copy of AccessRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AccessRequestCopyWith<_AccessRequest> get copyWith => __$AccessRequestCopyWithImpl<_AccessRequest>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AccessRequest&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.requestedAt, requestedAt) || other.requestedAt == requestedAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,uid,name,email,requestedAt);
}

@override
String toString() {
    return 'AccessRequest(uid: $uid, name: $name, email: $email, requestedAt: $requestedAt)';
}


}

/// @nodoc
abstract mixin class _$AccessRequestCopyWith<$Res> implements $AccessRequestCopyWith<$Res> {
  factory _$AccessRequestCopyWith(_AccessRequest value, $Res Function(_AccessRequest) _then) = __$AccessRequestCopyWithImpl;
@override @useResult
$Res call({
 String uid, String name, String email, DateTime requestedAt
});




}
/// @nodoc
class __$AccessRequestCopyWithImpl<$Res>
    implements _$AccessRequestCopyWith<$Res> {
  __$AccessRequestCopyWithImpl(this._self, this._then);

  final _AccessRequest _self;
  final $Res Function(_AccessRequest) _then;

/// Create a copy of AccessRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? uid = null,Object? name = null,Object? email = null,Object? requestedAt = null,}) {
  return _then(_AccessRequest(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,requestedAt: null == requestedAt ? _self.requestedAt : requestedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
