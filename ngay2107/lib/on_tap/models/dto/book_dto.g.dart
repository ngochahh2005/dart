// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BookDto _$BookDtoFromJson(Map<String, dynamic> json) =>
    _BookDto(id: (json['id'] as num).toInt(), title: json['title'] as String);

Map<String, dynamic> _$BookDtoToJson(_BookDto instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
};
