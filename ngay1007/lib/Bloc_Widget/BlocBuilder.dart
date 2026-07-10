import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

/*  BlocBuilder – Xây dựng UI dựa trên State
  1. Mục đích
  BlocBuilder lắng nghe các thay đổi State của BLoC và rebuild lại widget mỗi khi State thay đổi.
  Đây là widget phổ biến nhất để hiển thị dữ liệu từ BLoC lên giao diện.

  2. Khi nào dùng?
  - Khi bạn muốn hiển thị dữ liệu từ BLoC.
  - Khi bạn muốn widget tự động cập nhật khi State thay đổi.

  3. Lưu ý
  - Không dùng BlocBuilder để thực hiện các hành động như navigation, show dialog (dùng BlocListener thay thế).
  - Nên sử dụng buildWhen khi State có nhiều trường nhưng bạn chỉ quan tâm đến một vài trường cụ thể, tránh rebuild không cần thiết.
 */

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlocType, StateType>(
      // builder: Bắt buộc. Hàm nhận context và state, trả về widget.
      // Được gọi mỗi khi state thay đổi.
      builder: (context, state) {
        // Trả về widget tương ứng với state
        return Text('Giá trị: ${state.value}');
      },

      // buildWhen: Tùy chọn. Hàm nhận previous và current, trả về bool.
      // Nếu true thì builder được gọi, ngược lại thì không.
      // Giúp tối ưu hiệu năng.
      buildWhen: (previos, current) {
        // Chỉ rebuild khi giá trị thay đổi, bỏ qua các thay đổi không liên quan
        return previos.value != current.value;
      },
    );
  }
}

class StateType {
  final int value;
  String? someField;
  StateType({required this.value, this.someField});
  @override
  List<Object?> get props => [value, someField]; // Giúp Bloc so sánh state
}

class BlocType extends Bloc<MyEvent, StateType> {

  BlocType() : super(StateType(value: 0)) {
    on<Increment>((event, emit) => emit(StateType(value: state.value + 1)));
  }
}

abstract class MyEvent {}
class Increment extends MyEvent{}