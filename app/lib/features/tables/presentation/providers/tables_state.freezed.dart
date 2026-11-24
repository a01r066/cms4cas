// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tables_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TablesState {

 bool get saving; Failure? get failure;
/// Create a copy of TablesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TablesStateCopyWith<TablesState> get copyWith => _$TablesStateCopyWithImpl<TablesState>(this as TablesState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as TablesState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TablesState&&(identical(other.saving, _this.saving) || other.saving == _this.saving)&&(identical(other.failure, _this.failure) || other.failure == _this.failure));
}


@override
int get hashCode {
  final _this = this as TablesState;
  return Object.hash(runtimeType,_this.saving,_this.failure);
}

@override
String toString() {
  final _this = this as TablesState;
  return 'TablesState(saving: ${_this.saving}, failure: ${_this.failure})';
}


}

/// @nodoc
abstract mixin class $TablesStateCopyWith<$Res>  {
  factory $TablesStateCopyWith(TablesState value, $Res Function(TablesState) _then) = _$TablesStateCopyWithImpl;
@useResult
$Res call({
 bool saving, Failure? failure
});




}
/// @nodoc
class _$TablesStateCopyWithImpl<$Res>
    implements $TablesStateCopyWith<$Res> {
  _$TablesStateCopyWithImpl(this._self, this._then);

  final TablesState _self;
  final $Res Function(TablesState) _then;

/// Create a copy of TablesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? saving = null,Object? failure = freezed,}) {
  return _then(TablesState(
saving: null == saving ? _self.saving : saving // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

}


/// Adds pattern-matching-related methods to [TablesState].
extension TablesStatePatterns on TablesState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TablesState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TablesState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TablesState value)  $default,){
final _that = this;
switch (_that) {
case _TablesState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TablesState value)?  $default,){
final _that = this;
switch (_that) {
case _TablesState() when $default != null:
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
case _TablesState() when $default != null:
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
case _TablesState():
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
case _TablesState() when $default != null:
return $default(_that.saving,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _TablesState implements TablesState {
  const _TablesState({this.saving = false, this.failure});
  

@override@JsonKey() final  bool saving;
@override final  Failure? failure;

/// Create a copy of TablesState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TablesStateCopyWith<_TablesState> get copyWith => __$TablesStateCopyWithImpl<_TablesState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TablesState&&(identical(other.saving, saving) || other.saving == saving)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,saving,failure);
}

@override
String toString() {
    return 'TablesState(saving: $saving, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$TablesStateCopyWith<$Res> implements $TablesStateCopyWith<$Res> {
  factory _$TablesStateCopyWith(_TablesState value, $Res Function(_TablesState) _then) = __$TablesStateCopyWithImpl;
@override @useResult
$Res call({
 bool saving, Failure? failure
});




}
/// @nodoc
class __$TablesStateCopyWithImpl<$Res>
    implements _$TablesStateCopyWith<$Res> {
  __$TablesStateCopyWithImpl(this._self, this._then);

  final _TablesState _self;
  final $Res Function(_TablesState) _then;

/// Create a copy of TablesState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? saving = null,Object? failure = freezed,}) {
  return _then(_TablesState(
saving: null == saving ? _self.saving : saving // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}


}

// dart format on
