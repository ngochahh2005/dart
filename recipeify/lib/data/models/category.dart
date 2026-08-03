import 'package:freezed_annotation/freezed_annotation.dart';

part 'category.freezed.dart';

part 'category.g.dart';

@freezed
abstract class Category with _$Category {
  const factory Category({
    @JsonKey(name: 'idCategory') String? id,
    @JsonKey(name: 'strCategory') required String name,
    @JsonKey(name: 'strCategoryThumb') String? url,
    @JsonKey(name: 'strCategoryDescription') String? description,
  }) = _Category;

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);
}
