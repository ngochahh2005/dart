import 'package:recipeify/data/models/category_response.dart';

import '../models/category.dart';
import '../models/meal.dart';
import '../network/api_client.dart';

class MealRepository {
  final ApiClient _apiClient;

  MealRepository(this._apiClient);

  Future<List<Meal>> searchMeals(String query) async {
    try {
      final resp = await _apiClient.searchMeals(s: query);
      return resp.meals;
    } catch (e) {
      throw Exception('Không thể tìm thấy món ăn: ${e.toString()}');
    }
  }

  Future<Meal?> getMealById(String id) async {
    try {
      final resp = await _apiClient.getMealById(i: id);
      return resp.meals.isNotEmpty == true ? resp.meals.first : null;
    } catch (e) {
      throw Exception('Không thể lấy chi tiết món ăn');
    }
  }

  Future<List<Category>> getCategories() async {
    try {
      final resp =  await _apiClient.getCategories();
      return resp.categories;
    } catch (e) {
      throw Exception('Không thể tải danh mục: ${e.toString()}');
    }
  }

  Future<List<Meal>> filterMeals({String? category, String? ingredient, String? area}) async {
    try {
      final resp = await _apiClient.filterMeals(c: category, i: ingredient, a: area);
      return resp.meals;
    } catch (e) {
      throw Exception('Không thể lọc: ${e.toString()}');
    }
  }
}