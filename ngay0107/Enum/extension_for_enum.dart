// Dart cũ hơn 2.17 hoặc muốn thêm chức năng vào một Enum được cung cấp bởi thư viện bên thứ ba mà không thể sửa code gốc
// --> có thể dùng extension:

enum Status { loading, success, error }

extension StatusExtension on Status {
  String get errorMessage {
    if (this == Status.error) {
      return 'Đã xảy ra lỗi hệ thống!';
    }
    return '';
  }
}

void main() {
  var state = Status.error;
  print(state.errorMessage);
}
