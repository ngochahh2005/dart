class ApiEndpoints {
  static const baseUrl = 'https://api.thecatapi.com/v1';

  static const breeds = '$baseUrl/breeds';

  static const imageSearch = '$baseUrl/images/search';

  static const cdnImageBase = 'https://cdn2.thecatapi.com/images';

  static String getThumbnailUrl(String referenceImageId) =>
      '$cdnImageBase/$referenceImageId.jpg';

  static String getImageSearchUrl({
    required String breedId,
    int limit = 1,
    String size = 'med',
  }) => '$imageSearch?breeds_ids=$breedId&limit=$limit&size=$size';
}
