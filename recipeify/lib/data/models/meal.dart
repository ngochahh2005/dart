import 'package:freezed_annotation/freezed_annotation.dart';

import 'ingredient.dart';

part 'meal.freezed.dart';

@freezed
abstract class Meal with _$Meal {
  const Meal._();

  const factory Meal({
    required String id,
    required String name,
    required String url,
    required String instructions,
    String? category,
    String? area,
    String? youtubeUrl,
    @Default(<String>[]) List<String> tags,
    @Default(<Ingredient>[]) List<Ingredient> ingredients,
  }) = _Meal;

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      id: json['idMeal'] as String,
      name: json['strMeal'] as String,
      url: json['strMealThumb'] as String,
      instructions: json['strInstructions'] as String,
      category: json['strCategory'] as String?,
      area: json['strArea'] as String?,
      youtubeUrl: json['strYoutube'] as String?,
      tags: _parseTags(json['strTags']),
      ingredients: _parseIngredients(json),
    );
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic> {
      'idMeal': id,
      'strMeal': name,
      'strMealThumb': url,
      'strInstructions': instructions,
      'strCategory': category,
      'strArea': area,
      'strYoutube': youtubeUrl,
      'strTags': tags.join(','),
    };

    for (int i = 1; i <= 20; i++) {
      if (i <= ingredients.length) {
        map['strIngredient$i'] = ingredients[i-1].name;
        map['strMeasure$i'] = ingredients[i-1].measure;
      } else {
        map['strIngredient$i'] = '';
        map['strMeasure$i'] = '';
      }
    }

    return map;
  }

  static List<String> _parseTags(String? raw) {
    if (raw == null || raw.trim().isEmpty) return [];
    return raw
        .split(',')
        .map((tag) => tag.trim())
        .where((tag) => tag.isNotEmpty)
        .toList();
  }

  static List<Ingredient> _parseIngredients(Map<String, dynamic> json) {
    final res = <Ingredient>[];
    for (int i = 1; i < 21; i++) {
      final name = json['strIngredient$i'] as String?;
      final measure = json['strMeasure$i'] as String?;
      if (name == null || name.isEmpty) continue;
      final ingredient = Ingredient(name: name, measure: measure ?? '');
      res.add(ingredient);
    }
    return res;
  }
}
