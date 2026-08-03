class ListResponse<T> {
  final List<T> meals;

  ListResponse({required this.meals});

  factory ListResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    final list = json['meals'] as List;
    return ListResponse(
      meals: list.map((e) => fromJson(e as Map<String, dynamic>)).toList(),
    );
  }
}
