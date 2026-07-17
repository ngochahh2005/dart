import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';
import '../models/post.dart';

class ApiService {
  final baseUrl = 'https://jsonplaceholder.typicode.com';

  // lay danh sach user tu api
  Future<List<User>> getUsers() async {
    final resp = await http.get(Uri.parse('$baseUrl/users'));
    if (resp.statusCode == 200) {
      // parse json array
      List<dynamic> jsonList = jsonDecode(resp.body);
      // dung fromJson de chuyen tung phan tu --> User
      return jsonList.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  // lay danh sach post theo userId
  Future<List<Post>> getPosts(int userId) async {
    final resp = await http.get(Uri.parse('$baseUrl/posts?userId=$userId'));
    if (resp.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(resp.body);
      return jsonList.map((json) => Post.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }

  // lay user kem theo danh sach post cua ho
  Future<User> getUserWithPost(int userId) async {
    // goi song song 2 api
    final userFuture = http.get(Uri.parse('$baseUrl/users/$userId'));
    final postsFuture = http.get(Uri.parse('$baseUrl/posts?userId=$userId'));
    final resps = await Future.wait([userFuture, postsFuture]);

    if (resps[0].statusCode == 200 && resps[1].statusCode == 200) {
      final userJson = jsonDecode(resps[0].body);
      final postsJson = jsonDecode(resps[1].body) as List;

      // tao user tu json
      User user = User.fromJson(userJson);

      // parse danh sach Post
      List<Post> posts = postsJson.map((json) => Post.fromJson(json)).toList();

      // dung copyWith de tao ban sao User voi posts da duoc cap nhat
      return user.copyWith(posts: posts);
    } else {
      throw Exception('Failed to load user with posts');
    }
  }
}