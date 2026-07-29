import 'package:freezed_annotation/freezed_annotation.dart';

part 'favorite_cat.freezed.dart';

part 'favorite_cat.g.dart';

@freezed
abstract class FavoriteCat with _$FavoriteCat {
  const factory FavoriteCat({
    required String id,
    required String breedName,
    required String imageUrl,
    required String breedType,
    int? createdAt,
  }) = _FavoriteCat;

  factory FavoriteCat.fromJson(Map<String, dynamic> json) => _$FavoriteCatFromJson(json);
}
