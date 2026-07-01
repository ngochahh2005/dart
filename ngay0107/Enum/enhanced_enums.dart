///Kể từ phiên bản Dart 2.17, Enum được nâng cấp mạnh mẽ để có thể hoạt động gần giống như một Class (Lớp).
///Tức là Enum giờ đây có thể chứa thuộc tính (fields), phương thức (methods), và hàm khởi tạo (constructors).

enum HttpType {
  // 1. Khai báo các giá trị và truyền tham số cho chúng
  get('GET', 200),
  post('POST', 201),
  put('PUT', 200);

  // 2. Khai báo các thuộc tính (phải là final) (do tính chất bất di bất dịch)
  final String method;
  final int successCode;

  // 3. Hàm khởi tạo (bắt buộc phải có từ khóa const)
  const HttpType(this.method, this.successCode);

  // 4. Có thể viết thêm các phương thức (methods)
  bool isSuccess(int code) {
    return code == successCode;
  }
}

void main() {
  var request = HttpType.post;
  print(request.method);          // Output: POST
  print(request.successCode);     // Output: 201
  print(request.isSuccess(404));  // Output: false
}
