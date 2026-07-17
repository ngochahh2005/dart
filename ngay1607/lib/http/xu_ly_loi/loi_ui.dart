import 'package:flutter/material.dart';
import '../xu_ly_loi/cac_loi_thuong_gap.dart';
import 'package:ngay1607/http/xu_ly_response_va_model/models/post.dart';

class PostListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PostListPageState();
}

class _PostListPageState extends State<PostListPage> {
  List<Post> _posts = [];
  bool _isLoading = true;
  String? _errorMsg;

  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  Future<void> _loadPosts() async {
    setState(() {
      _isLoading = true;
      _errorMsg = null;
    });

    try {
      final posts = await ApiService().getPosts();
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

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMsg != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Loi: $_errorMsg'),
            ElevatedButton(onPressed: _loadPosts, child: Text('Thử lại')),
          ],
        ),
      );
    }

    return Scaffold(
      body: ListView.builder(
        itemCount: _posts.length,
        itemBuilder: (context, index) {
          final post = _posts[index];
          return ListTile(
            title: Text(post.title),
            subtitle: Text(post.body),
          );
        },
      ),
    );
  }
}

void main() {
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'HTTP In Flutter',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
      home: PostListPage()
    );
  }
}
