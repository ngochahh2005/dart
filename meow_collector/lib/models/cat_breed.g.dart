// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cat_breed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CatBreed _$CatBreedFromJson(Map<String, dynamic> json) => _CatBreed(
  id: json['id'] as String,
  name: json['name'] as String,
  referenceImageId: json['referenceImageId'] as String?,
  temperament: json['temperament'] as String?,
  origin: json['origin'] as String?,
  lifeSpan: json['lifeSpan'] as String?,
  description: json['description'] as String?,
);

Map<String, dynamic> _$CatBreedToJson(_CatBreed instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'referenceImageId': instance.referenceImageId,
  'temperament': instance.temperament,
  'origin': instance.origin,
  'lifeSpan': instance.lifeSpan,
  'description': instance.description,
};
