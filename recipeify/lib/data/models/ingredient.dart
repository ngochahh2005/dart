import 'package:freezed_annotation/freezed_annotation.dart';

part 'ingredient.freezed.dart';
part 'ingredient.g.dart';

@freezed
abstract class Ingredient with _$Ingredient {
  const factory Ingredient({
    @JsonKey(name: 'idIngredient') String? id,
    @JsonKey(name: 'strIngredient') required String name,
    @JsonKey(name: 'strDescription') String? description,
    String? measure,
    @JsonKey(name: 'strThumb') String? url,
    @JsonKey(name: 'strType') String? type,
  }) = _Ingredient;

  factory Ingredient.fromJson(Map<String, dynamic> json) => _$IngredientFromJson(json);
}
