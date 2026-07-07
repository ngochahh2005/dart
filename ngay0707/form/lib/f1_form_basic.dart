import 'package:flutter/material.dart';

class FormBasicDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FormBasicDemoState();
}

class _FormBasicDemoState extends State<FormBasicDemo> {
  //Sử dụng Global key để truy cập form
  final _formKey = GlobalKey<FormState>();
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

        /// Form là 1 Widget chứa và quản lý các trường nhập liệu
        /// Key: được sử dụng để truy cập vào trạng thái của Form
        /// Phương thức validate() kiểm tra tính hợp lệ của tất cả trường
        /// Phương thức save() gọi hàm ónaved của mỗi trường
        /// Phương thức reset() đặt lại giá trị của tất cả trường
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 20),

              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Ho va ten',
                  hintText: 'Nhap ho va ten cua ban',
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) {
                  _name = value;
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
                          SnackBar(content: Text('Xin chao $_name'))
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
                      }, child: Text('Reset')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
