/*
  Bài 2.1: Form đăng ký đơn giản
  Yêu cầu: Tạo một form đăng ký với 3 trường: Họ tên, Email, Mật khẩu.
  Tất cả đều bắt buộc, email phải có định dạng hợp lệ (chứa '@'), mật khẩu tối thiểu 6 ký tự.
  Khi nhấn nút "Đăng ký", nếu hợp lệ, in ra màn hình console thông tin đã nhập, nếu không hiển thị lỗi.
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bài tập 2.1'),
        backgroundColor: Colors.lightGreen,
      ),

      body: Form(
        key: _key,
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
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) return 'Email sai định dạng';
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
                    borderSide: BorderSide(color: Colors.lightGreen)
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(color: Colors.lightGreen, width: 2)
                  ),

                  prefixIcon: Icon(Icons.lock_outline, color: Colors.lightGreen,),

                  suffixIcon: IconButton(
                    focusNode: FocusNode(skipTraversal: true),
                      onPressed: () {
                        setState(() {
                          _showPassword = !_showPassword;
                        });
                      },
                      icon: Icon( _showPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: Colors.lightGreen,)
                  ),
                ),
                obscureText: !_showPassword,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Hãy nhập mật khẩu!';
                  if (value.length < 6) return 'Mật khẩu phải có tối thiếu 6 ký tự!';
                  return null;
                },
              ),
              
              // Nut xac nhan
              ElevatedButton(
                  onPressed: () {
                    if (_key.currentState!.validate()) {
                      _key.currentState!.save();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Đăng nhập thành công với tên: ${_nameController.text} - email: ${_emailController.text} - MK: ${_passwordController.text})'))
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightGreen,
                  ),
                  child: Text('Xác nhận', style: TextStyle(fontSize: 24, color: Colors.white),)
              )
            ],
          ),
        ),
      ),
    );
  }
}
