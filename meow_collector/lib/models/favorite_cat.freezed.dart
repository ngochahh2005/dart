// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'favorite_cat.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FavoriteCat {

 String get id; String get breedName; String get imageUrl; String get breedType; int? get createdAt;
/// Create a copy of FavoriteCat
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FavoriteCatCopyWith<FavoriteCat> get copyWith => _$FavoriteCatCopyWithImpl<FavoriteCat>(this as FavoriteCat, _$identity);

  /// Serializes this FavoriteCat to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FavoriteCat&&(identical(other.id, id) || other.id == id)&&(identical(other.breedName, breedName) || other.breedName == breedName)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.breedType, breedType) || other.breedType == breedType)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,breedName,imageUrl,breedType,createdAt);

@override
String toString() {
  return 'FavoriteCat(id: $id, breedName: $breedName, imageUrl: $imageUrl, breedType: $breedType, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $FavoriteCatCopyWith<$Res>  {
  factory $FavoriteCatCopyWith(FavoriteCat value, $Res Function(FavoriteCat) _then) = _$FavoriteCatCopyWithImpl;
@useResult
$Res call({
 String id, String breedName, String imageUrl, String breedType, int? createdAt
});




}
/// @nodoc
class _$FavoriteCatCopyWithImpl<$Res>
    implements $FavoriteCatCopyWith<$Res> {
  _$FavoriteCatCopyWithImpl(this._self, this._then);

  final FavoriteCat _self;
  final $Res Function(FavoriteCat) _then;

/// Create a copy of FavoriteCat
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? breedName = null,Object? imageUrl = null,Object? breedType = null,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,breedName: null == breedName ? _self.breedName : breedName // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,breedType: null == breedType ? _self.breedType : breedType // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [FavoriteCat].
extension FavoriteCatPatterns on FavoriteCat {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FavoriteCat value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FavoriteCat() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FavoriteCat value)  $default,){
final _that = this;
switch (_that) {
case _FavoriteCat():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FavoriteCat value)?  $default,){
final _that = this;
switch (_that) {
case _FavoriteCat() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String breedName,  String imageUrl,  String breedType,  int? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FavoriteCat() when $default != null:
return $default(_that.id,_that.breedName,_that.imageUrl,_that.breedType,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String breedName,  String imageUrl,  String breedType,  int? createdAt)  $default,) {final _that = this;
switch (_that) {
case _FavoriteCat():
return $default(_that.id,_that.breedName,_that.imageUrl,_that.breedType,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String breedName,  String imageUrl,  String breedType,  int? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _FavoriteCat() when $default != null:
return $default(_that.id,_that.breedName,_that.imageUrl,_that.breedType,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FavoriteCat implements FavoriteCat {
  const _FavoriteCat({required this.id, required this.breedName, required this.imageUrl, required this.breedType, this.createdAt});
  factory _FavoriteCat.fromJson(Map<String, dynamic> json) => _$FavoriteCatFromJson(json);

@override final  String id;
@override final  String breedName;
@override final  String imageUrl;
@override final  String breedType;
@override final  int? createdAt;

/// Create a copy of FavoriteCat
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FavoriteCatCopyWith<_FavoriteCat> get copyWith => __$FavoriteCatCopyWithImpl<_FavoriteCat>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FavoriteCatToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FavoriteCat&&(identical(other.id, id) || other.id == id)&&(identical(other.breedName, breedName) || other.breedName == breedName)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.breedType, breedType) || other.breedType == breedType)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,breedName,imageUrl,breedType,createdAt);

@override
String toString() {
  return 'FavoriteCat(id: $id, breedName: $breedName, imageUrl: $imageUrl, breedType: $breedType, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$FavoriteCatCopyWith<$Res> implements $FavoriteCatCopyWith<$Res> {
  factory _$FavoriteCatCopyWith(_FavoriteCat value, $Res Function(_FavoriteCat) _then) = __$FavoriteCatCopyWithImpl;
@override @useResult
$Res call({
 String id, String breedName, String imageUrl, String breedType, int? createdAt
});




}
/// @nodoc
class __$FavoriteCatCopyWithImpl<$Res>
    implements _$FavoriteCatCopyWith<$Res> {
  __$FavoriteCatCopyWithImpl(this._self, this._then);

  final _FavoriteCat _self;
  final $Res Function(_FavoriteCat) _then;

/// Create a copy of FavoriteCat
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? breedName = null,Object? imageUrl = null,Object? breedType = null,Object? createdAt = freezed,}) {
  return _then(_FavoriteCat(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,breedName: null == breedName ? _self.breedName : breedName // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,breedType: null == breedType ? _self.breedType : breedType // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
