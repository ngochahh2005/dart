// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cat_image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CatImage _$CatImageFromJson(Map<String, dynamic> json) => _CatImage(
  id: json['id'] as String,
  url: json['url'] as String,
  width: (json['width'] as num?)?.toInt(),
  height: (json['height'] as num?)?.toInt(),
);

Map<String, dynamic> _$CatImageToJson(_CatImage instance) => <String, dynamic>{
  'id': instance.id,
  'url': instance.url,
  'width': instance.width,
  'height': instance.height,
};
