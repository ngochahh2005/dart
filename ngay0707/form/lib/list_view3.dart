import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

//tính năng "nhấn icon ở trên để nhảy đến item tương ứng ở dưới"

class MyListView extends StatefulWidget {
  MyListView({super.key});

  @override
  State<StatefulWidget> createState() => _MyListViewState();
}

class _MyListViewState extends State<MyListView> {
  final List<String> _items = List.generate(100, (i) => 'Item $i');

  final ItemScrollController _scrollController = ItemScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
                onPressed: () => _scrollController.scrollTo(index: 0, duration: Duration(seconds: 1)) ,
                icon: Icon(Icons.filter_1)
            ),
            IconButton(
                onPressed: () => _scrollController.scrollTo(index: 50, duration: Duration(seconds: 1)) ,
                icon: Icon(Icons.filter_5)
            )
          ],
        ),
        backgroundColor: Colors.yellow[200],
      ),
      
      body: ScrollablePositionedList.builder(
          itemCount: _items.length,
          itemScrollController: _scrollController,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('Item $index'),
            );
          }
      )
    );
  }

}
