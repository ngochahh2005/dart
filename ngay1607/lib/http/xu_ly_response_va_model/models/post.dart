// 5. XỬ LÝ RESPONSE VÀ MODEL
// 5.1 Tạo Model class

class Post {
  final int id;
  final int userId;
  final String title;
  final String body;

  Post({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
  });

  // factory constructor: chuyển đổi" từ JSON (thường nhận từ Server) sang đối tượng Post.
  factory Post.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id':  int id,
        'userId': int userId,
        'title': String title,
        'body': String body
      } => Post(id: id, userId: userId, title: title, body: body),
    _ => throw const FormatException('Failed to load post') // loi du lieu khong hop le
    };
  }

  // chuyen post --> json (cho post/put)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'body': body
    };
  }

  @override
  String toString() {
    return "(id: $id - title: $title)\n";
  }


}
