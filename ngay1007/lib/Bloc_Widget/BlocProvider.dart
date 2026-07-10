/*
  1. BlocProvider
  BlocProvider dùng để cung cấp (dependency injection) một instance của BLoC/Cubit cho toàn bộ cây widget con.
 */
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../BLoc_Event_based/counter/bloc/counter_bloc.dart';

/*  BlocProvider – Cung cấp BLoC/Cubit cho cây Widget
  BlocProvider là widget dùng để tạo và cung cấp một instance của BLoC hoặc Cubit
  cho tất cả các widget con trong cây.
  Nó đảm bảo rằng mỗi BLoC chỉ được khởi tạo một lần và tồn tại trong phạm vi được bao bọc.
  Tham số	Mô tả
  - create: Hàm tạo BLoC/Cubit. Chỉ gọi một lần khi widget được mount.
  - lazy: Mặc định true – BLoC chỉ được khởi tạo khi có widget con gọi context.read<T>() hoặc context.watch<T>().
  Nếu false, BLoC được khởi tạo ngay.
  - child: Widget con sẽ nhận được BLoC.
 */

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Cung cấp một BLoC
    // return BlocProvider(
    //   create: (context) => CounterBloc(),
    //   child: MyHomePage(),
    // );

    // Cung cấp nhiều BLoC
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CounterBloc()),
        // BlocProvider(create: (context) => TodoBloc()),
        // BlocProvider(create: (context) => AuthBloc()),
      ],
      child: MyHomePage(),
    );
  }
}
