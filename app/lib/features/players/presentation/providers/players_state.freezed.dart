// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'players_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PlayersState {

 bool get saving; Failure? get failure;
/// Create a copy of PlayersState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlayersStateCopyWith<PlayersState> get copyWith => _$PlayersStateCopyWithImpl<PlayersState>(this as PlayersState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PlayersState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlayersState&&(identical(other.saving, _this.saving) || other.saving == _this.saving)&&(identical(other.failure, _this.failure) || other.failure == _this.failure));
}


@override
int get hashCode {
  final _this = this as PlayersState;
  return Object.hash(runtimeType,_this.saving,_this.failure);
}

@override
String toString() {
  final _this = this as PlayersState;
  return 'PlayersState(saving: ${_this.saving}, failure: ${_this.failure})';
}


}

/// @nodoc
abstract mixin class $PlayersStateCopyWith<$Res>  {
  factory $PlayersStateCopyWith(PlayersState value, $Res Function(PlayersState) _then) = _$PlayersStateCopyWithImpl;
@useResult
$Res call({
 bool saving, Failure? failure
});




}
/// @nodoc
class _$PlayersStateCopyWithImpl<$Res>
    implements $PlayersStateCopyWith<$Res> {
  _$PlayersStateCopyWithImpl(this._self, this._then);

  final PlayersState _self;
  final $Res Function(PlayersState) _then;

/// Create a copy of PlayersState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? saving = null,Object? failure = freezed,}) {
  return _then(PlayersState(
saving: null == saving ? _self.saving : saving // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

}


/// Adds pattern-matching-related methods to [PlayersState].
extension PlayersStatePatterns on PlayersState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlayersState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlayersState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlayersState value)  $default,){
final _that = this;
switch (_that) {
case _PlayersState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlayersState value)?  $default,){
final _that = this;
switch (_that) {
case _PlayersState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool saving,  Failure? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlayersState() when $default != null:
return $default(_that.saving,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool saving,  Failure? failure)  $default,) {final _that = this;
switch (_that) {
case _PlayersState():
return $default(_that.saving,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool saving,  Failure? failure)?  $default,) {final _that = this;
switch (_that) {
case _PlayersState() when $default != null:
return $default(_that.saving,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _PlayersState implements PlayersState {
  const _PlayersState({this.saving = false, this.failure});
  

@override@JsonKey() final  bool saving;
@override final  Failure? failure;

/// Create a copy of PlayersState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlayersStateCopyWith<_PlayersState> get copyWith => __$PlayersStateCopyWithImpl<_PlayersState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlayersState&&(identical(other.saving, saving) || other.saving == saving)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,saving,failure);
}

@override
String toString() {
    return 'PlayersState(saving: $saving, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$PlayersStateCopyWith<$Res> implements $PlayersStateCopyWith<$Res> {
  factory _$PlayersStateCopyWith(_PlayersState value, $Res Function(_PlayersState) _then) = __$PlayersStateCopyWithImpl;
@override @useResult
$Res call({
 bool saving, Failure? failure
});




}
/// @nodoc
class __$PlayersStateCopyWithImpl<$Res>
    implements _$PlayersStateCopyWith<$Res> {
  __$PlayersStateCopyWithImpl(this._self, this._then);

  final _PlayersState _self;
  final $Res Function(_PlayersState) _then;

/// Create a copy of PlayersState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? saving = null,Object? failure = freezed,}) {
  return _then(_PlayersState(
saving: null == saving ? _self.saving : saving // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}


}

// dart format on
