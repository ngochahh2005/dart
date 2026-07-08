/*
  Bài 2.2: Form với tự động xác thực và nút Submit chỉ hoạt động khi hợp lệ
  Yêu cầu: Dùng form bài 2.1 nhưng thêm chức năng tự động xác thực khi người dùng nhập
    (autovalidateMode: AutovalidateMode.onUserInteraction).
  Nút "Đăng ký" chỉ được bật khi tất cả các trường hợp lệ
    (sử dụng onChanged của Form và setState).
 */
import 'package:flutter/material.dart';

class MyForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _key = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _showPassword = false;
  bool _isFormValid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bài tập 2.2'),
        backgroundColor: Colors.lightGreen,
      ),

      body: Form(
        key: _key,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: () {
          setState(() {
            _isFormValid = _key.currentState!.validate();
          });
        },
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            spacing: 24,
            children: [
              // ten
              TextFormField(
                controller: _nameController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: 'Họ tên',
                  hintText: 'Nhập họ tên của bạn!',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.lightGreen),
                    borderRadius: BorderRadius.circular(24),
                  ),

                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.lightGreen),
                    borderRadius: BorderRadius.circular(24),
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.lightGreen, width: 2),
                    borderRadius: BorderRadius.circular(24),
                  ),

                  prefixIcon: Icon(Icons.person, color: Colors.lightGreen),

                  suffixIcon: IconButton(
                    focusNode: FocusNode(skipTraversal: true),
                    onPressed: () {
                      setState(() {
                        _nameController.clear();
                      });
                    },
                    icon: Icon(Icons.clear, color: Colors.lightGreen),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Hãy nhập tên';
                  return null;
                },
              ),

              // email
              TextFormField(
                controller: _emailController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'example123@gmail.com',

                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.lightGreen),
                    borderRadius: BorderRadius.circular(24),
                  ),

                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(color: Colors.lightGreen),
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.lightGreen, width: 2),
                    borderRadius: BorderRadius.circular(24),
                  ),

                  prefixIcon: Icon(
                    Icons.email_outlined,
                    color: Colors.lightGreen,
                  ),
                  suffixIcon: IconButton(
                    focusNode: FocusNode(skipTraversal: true),
                    onPressed: () {
                      setState(() {
                        _emailController.clear();
                      });
                    },
                    icon: Icon(Icons.clear, color: Colors.lightGreen),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Hãy nhập email!';
                  if (!RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  ).hasMatch(value))
                    return 'Email sai định dạng';
                  return null;
                },
              ),

              // password
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Mật khẩu',
                  hintText: 'Mật khẩu phải có tối thiểu 6 ký tự',

                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.lightGreen),
                    borderRadius: BorderRadius.circular(24),
                  ),

                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(color: Colors.lightGreen),
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(color: Colors.lightGreen, width: 2),
                  ),

                  prefixIcon: Icon(
                    Icons.lock_outline,
                    color: Colors.lightGreen,
                  ),

                  suffixIcon: IconButton(
                    focusNode: FocusNode(skipTraversal: true),
                    onPressed: () {
                      setState(() {
                        _showPassword = !_showPassword;
                      });
                    },
                    icon: Icon(
                      _showPassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: Colors.lightGreen,
                    ),
                  ),
                ),
                obscureText: !_showPassword,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Hãy nhập mật khẩu!';
                  if (value.length < 6)
                    return 'Mật khẩu phải có tối thiếu 6 ký tự!';
                  return null;
                },
              ),

              // Nut xac nhan
              ElevatedButton(
                onPressed: _isFormValid
                    ? () {
                        _key.currentState!.save();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Đăng nhập thành công với tên: ${_nameController.text} - email: ${_emailController.text} - MK: ${_passwordController.text})',
                            ),
                          ),
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightGreen,
                ),
                child: Text(
                  'Xác nhận',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
