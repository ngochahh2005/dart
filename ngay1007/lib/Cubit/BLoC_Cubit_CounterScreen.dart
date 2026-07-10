import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngay1007/Cubit/BLoC_Cubit.dart';

class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Count with Cubit'),
        backgroundColor: Colors.lime,
      ),

      body: Center(
        // Sử dụng (Consume) Cubit
        // Sử dụng BlocBuilder để lắng nghe thay đổi và cập nhật UI.
        child: BlocBuilder<CounterCubit, int>(
          builder: (context, count) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Bạn đã nhấn: $count', style: TextStyle(fontSize: 20)),
              ],
            );
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        spacing: 8,
        children: [
          FloatingActionButton(
            onPressed: () => context.read<CounterCubit>().increment(),
            child: Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: () => context.read<CounterCubit>().decrement(),
            child: Icon(Icons.remove),
          ),
          FloatingActionButton(
            onPressed: () => context.read<CounterCubit>().reset(),
            child: Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }
}
