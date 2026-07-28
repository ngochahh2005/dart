// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weather.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Weather {

 String get cityName; double get temperature; int get humidity; String get time; String get condition; IconData get icon; Color get color;
/// Create a copy of Weather
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WeatherCopyWith<Weather> get copyWith => _$WeatherCopyWithImpl<Weather>(this as Weather, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Weather&&(identical(other.cityName, cityName) || other.cityName == cityName)&&(identical(other.temperature, temperature) || other.temperature == temperature)&&(identical(other.humidity, humidity) || other.humidity == humidity)&&(identical(other.time, time) || other.time == time)&&(identical(other.condition, condition) || other.condition == condition)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.color, color) || other.color == color));
}


@override
int get hashCode => Object.hash(runtimeType,cityName,temperature,humidity,time,condition,icon,color);

@override
String toString() {
  return 'Weather(cityName: $cityName, temperature: $temperature, humidity: $humidity, time: $time, condition: $condition, icon: $icon, color: $color)';
}


}

/// @nodoc
abstract mixin class $WeatherCopyWith<$Res>  {
  factory $WeatherCopyWith(Weather value, $Res Function(Weather) _then) = _$WeatherCopyWithImpl;
@useResult
$Res call({
 String cityName, double temperature, int humidity, String time, String condition, IconData icon, Color color
});




}
/// @nodoc
class _$WeatherCopyWithImpl<$Res>
    implements $WeatherCopyWith<$Res> {
  _$WeatherCopyWithImpl(this._self, this._then);

  final Weather _self;
  final $Res Function(Weather) _then;

/// Create a copy of Weather
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cityName = null,Object? temperature = null,Object? humidity = null,Object? time = null,Object? condition = null,Object? icon = null,Object? color = null,}) {
  return _then(_self.copyWith(
cityName: null == cityName ? _self.cityName : cityName // ignore: cast_nullable_to_non_nullable
as String,temperature: null == temperature ? _self.temperature : temperature // ignore: cast_nullable_to_non_nullable
as double,humidity: null == humidity ? _self.humidity : humidity // ignore: cast_nullable_to_non_nullable
as int,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String,condition: null == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as IconData,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as Color,
  ));
}

}


/// Adds pattern-matching-related methods to [Weather].
extension WeatherPatterns on Weather {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Weather value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Weather() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Weather value)  $default,){
final _that = this;
switch (_that) {
case _Weather():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Weather value)?  $default,){
final _that = this;
switch (_that) {
case _Weather() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String cityName,  double temperature,  int humidity,  String time,  String condition,  IconData icon,  Color color)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Weather() when $default != null:
return $default(_that.cityName,_that.temperature,_that.humidity,_that.time,_that.condition,_that.icon,_that.color);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String cityName,  double temperature,  int humidity,  String time,  String condition,  IconData icon,  Color color)  $default,) {final _that = this;
switch (_that) {
case _Weather():
return $default(_that.cityName,_that.temperature,_that.humidity,_that.time,_that.condition,_that.icon,_that.color);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String cityName,  double temperature,  int humidity,  String time,  String condition,  IconData icon,  Color color)?  $default,) {final _that = this;
switch (_that) {
case _Weather() when $default != null:
return $default(_that.cityName,_that.temperature,_that.humidity,_that.time,_that.condition,_that.icon,_that.color);case _:
  return null;

}
}

}

/// @nodoc


class _Weather extends Weather {
  const _Weather({required this.cityName, required this.temperature, required this.humidity, required this.time, required this.condition, required this.icon, required this.color}): super._();
  

@override final  String cityName;
@override final  double temperature;
@override final  int humidity;
@override final  String time;
@override final  String condition;
@override final  IconData icon;
@override final  Color color;

/// Create a copy of Weather
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WeatherCopyWith<_Weather> get copyWith => __$WeatherCopyWithImpl<_Weather>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Weather&&(identical(other.cityName, cityName) || other.cityName == cityName)&&(identical(other.temperature, temperature) || other.temperature == temperature)&&(identical(other.humidity, humidity) || other.humidity == humidity)&&(identical(other.time, time) || other.time == time)&&(identical(other.condition, condition) || other.condition == condition)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.color, color) || other.color == color));
}


@override
int get hashCode => Object.hash(runtimeType,cityName,temperature,humidity,time,condition,icon,color);

@override
String toString() {
  return 'Weather(cityName: $cityName, temperature: $temperature, humidity: $humidity, time: $time, condition: $condition, icon: $icon, color: $color)';
}


}

/// @nodoc
abstract mixin class _$WeatherCopyWith<$Res> implements $WeatherCopyWith<$Res> {
  factory _$WeatherCopyWith(_Weather value, $Res Function(_Weather) _then) = __$WeatherCopyWithImpl;
@override @useResult
$Res call({
 String cityName, double temperature, int humidity, String time, String condition, IconData icon, Color color
});




}
/// @nodoc
class __$WeatherCopyWithImpl<$Res>
    implements _$WeatherCopyWith<$Res> {
  __$WeatherCopyWithImpl(this._self, this._then);

  final _Weather _self;
  final $Res Function(_Weather) _then;

/// Create a copy of Weather
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cityName = null,Object? temperature = null,Object? humidity = null,Object? time = null,Object? condition = null,Object? icon = null,Object? color = null,}) {
  return _then(_Weather(
cityName: null == cityName ? _self.cityName : cityName // ignore: cast_nullable_to_non_nullable
as String,temperature: null == temperature ? _self.temperature : temperature // ignore: cast_nullable_to_non_nullable
as double,humidity: null == humidity ? _self.humidity : humidity // ignore: cast_nullable_to_non_nullable
as int,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String,condition: null == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as IconData,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as Color,
  ));
}


}

// dart format on
