import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/*
  Thay vì sử dụng các Events (sự kiện) như Bloc, Cubit sử dụng các hàm (functions) để thay đổi trạng thái.
  Điều này giúp code ít boilerplate (mã lặp lại) hơn.

  1. Cấu trúc của một Cubit
  Cubit bao gồm hai phần chính:
  - Cubit Class: Nơi chứa logic xử lý.
  - State: Trạng thái của ứng dụng (có thể là một biến đơn giản, một enum hoặc một class).
 */

// Cubit class - tao cubit
class CounterCubit extends Cubit<int> {
  // Khoi tao gia tri ban dau la 0
  CounterCubit() : super(0);

  // Thay vi dung su kien ta dung ham truc tiep
  void increment() => emit(state + 1);
  void decrement() => emit(state - 1);
  void reset() => emit(0);
}