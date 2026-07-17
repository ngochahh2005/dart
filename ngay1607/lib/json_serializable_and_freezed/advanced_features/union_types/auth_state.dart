/*
  Ví dụ chi tiết: Quản lý trạng thái đăng nhập
  Giả sử bạn có 5 trạng thái đăng nhập khác nhau.
  Với Freezed, bạn định nghĩa như sau:
 */
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ngay1607/json_serializable_and_freezed/models/user.dart';
part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial; // moi khoi dong
  const factory AuthState.loading() = _Loading; // dang cho API
  const factory AuthState.authenticated(User user) = _Authenticated;  // da dang nhap
  const factory AuthState.unauthenticated() = _Unauthenticated; // chua dang nhap
  const factory AuthState.error(String message) = _Error; // co loi xay ra
}