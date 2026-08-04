import 'package:freezed_annotation/freezed_annotation.dart';
import 'category.dart';

part 'category_response.freezed.dart';

part 'category_response.g.dart';

@freezed
abstract class CategoryResponse with _$CategoryResponse {
  const factory CategoryResponse({
    @JsonKey(name: 'categories')
    @Default(<Category>[])
    List<Category> categories,
  }) = _CategoryResponse;

  factory CategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoryResponseFromJson(json);
}
