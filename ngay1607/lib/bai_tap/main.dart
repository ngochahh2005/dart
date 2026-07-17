/*
  Xây dựng một ứng dụng Flutter đơn giản hiển thị danh sách các bài viết (posts) lấy từ API:
  - Mỗi bài viết gồm: id, userId, title, body.
  - Dùng http để gọi API.
  - Sử dụng freezed + json_serializable để tạo model Post.
  - Hiển thị danh sách dạng ListView.
  - Có trạng thái loading và xử lý lỗi cơ bản.
 */

import 'package:flutter/material.dart';
import 'package:ngay1607/bai_tap/models/post.dart';
import 'package:ngay1607/bai_tap/services/api_services.dart';

void main() {
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _apiService = ApiServices();
  List<Post> _posts = [];
  bool _isLoading = false;
  String _errorMsg = '';

  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bai tap')),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _errorMsg.isNotEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('error: $_errorMsg'),
                  ElevatedButton(onPressed: _loadPosts, child: Text('Thu lai')),
                ],
              ),
            )
          : ListView.builder(
              itemCount: _posts.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: ListTile(
                    title: Text(_posts[index].title),
                    subtitle: Text(_posts[index].body),
                  ),
                );
              },
            ),
    );
  }

  Future<void> _loadPosts() async {
    setState(() {
      _isLoading = true;
      _errorMsg = '';
    });

    try {
      final posts = await _apiService.getPosts();
      setState(() {
        _posts = posts;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMsg = e.toString();
      });
    }
  }
}
