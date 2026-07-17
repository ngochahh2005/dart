import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/post.dart';

class ApiService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  // lay danh sach posts
  Future<List<Post>> getPosts() async {
    final response = await http.get(Uri.parse('$baseUrl/posts'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Post.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load posts: ${response.statusCode}');
    }
  }

  // lay 1 post theo id
  Future<Post> getPost(int id) async {
    final resp = await http.get(Uri.parse('$baseUrl/posts/$id'));

    if (resp.statusCode == 200) {
      return Post.fromJson(jsonDecode(resp.body) as Map<String, dynamic>);
    } else {
      throw Exception('Faild to load post $id: ${resp.statusCode}');
    }
  }
}