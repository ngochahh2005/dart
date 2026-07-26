import 'package:flutter/material.dart';
import '../../services/secure_storage_service.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final SecureStorageService _storageService = SecureStorageService();

  LoginScreen({super.key});

  void _handleLogin(BuildContext context) async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    // Giả lập logic kiểm tra đăng nhập (Bỏ qua backend thật)
    if (username.isNotEmpty && password.isNotEmpty) {
      String fakeToken = "fake_jwt_token_${DateTime.now().millisecondsSinceEpoch}";

      // Lưu token bảo mật
      await _storageService.saveAuthToken(fakeToken);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Đăng nhập thành công! Đã lưu Token.')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng nhập Username và Password')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => _handleLogin(context),
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}