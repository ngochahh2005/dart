import 'dart:isolate';
import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(body: IsolateDemo()),
    );
  }
}

class IsolateDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ImageRotate(),
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 20),
              child: ElevatedButton(onPressed: () {
                // createNewIsolate();
                demoCompute();
              }, child: Text('click')),
            ),
          ),
        ],
      ),
    );
  }

  void demoCompute() async {
    var res = await compute(calculate, 7);
    print(res);
  }

  static int calculate(int n) {
    return n * 10;
  }
  
  void createNewIsolate() async {
    // thuộc không gian main isolate
    var receivePort = ReceivePort();
    var newIsolate = await Isolate.spawn(taskRunner, receivePort.sendPort);

    Future.delayed(Duration(seconds: 2), () {
      newIsolate.kill(priority: Isolate.immediate);
      print('New Isolate killed');
    });

    receivePort.listen((msg) {
      print(msg[0]);
      if (msg[1] is SendPort) {
        msg[1].send('From Main Isolate');
      }
    });
  }

  // Isolate.spawn(entryPoint, message)
  // entryPoint: la 1 static function/top function
  // message: tham so cua entryPoint
  static void taskRunner(SendPort sendPort) {
    // thuộc không gian new isolate
    var receivePort = ReceivePort();
    receivePort.listen((msg) {
      print(msg);
    });

    receivePort.close();

    var s = 0;
    for (var i = 1; i <= 1000000000; i++) {
      s += i;
    }
    sendPort.send([s, receivePort.sendPort]);
  }
}

class ImageRotate extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ImageRotateState();
}

class _ImageRotateState extends State<ImageRotate>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: _controller.value * 2 * math.pi,
          child: child,
        );
      },
      child: Image.asset(
        'assets/images/chong_chong.png',
        width: 150,
        height: 150,
      ),
    );
  }
}
