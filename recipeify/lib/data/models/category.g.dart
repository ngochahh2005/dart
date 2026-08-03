// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Category _$CategoryFromJson(Map<String, dynamic> json) => _Category(
  id: json['idCategory'] as String?,
  name: json['strCategory'] as String,
  url: json['strCategoryThumb'] as String?,
  description: json['strCategoryDescription'] as String?,
);

Map<String, dynamic> _$CategoryToJson(_Category instance) => <String, dynamic>{
  'idCategory': instance.id,
  'strCategory': instance.name,
  'strCategoryThumb': instance.url,
  'strCategoryDescription': instance.description,
};
