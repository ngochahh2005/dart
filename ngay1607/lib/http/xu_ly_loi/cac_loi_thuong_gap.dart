import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../xu_ly_response_va_model/models/post.dart';

class ApiService {
  Future<List<Post>> getPosts() async {
    try {
      final resp = await http.get(
          Uri.parse('https://jsonplaceholder.typicode.com/posts')).timeout(
          const Duration(seconds: 10)); // timeout sau 10s

      if (resp.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(resp.body);
        return jsonList.map((json) => Post.fromJson(json)).toList();
      } else {
        // loi tu server
        throw HttpException('Server error: ${resp.statusCode}');
      }
    } on SocketException {
      // mat ket noi mang
      throw NetworkException('No internet connection');
    } on TimeoutException {
      // request cho qua thoi gian
      throw TimeoutException('Request timeout');
    } on FormatException {
      // json parse loi
      throw ParseException('Invalid data format');
    } catch (e) {
      // loi khong xac dinh
      throw UnknownException('Unknown error: $e');
    }
  }
}

// dinh nghia cac exception tuy chinh
class HttpException implements Exception {
  final String msg;
  HttpException(this.msg);
}

class NetworkException implements Exception {
  final String msg;
  NetworkException(this.msg);
}

class TimeoutException implements Exception {
  final String msg;
  TimeoutException(this.msg);
}

class ParseException implements Exception {
  final String msg;
  ParseException(this.msg);
}

class UnknownException implements Exception {
  final String msg;
  UnknownException(this.msg);
}