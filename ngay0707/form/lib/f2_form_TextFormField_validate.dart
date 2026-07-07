import 'package:flutter/material.dart';

class FormBasicDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FormBasicDemoState();
}

class _FormBasicDemoState extends State<FormBasicDemo> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  String? _name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form co ban'),
        backgroundColor: Colors.lightGreen,
      ),

      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 16),

        child: Form(
          key: _formKey,
          child: Column(
            /// TextFormField là phiên bản mở rộng của TextField tích hợp Form
            /// Validator là hàm kiểm tra tính hợp lệ của dữ liệu
            /// Controller cho phép truy vập và điều khiển giá trị bên trong
            /// obscureText cho phép ẩn văn bản (mật khẩu)
            /// AutovalidateMode điểu khiển thời điểm validation được kích hoạt
            children: [
              SizedBox(height: 20),

              TextFormField(
                controller: _fullNameController,
                decoration: InputDecoration(
                  labelText: 'Ho va ten',
                  hintText: 'Nhap ho va ten cua ban',
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) {
                  _name = value;
                },
                validator: (value) {
                  // Null: khong co gi het, empty: chuoi rong
                  if (value == null || value.isEmpty) {
                    return 'Vui long nhap ho va ten';
                  }
                  return null;
                },
              ),

              SizedBox(height: 20),

              //Email TextField
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Example@gmail.com',
                  prefixIcon: Icon(Icons.email_outlined),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui long nhap email!';
                  }
                  if (!RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  ).hasMatch(value)) {
                    return 'Email khong hop le';
                  }
                  return null;
                },
              ),

              SizedBox(height: 20),

              // Password TextFormField
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Mat khau',
                  hintText: 'Nhap mat khau',
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        //setState: làm thay đổi giá trị đồng thời build lại giao diện chương trình
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                    icon: _obscurePassword
                        ? Icon(Icons.visibility_outlined)
                        : Icon(Icons.visibility_off_outlined),
                  ),
                  border: OutlineInputBorder(),
                ),
                obscureText: _obscurePassword ? true : false,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui long nhap mat khau';
                  }
                  if (value.length < 6)
                    return 'Mat khau phai co it nhat 6 ky tu';
                  return null;
                },
              ),

              SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      /// Có thể thông qua biến _formKey để truy cập dữ liệu bên trong
                      /// Từ currentState có thể lấy tất cả mọi thứ (có thể null --> cần khẳng định không null)
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Xin chao $_name')),
                        );
                      }
                    },
                    child: Text('Submit'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _formKey.currentState!.reset();
                      setState(() {
                        _name = null;
                      });
                    },
                    child: Text('Reset'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
