import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({super.key});

  @override
  Widget build(BuildContext context) {
    // Tra ve Scaffold - widget cung cap bo cuc Material design co ban
    // La 1 cai man hinh
    return Scaffold(
      // Tieu de cua ung dung
      appBar: AppBar(
        // tieu de
        title: Text('App ve scaffold'),
        // nen cua appbar
        backgroundColor: Colors.lightGreen,
        // do nang/do bong cua appbar
        elevation: 4,
        // cac nut nhan
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
        child: Column(
          children: [
            SizedBox(height: 50,),

            /// TextField là Widget cho phép người dùng nhập văn bản thông qua bàn phím
            /// Đây là thành phần thiết yếu trong hầu hết các ứng dụng, từ biểu mẫu đăng nhập, tìm kiếm, đến nhập liệu trong các ứng dụng phức tạp
            TextField(
              decoration: InputDecoration(
                labelText: 'Ho va ten',
                hintText: 'Nhap vao ho va ten cua ban',
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 50,),

            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'Example@gmail.com',
                helperText: 'Nhap vao email ca nhan',
                prefixIcon: Icon(Icons.email),
                suffixIcon: Icon(Icons.clear),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                filled: true,
                fillColor: Colors.lightGreen
              ),
              keyboardType: TextInputType.emailAddress,
            ),

            SizedBox(height: 50,),

            TextField(
              decoration: InputDecoration(
                labelText: 'So dien thoai',
                hintText: 'Nhap vao so dien thoai cua ban',
                prefixIcon: Icon(Icons.phone),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),

            SizedBox(height: 50,),

            TextField(
              decoration: InputDecoration(
                labelText: 'Ngay sinh',
                hintText: 'Nhap vao ngay sinh cua ban',
                prefixIcon: Icon(Icons.calendar_month_outlined),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.datetime,
            ),

            SizedBox(height: 50,),
            TextField(
              decoration: InputDecoration(
                labelText: 'Mat khau',
              ),
              obscureText: true,
              // obscuringCharacter: '*',
            ),

            SizedBox(height: 50,),
            TextField(
              onChanged: (value) {
                print('Dang nhap: $value');
              },
              onSubmitted: (value) {
                print('Da hoan thanh noi dung: $value');
              },
              decoration: InputDecoration(
                labelText: 'Cau hoi bi mat',
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('pressed');
        },
        child: const Icon(Icons.add_ic_call),
      ),

      // Thanh dieu huong phia duoi
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Trang chu'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Tim kiem'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Ca nhan'),
        ],
      ),
    );
  }
}
