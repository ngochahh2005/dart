import 'package:freezed_annotation/freezed_annotation.dart';
import 'post.dart';

// bat buoc phai co de Freezed va json_serializable hoat dong
part 'user.freezed.dart';
part 'user.g.dart';

// @freezed: đánh dấu class này sẽ được Freezed xử lý.
@freezed
class User with _$User {
  // _$User là mixin sẽ được sinh ra bởi Freezed, chứa các phương thức như copyWith, toJson...
  // factory constructor: dinh nghia cac thuoc tinh cua class

  const factory User({
    required int id,
    required String name,
    required String email,
    String? phone,
    // @Default([]): Gán giá trị mặc định nếu JSON không có field này
    @Default([]) List<Post> posts, // gan gia tri mac dinh la danh sach rong
  }) = _User; // _User là tên class implementation sẽ được sinh ra

  // factory User.fromJson(...): Phương thức để tạo object từ JSON. Freezed sẽ sinh code trong user.g.dart
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
