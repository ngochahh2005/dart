// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cat_breed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CatBreed _$CatBreedFromJson(Map<String, dynamic> json) => _CatBreed(
  id: json['id'] as String,
  name: json['name'] as String,
  referenceImageId: json['reference_image_id'] as String?,
  temperament: json['temperament'] as String?,
  origin: json['origin'] as String?,
  lifeSpan: json['life_span'] as String?,
  description: json['description'] as String?,
);

Map<String, dynamic> _$CatBreedToJson(_CatBreed instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'reference_image_id': instance.referenceImageId,
  'temperament': instance.temperament,
  'origin': instance.origin,
  'life_span': instance.lifeSpan,
  'description': instance.description,
};
