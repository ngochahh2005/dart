import 'package:flutter/material.dart';

class WrapWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _WrapWidgetState();
}

class _WrapWidgetState extends State<WrapWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wrap Widget'),
        backgroundColor: Colors.limeAccent,
      ),

      body: Center(
        child: Wrap(
          direction: Axis.vertical, // tuong tu column
          runSpacing: 50, // khoang cach giua cac dong bi cat ra
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.spaceBetween,
          children: [
            MyContainer(),
            MyContainer(),
            MyContainer(),
            MyContainer(),
            MyContainer(),
            MyContainer(),
            MyContainer(),
            MyContainer(),
            MyContainer(),
            MyContainer(),
            MyContainer(),
            MyContainer(),
            MyContainer(),
            MyContainer(),
            MyContainer(),
            MyContainer(),
            MyContainer(),
          ],
        ),
      ),
    );
  }
}

class MyContainer extends StatelessWidget {
  const MyContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.all(5),
      width: 80,
      height: 80,
      color: Colors.green,
    );
  }
}