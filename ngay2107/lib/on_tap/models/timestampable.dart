mixin Timestampable {
  DateTime createdAt = DateTime.now();
  String get age {
    final diff = DateTime.now().difference(createdAt);
    return '${diff.inDays} ngày tuổi';
  }
}