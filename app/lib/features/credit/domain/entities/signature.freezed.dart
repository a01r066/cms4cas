// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'signature.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Signature {

 String get userId; String get userName; CreditRole get role; DateTime get at;
/// Create a copy of Signature
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignatureCopyWith<Signature> get copyWith => _$SignatureCopyWithImpl<Signature>(this as Signature, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Signature;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Signature&&(identical(other.userId, _this.userId) || other.userId == _this.userId)&&(identical(other.userName, _this.userName) || other.userName == _this.userName)&&(identical(other.role, _this.role) || other.role == _this.role)&&(identical(other.at, _this.at) || other.at == _this.at));
}


@override
int get hashCode {
  final _this = this as Signature;
  return Object.hash(runtimeType,_this.userId,_this.userName,_this.role,_this.at);
}

@override
String toString() {
  final _this = this as Signature;
  return 'Signature(userId: ${_this.userId}, userName: ${_this.userName}, role: ${_this.role}, at: ${_this.at})';
}


}

/// @nodoc
abstract mixin class $SignatureCopyWith<$Res>  {
  factory $SignatureCopyWith(Signature value, $Res Function(Signature) _then) = _$SignatureCopyWithImpl;
@useResult
$Res call({
 String userId, String userName, CreditRole role, DateTime at
});




}
/// @nodoc
class _$SignatureCopyWithImpl<$Res>
    implements $SignatureCopyWith<$Res> {
  _$SignatureCopyWithImpl(this._self, this._then);

  final Signature _self;
  final $Res Function(Signature) _then;

/// Create a copy of Signature
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? userName = null,Object? role = null,Object? at = null,}) {
  return _then(Signature(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as CreditRole,at: null == at ? _self.at : at // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [Signature].
extension SignaturePatterns on Signature {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Signature value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Signature() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Signature value)  $default,){
final _that = this;
switch (_that) {
case _Signature():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Signature value)?  $default,){
final _that = this;
switch (_that) {
case _Signature() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  String userName,  CreditRole role,  DateTime at)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Signature() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  String userName,  CreditRole role,  DateTime at)  $default,) {final _that = this;
switch (_that) {
case _Signature():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  String userName,  CreditRole role,  DateTime at)?  $default,) {final _that = this;
switch (_that) {
case _Signature() when $default != null:
return $default(_that.userId,_that.userName,_that.role,_that.at);case _:
  return null;

}
}

}

/// @nodoc


class _Signature implements Signature {
  const _Signature({required this.userId, required this.userName, required this.role, required this.at});
  

@override final  String userId;
@override final  String userName;
@override final  CreditRole role;
@override final  DateTime at;

/// Create a copy of Signature
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignatureCopyWith<_Signature> get copyWith => __$SignatureCopyWithImpl<_Signature>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Signature&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.role, role) || other.role == role)&&(identical(other.at, at) || other.at == at));
}


@override
int get hashCode {
    return Object.hash(runtimeType,userId,userName,role,at);
}

@override
String toString() {
    return 'Signature(userId: $userId, userName: $userName, role: $role, at: $at)';
}


}

/// @nodoc
abstract mixin class _$SignatureCopyWith<$Res> implements $SignatureCopyWith<$Res> {
  factory _$SignatureCopyWith(_Signature value, $Res Function(_Signature) _then) = __$SignatureCopyWithImpl;
@override @useResult
$Res call({
 String userId, String userName, CreditRole role, DateTime at
});




}
/// @nodoc
class __$SignatureCopyWithImpl<$Res>
    implements _$SignatureCopyWith<$Res> {
  __$SignatureCopyWithImpl(this._self, this._then);

  final _Signature _self;
  final $Res Function(_Signature) _then;

/// Create a copy of Signature
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? userName = null,Object? role = null,Object? at = null,}) {
  return _then(_Signature(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as CreditRole,at: null == at ? _self.at : at // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
