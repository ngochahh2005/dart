import 'package:http/http.dart' as http;

// 3.2 Uri.parse()
// Tất cả các request đều cần một đối tượng Uri:

// Trong một dự án Flutter, chúng ta thường tách các API này ra một file riêng
// (thường đặt trong thư mục lib/services/api_service.dart) để dễ quản lý.
class ApiService {
  // Cach 1: Dung Uri.parse() - phu hop khi co san 1 link URL dai
  Future<void> fetchUserViaParse() async {
    final urlString = 'https://jsonplaceholder.typicode.com/users/1';
    final response = await http.get(Uri.parse(urlString));
    print('Respone status: ${response.statusCode}');
  }

  // Cach 2: Dung Uri.https() - phu hop khi api co cau truc ro rang (base url + path + query params)
  Future<void> fetchUserViaObject() async {
    // authority: domain, unencodedPath: duong dan, queryParameters: tham so loc
    final uri = Uri.https(
      'jsonplaceholder.typicode.com',  // domain
      '/users',                        // path
      {'id': '1'},                     // query: ?id=1
    );

    final respone = await http.get(uri);
    print('Respone data: ${respone.body}');
  }
}

void main() async {
  final api = ApiService();

  // await api.fetchUserViaParse();
  await api.fetchUserViaObject();
}

/*
  3.3 http.Response
  Khi request thành công, bạn nhận được một đối tượng http.Response chứa:
  - statusCode: mã trạng thái HTTP (200, 404, 500,...)
  - body: nội dung phản hồi dạng String (thường là JSON)
  - headers: các header trả về
 */