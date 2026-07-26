import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// class quan ly Bloc va StreamController don gian
class CounterBloc {
  final StreamController<int> _counterController = StreamController<int>();

  Stream<int> get stream => _counterController.stream;

  StreamSink<int> get _sink => _counterController.sink;

  int _cnt = 0;

  void incrementCounter() {
    _cnt++;
    _counterController.sink.add(_cnt);
  }

  void dispose() {
    _counterController.close();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StreamBuilder Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const CounterPage(),
    );
  }
}

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<StatefulWidget> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  late final CounterBloc _counterBloc;

  @override
  void initState() {
    super.initState();
    _counterBloc = CounterBloc();
  }

  @override
  void dispose() {
    _counterBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('StreamBuilder app'),
        backgroundColor: Colors.lightGreen,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Ban da an nut so lan: ', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            // tich hop StreamBuilder vao UI
            StreamBuilder<int>(
              stream: _counterBloc.stream, // truyen stream vao day
              initialData: 0, // du lieu khoi tao ban dau (tranh null)
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Text(
                    'Da xay ra loi: ${snapshot.error}',
                    style: TextStyle(color: Colors.red),
                  );
                }
                if (!snapshot.hasData) return Text('Khong co du lieu');
                return Text(
                  'Gia tri ${snapshot.data}',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        _counterBloc.incrementCounter();
      }, tooltip: 'Tang gia tri', child: Icon(Icons.add),),
    );
  }
}
