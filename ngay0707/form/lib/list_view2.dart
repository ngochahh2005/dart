import 'package:flutter/material.dart';

/// ListView là widget hiển thị danh sách các thành phần con theo chiều dọc (hoặc ngang) và hỗ trợ cuộn.
/// Nó tự động quản lý việc hiển thị chỉ các item nằm trong vùng nhìn thấy (lazy loading) để tối ưu hiệu năng.

class MyListView extends StatefulWidget {
  MyListView({super.key});

  @override
  State<StatefulWidget> createState() => _MyListViewState();
}

class _MyListViewState extends State<MyListView> {
  final List<String> _items = List.generate(100, (i) => 'Item $i');

  // ScrollController dung de dieu khien hoac theo doi vi tri cuon
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();

    //Lang nghe su kien cuon
    _scrollController.addListener(() {
      //Kiem tra neu da cuon den gan cuoi (cach day 100px)
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 100) {
        print('Dang tai them du lieu');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List view'),
        backgroundColor: Colors.yellow[200],
      ),
      
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Nut cuon ve dau trang
          FloatingActionButton(
              onPressed: () {
                _scrollController.animateTo(
                    0, // vi tri dau trang
                    duration: const Duration(seconds: 1), 
                    curve: Curves.easeInOut,
                );
              },
            child: const Icon(Icons.arrow_upward),
          ),
          
          SizedBox(height: 10),
          
          // Nut cuon den muc thu 30
          FloatingActionButton(
              onPressed: () {
                _scrollController.jumpTo(30 * 56);  // 56 la chieu cao uoc luong cua ListTile
              },
            child: Icon(Icons.skip_next),
          )
        ],
      ),
      
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
        child: Column(
          children: [
            Text('Tieu de'),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                shrinkWrap: true,
                itemCount: _items.length,
                itemBuilder: (context, index) =>
                    ListTile(title: Text('Item ${_items[index]}')),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
