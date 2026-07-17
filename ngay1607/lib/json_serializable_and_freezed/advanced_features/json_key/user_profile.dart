/*
  Ví dụ chi tiết: Ánh xạ dữ liệu API phức tạp
  Giả sử bạn làm việc với một API trả về thông tin người dùng với cấu trúc đặt tên kiểu "cổ điển"
  (thường thấy ở các hệ thống cũ hoặc API viết bằng PHP/Python cũ):
  Dữ liệu từ API:
  JSON
  {
    "usr_id": 101,
    "usr_full_name": "Nguyen Van A",
    "is_active_status": true,
    "contact_email_addr": "nguyenvana@example.com"
  }
  Cách bạn viết Model trong Dart để code sạch sẽ hơn:
 */

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile.freezed.dart';

part 'user_profile.g.dart';

@freezed
class UserProfile with _$UserProfile {
  const factory UserProfile({
    // map 'usr_id' tu JSON vao bien 'id'
    @JsonKey(name: 'usr_id') required int id,
    @JsonKey(name: 'usr_full_name') required String fullName,
    @JsonKey(name: 'is_active_status') required bool isActive,
    @JsonKey(name: 'contact_email_address') required String email,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) => _$UserProfileFromJson(json);
}