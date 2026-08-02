import 'package:freezed_annotation/freezed_annotation.dart';

import 'meal.dart';
part 'meal_response.freezed.dart';

@freezed
abstract class MealResponse with _$MealResponse {
  const factory MealResponse({
    @Default(<Meal>[]) List<Meal> meals,
  }) = _MealResponse;

  factory MealResponse.fromJson(Map<String, dynamic> json) {
    final rawList = json['meals'] as List<dynamic>?;
    if (rawList == null || rawList.isEmpty) return MealResponse();
    return MealResponse(meals: rawList.map((item) => Meal.fromJson(item)).toList());
  }
}