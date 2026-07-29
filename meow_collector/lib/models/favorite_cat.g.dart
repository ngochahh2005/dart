// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_cat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FavoriteCat _$FavoriteCatFromJson(Map<String, dynamic> json) => _FavoriteCat(
  id: json['id'] as String,
  breedName: json['breedName'] as String,
  imageUrl: json['imageUrl'] as String,
  breedType: json['breedType'] as String,
  createdAt: (json['createdAt'] as num?)?.toInt(),
);

Map<String, dynamic> _$FavoriteCatToJson(_FavoriteCat instance) =>
    <String, dynamic>{
      'id': instance.id,
      'breedName': instance.breedName,
      'imageUrl': instance.imageUrl,
      'breedType': instance.breedType,
      'createdAt': instance.createdAt,
    };
