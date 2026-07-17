/*
  4. CÁC PHƯƠNG THỨC HTTP
 */

import 'dart:convert';
import 'package:http/http.dart' as http;

// 4.1 GET – Lấy dữ liệu
Future<Map<String, dynamic>> fetchUser(int id) async {
  final respone = await http.get(
    Uri.parse('https://jsonplaceholder.typicode.com/users/$id'),
  );

  if (respone.statusCode == 200) {
    return jsonDecode(respone.body) as Map<String, dynamic>;
  } else {
    throw Exception('Failed to load user: ${respone.statusCode}');
  }
}

// 4.2 POST – Tạo dữ liệu mới
Future<Map<String, dynamic>> createPost(String title, String body) async {
  final response = await http.post(
    Uri.parse('https://jsonplaceholder.typicode.com/posts'),
    headers: {'Content-Type': 'application/json; charset=UTF-8'},
    body: jsonEncode({'title': title, 'body': body, 'userId': 1}),
  );

  if (response.statusCode == 201) {
    // 201 = created
    return jsonDecode(response.body) as Map<String, dynamic>;
  } else {
    throw Exception('Failed to create post: ${response.statusCode}');
  }
}

// 4.3 PUT – Cập nhật toàn bộ
Future<Map<String, dynamic>> updatePost(int id, String newTitle) async {
  final response = await http.put(
    Uri.parse('https://jsonplaceholder.typicode.com/posts/$id'),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({
      'id': id,
      'title': newTitle,
      'body': 'Update body',
      'userId': 1
    })
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body) as Map<String, dynamic>;
  } else {
    throw Exception('Failed to update post: ${response.statusCode}');
  }
}

// 4.4 PATCH – Cập nhật một phần
Future<Map<String, dynamic>> patchPost(int id, newTitle) async {
  final response = await http.patch(
    Uri.parse('https://jsonplaceholder.typicode.com/posts/$id'),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({'title': newTitle})
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body) as Map<String, dynamic>;
  } else {
    throw Exception('Failed to patch post: ${response.statusCode}');
  }
}

// 4.5 DELETE – Xóa dữ liệu
Future<void> deletePost(int id) async {
  final response = await http.delete(Uri.parse('https://jsonplaceholder.typicode.com/posts/$id'));

  if (response.statusCode != 200) {
    throw Exception('Failed to delete post: ${response.statusCode}');
  } else {
    print('Xoa thanh cong id $id');
  }
}

void main() async {
  // for (int i = 1; i <= 10; i++) {
  //   final response = await fetchUser(i);
  //   print('User $i: ${response['name']}');
  // }

  // print(await createPost("test 1", "abcxyz I'm going to test http post"));

  // print(await updatePost(1, 'Title moi cua id 1'));

  // print(await patchPost(1, 'Title patch cua id 1'));

  await deletePost(1);
}
