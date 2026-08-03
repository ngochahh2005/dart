import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:recipeify/data/models/area.dart';
import 'package:recipeify/data/models/category_response.dart';
import 'package:recipeify/data/models/ingredient.dart';
import 'package:recipeify/data/models/list_response.dart';
import 'package:recipeify/data/models/meal.dart';
import 'package:retrofit/retrofit.dart';
import 'package:recipeify/core/constants/api_constants.dart';

import '../models/category.dart';

part 'api_client.freezed.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ApiClient {
  factory ApiClient(Dio dio, {String? baseUrl}) = _ApiClient;

  @GET('/search.php')
  Future<ListResponse<Meal>> searchMeals({@Query('s') String? s});

  @GET('/lookup.php')
  Future<ListResponse<Meal>> getMealById({@Query('i') String? i});

  @GET('/categories.php')
  Future<CategoryResponse> getCategories();

  @GET('filter.php')
  Future<ListResponse<Meal>> filterMeals({
    @Query('c') String? c,
    @Query('i') String? i,
    @Query('a') String? a,
  });

  @GET('list.php')
  Future<ListResponse<Category>> getCategoryList(@Query('c') String c);

  @GET('list.php')
  Future<ListResponse<Ingredient>> getIngredientList(@Query('i') String i);

  @GET('list.php')
  Future<ListResponse<Ingredient>> getAreaList(@Query('a') String a);
}

@Freezed(genericArgumentFactories: true)
abstract class ApiResponse<T> with _$ApiResponse<T> {
  const factory ApiResponse({
    required bool success,
    required String message,
    T? data,
  }) = _ApiResponse;

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$ApiResponseFromJson(json, fromJsonT);
}
