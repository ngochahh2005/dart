import 'package:freezed_annotation/freezed_annotation.dart';

part 'cat_breed.freezed.dart';

part 'cat_breed.g.dart';

@freezed
abstract class CatBreed with _$CatBreed {
  const factory CatBreed({
    required String id,
    required String name,
    String? referenceImageId,
    String? temperament,
    String? origin,
    String? lifeSpan,
    String? description,
  }) = _CatBreed;

  factory CatBreed.fromJson(Map<String, dynamic> json) => _$CatBreedFromJson(json);
}
