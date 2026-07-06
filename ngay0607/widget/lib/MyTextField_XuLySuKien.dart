import 'package:flutter/material.dart';

class MyTextField_XuLySuKien extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField_XuLySuKien> {
  final _textController = TextEditingController();
  String _inputText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App ve scaffold'),
        backgroundColor: Colors.lightGreen,
        elevation: 4,
        actions: [
          IconButton(
            onPressed: () {
              print('b1');
            },
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              print('b2');
            },
            icon: Icon(Icons.abc),
          ),
          IconButton(
            onPressed: () {
              print('b3');
            },
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),

      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 50),

              TextField(
                controller: _textController,
                decoration: InputDecoration(
                  labelText: 'Nhap thong tin',
                  hintText: 'Nhap thong tin cua ban',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                  suffixIcon: IconButton(
                    onPressed: () {
                      _textController.clear();
                    },
                    icon: Icon(Icons.clear),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _inputText = value;
                  });
                },
              ),

              SizedBox(height: 50,),

              Text('Ban da nhap: $_inputText', style: TextStyle(fontSize: 24),),
            ],
          ),
        ),
      ),
    );
  }
}
