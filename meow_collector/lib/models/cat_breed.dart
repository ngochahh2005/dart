import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meow_collector/core/constants/api_endpoints.dart';

part 'cat_breed.freezed.dart';

part 'cat_breed.g.dart';

@freezed
abstract class CatBreed with _$CatBreed {
  const CatBreed._();

  const factory CatBreed({
    required String id,
    required String name,
    @JsonKey(name: 'reference_image_id') String? referenceImageId,
    String? temperament,
    String? origin,
    @JsonKey(name: 'life_span') String? lifeSpan,
    String? description,
  }) = _CatBreed;

  String? get thumbnailUrl {
    if (referenceImageId == null || referenceImageId!.isEmpty) return null;
    return ApiEndpoints.getThumbnailUrl(referenceImageId!);
  }

  factory CatBreed.fromJson(Map<String, dynamic> json) => _$CatBreedFromJson(json);
}
