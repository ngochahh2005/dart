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
  final List<String> _cities = [
    'Ha Noi',
    'TPHCM',
    'Da Nang',
    'Can Tho',
    'Hai Phong',
  ];
  String? _selectedCity;

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

              DropdownButtonFormField(
                decoration: InputDecoration(
                  labelText: 'Thanh pho',
                  border: OutlineInputBorder(),
                ),
                items: _cities.map((city) {
                  return DropdownMenuItem(child: Text(city), value: city);
                }).toList(),
                onChanged: (value) {},
                value: _selectedCity,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Vui long chon thanh pho';
                  return null;
                },
              ),

              SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
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
