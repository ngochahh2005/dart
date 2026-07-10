import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
// import 'Cubit/BLoC_Cubit.dart';
// import 'Cubit/BLoC_Cubit_CounterScreen.dart';
import 'BLoc_Event_based/counter/counter_screen.dart';
import 'BLoc_Event_based/counter/bloc/counter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter App',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      // Cung cấp (Provide) Cubit
      // Sử dụng BlocProvider để đưa Cubit vào cây widget.
      // home: BlocProvider(
      //   create: (context) => CounterCubit(),
      //   child: const CounterScreen(),
      // ),

      home: BlocProvider(create: (context) => CounterBloc(), child: const CounterScreen(),),
    );
  }
}
