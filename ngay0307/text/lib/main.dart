import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: Scaffold(
        body: MyApp()
    )
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
        'Hello 骨 World abcdefgh!',
      style: TextStyle(
        color: Color(0xffffffff),
        inherit: true,  //Quyet dinh xem kieu chu co ke thua cac thuoc tinh tu TextTheme (widget cha) khong
        backgroundColor: Color(0xff330066),
        decoration: TextDecoration.combine([
          TextDecoration.underline,
          TextDecoration.lineThrough,
          TextDecoration.overline
        ]),
        decorationColor: Colors.red,
        decorationStyle: TextDecorationStyle.wavy // kieu net ve (dut net, luon song...)
      ),

      textAlign: TextAlign.left,

      textDirection: TextDirection.ltr,

      softWrap: false,

      maxLines: 1,

      overflow: TextOverflow.ellipsis,
      
      textScaler: TextScaler.linear(1.2), // thu phong kick thuoc chu (trong vd: phong to 20%)
      
      locale: Locale('ja', 'JP')
    );
  }
}

