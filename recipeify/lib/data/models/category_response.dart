import 'package:freezed_annotation/freezed_annotation.dart';
import 'category.dart';
part 'category_response.freezed.dart';

@freezed
abstract class CategoryResponse with _$CategoryResponse {
  const factory CategoryResponse({
    @Default(<Category>[]) List<Category> categories,
  }) = _CategoryResponse;

  factory CategoryResponse.fromJson(Map<String, dynamic> json) {
    final rawList = json['categories'] as List<dynamic>?;
    if (rawList == null || rawList.isEmpty) return CategoryResponse();
    return CategoryResponse(categories: rawList.map((item) => Category.fromJson(item)).toList());
  }
}
