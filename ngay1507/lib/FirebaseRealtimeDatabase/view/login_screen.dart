import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _key = GlobalKey<FormState>();
  final _authService = AuthService();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  bool _isLogin = true;
  bool _isLoading = false;
  bool _isShowPassword = false;

  Future<void> _submit() async {
    if (!_key.currentState!.validate()) return;
    setState(() => _isLoading = true);
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    User? user;
    if (_isLogin) {
      user = await _authService.login(email, password);
    } else {
      String name = _nameController.text.trim();
      user = await _authService.register(email, password, name);
    }
    setState(() => _isLoading = false);
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_isLogin ? 'Đăng nhập thất bại' : 'Đăng ký thất bại'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_isLogin ? 'Đăng nhập thành công' : 'Đăng ký thành công'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isLogin ? 'Đăng nhập' : 'Đăng ký',
          style: TextStyle(
            fontSize: 36,
            fontFamily: 'k2d',
            fontWeight: FontWeight.bold,
            color: Colors.green[900],
          ),
        ),
        backgroundColor: Colors.lightGreen,
      ),
      body: Form(
        key: _key,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 24,
            children: [
              if (!_isLogin)
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Tên hiển thị',
                    hintText: 'Nguyễn Văn A',
                    prefixIcon: Icon(Icons.person),
                    suffixIcon: IconButton(
                      focusNode: FocusNode(skipTraversal: true),
                      onPressed: () => setState(() => _nameController.clear()),
                      icon: Icon(Icons.clear),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tên đăng nhập không được để trống';
                    }
                    return null;
                  },
                  cursorColor: Colors.lightGreen[800],
                  textInputAction: TextInputAction.next,
                ),

              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'example123@gmail.com',
                  prefixIcon: Icon(Icons.email_outlined),
                  suffixIcon: IconButton(
                    onPressed: () => setState(() => _emailController.clear()),
                    icon: Icon(Icons.clear),
                    focusNode: FocusNode(skipTraversal: true),
                  ),
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Email không được để trống';
                  final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                  if (!regex.hasMatch(value)) return 'Email không hợp lệ';
                  return null;
                },
                cursorColor: Colors.lightGreen[800],
              ),

              TextFormField(
                controller: _passwordController,
                obscureText: !_isShowPassword,
                decoration: InputDecoration(
                  labelText: 'Mật khẩu',
                  hintText: 'Mật khẩu phải có tối thiểu 8 ký tự',
                  prefixIcon: Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    focusNode: FocusNode(skipTraversal: true),
                    onPressed: () => setState(() {
                      _isShowPassword = !_isShowPassword;
                    }),
                    icon: Icon(
                      _isShowPassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                    ),
                  ),
                ),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Mật khẩu không được bỏ trống';
                  if (value.length < 8)
                    return 'Mật khẩu phải có tối thiểu 8 ký tự';
                  return null;
                },
                cursorColor: Colors.lightGreen[800],
              ),

              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _submit,
                      child: Text(_isLogin ? 'Đăng nhập' : 'Đăng ký'),
                    ),

              TextButton(
                onPressed: () {
                  setState(() {
                    _isLogin = !_isLogin;
                    _nameController.clear();
                  });
                },
                child: Text(
                  _isLogin
                      ? 'Chưa có tài khoản? Đăng ký ngay'
                      : 'Đã có tài khoản? Đăng nhập ngay',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
