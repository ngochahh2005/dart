import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ngay1607/bai_tap/models/post.dart';

class ApiServices {
  final baseUrl = 'https://jsonplaceholder.typicode.com';
  Future<List<Post>> getPosts() async {
    final resp = await http.get(Uri.parse('$baseUrl/posts'));
    if (resp.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(resp.body);
      return jsonList.map((json) => Post.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }
}