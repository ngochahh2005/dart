import 'package:flutter/material.dart';
import 'models/user.dart';
import 'services/api_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Freezed + JSON Serializable Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const UserListScreen(),
    );
  }
}

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  final ApiService _apiService = ApiService();
  List<User> _users = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    setState(() => _isLoading = true);
    try {
      final users = await _apiService.getUsers();
      setState(() => _users = users);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadUsers,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _users.length,
        itemBuilder: (context, index) {
          final user = _users[index];
          return ListTile(
            title: Text(user.name),
            subtitle: Text(user.email),
            trailing: Text('Posts: ${user.posts.length}'),
            onTap: () => _navigateToUserDetail(user),
          );
        },
      ),
    );
  }

  void _navigateToUserDetail(User user) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserDetailScreen(user: user),
      ),
    );
  }
}

class UserDetailScreen extends StatefulWidget {
  final User user;
  const UserDetailScreen({super.key, required this.user});

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  final ApiService _apiService = ApiService();
  late User _user;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _user = widget.user;
    _loadUserDetail();
  }

  Future<void> _loadUserDetail() async {
    try {
      final fullUser = await _apiService.getUserWithPost(widget.user.id);
      setState(() {
        _user = fullUser;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading posts: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_user.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Email: ${_user.email}'),
            const SizedBox(height: 8),
            Text('Phone: ${_user.phone ?? 'N/A'}'),
            const Divider(),
            const Text(
              'Posts:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _user.posts.isEmpty
                      ? const Center(child: Text('No posts yet'))
                      : ListView.builder(
                          itemCount: _user.posts.length,
                          itemBuilder: (context, index) {
                            final post = _user.posts[index];
                            return Card(
                              child: ListTile(
                                title: Text(post.title),
                                subtitle: Text(post.body),
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
