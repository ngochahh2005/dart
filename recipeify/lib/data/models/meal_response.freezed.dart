// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meal_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MealResponse {

 List<Meal> get meals;
/// Create a copy of MealResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MealResponseCopyWith<MealResponse> get copyWith => _$MealResponseCopyWithImpl<MealResponse>(this as MealResponse, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MealResponse&&const DeepCollectionEquality().equals(other.meals, meals));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(meals));

@override
String toString() {
  return 'MealResponse(meals: $meals)';
}


}

/// @nodoc
abstract mixin class $MealResponseCopyWith<$Res>  {
  factory $MealResponseCopyWith(MealResponse value, $Res Function(MealResponse) _then) = _$MealResponseCopyWithImpl;
@useResult
$Res call({
 List<Meal> meals
});




}
/// @nodoc
class _$MealResponseCopyWithImpl<$Res>
    implements $MealResponseCopyWith<$Res> {
  _$MealResponseCopyWithImpl(this._self, this._then);

  final MealResponse _self;
  final $Res Function(MealResponse) _then;

/// Create a copy of MealResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? meals = null,}) {
  return _then(_self.copyWith(
meals: null == meals ? _self.meals : meals // ignore: cast_nullable_to_non_nullable
as List<Meal>,
  ));
}

}


/// Adds pattern-matching-related methods to [MealResponse].
extension MealResponsePatterns on MealResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MealResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MealResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MealResponse value)  $default,){
final _that = this;
switch (_that) {
case _MealResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MealResponse value)?  $default,){
final _that = this;
switch (_that) {
case _MealResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Meal> meals)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MealResponse() when $default != null:
return $default(_that.meals);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Meal> meals)  $default,) {final _that = this;
switch (_that) {
case _MealResponse():
return $default(_that.meals);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Meal> meals)?  $default,) {final _that = this;
switch (_that) {
case _MealResponse() when $default != null:
return $default(_that.meals);case _:
  return null;

}
}

}

/// @nodoc


class _MealResponse implements MealResponse {
  const _MealResponse({final  List<Meal> meals = const <Meal>[]}): _meals = meals;
  

 final  List<Meal> _meals;
@override@JsonKey() List<Meal> get meals {
  if (_meals is EqualUnmodifiableListView) return _meals;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_meals);
}


/// Create a copy of MealResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MealResponseCopyWith<_MealResponse> get copyWith => __$MealResponseCopyWithImpl<_MealResponse>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MealResponse&&const DeepCollectionEquality().equals(other._meals, _meals));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_meals));

@override
String toString() {
  return 'MealResponse(meals: $meals)';
}


}

/// @nodoc
abstract mixin class _$MealResponseCopyWith<$Res> implements $MealResponseCopyWith<$Res> {
  factory _$MealResponseCopyWith(_MealResponse value, $Res Function(_MealResponse) _then) = __$MealResponseCopyWithImpl;
@override @useResult
$Res call({
 List<Meal> meals
});




}
/// @nodoc
class __$MealResponseCopyWithImpl<$Res>
    implements _$MealResponseCopyWith<$Res> {
  __$MealResponseCopyWithImpl(this._self, this._then);

  final _MealResponse _self;
  final $Res Function(_MealResponse) _then;

/// Create a copy of MealResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? meals = null,}) {
  return _then(_MealResponse(
meals: null == meals ? _self._meals : meals // ignore: cast_nullable_to_non_nullable
as List<Meal>,
  ));
}


}

// dart format on
