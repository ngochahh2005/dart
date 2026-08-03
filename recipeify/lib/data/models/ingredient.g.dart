// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ingredient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Ingredient _$IngredientFromJson(Map<String, dynamic> json) => _Ingredient(
  id: json['idIngredient'] as String?,
  name: json['strIngredient'] as String,
  description: json['strDescription'] as String?,
  measure: json['measure'] as String?,
  url: json['strThumb'] as String?,
  type: json['strType'] as String?,
);

Map<String, dynamic> _$IngredientToJson(_Ingredient instance) =>
    <String, dynamic>{
      'idIngredient': instance.id,
      'strIngredient': instance.name,
      'strDescription': instance.description,
      'measure': instance.measure,
      'strThumb': instance.url,
      'strType': instance.type,
    };
