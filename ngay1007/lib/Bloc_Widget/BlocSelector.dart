/* BlocSelector – Chọn một phần của State để rebuild
  1. Mục đích
  BlocSelector cho phép bạn chọn ra một phần dữ liệu từ State và chỉ rebuild widget khi phần đó thay đổi.
  Điều này giúp tối ưu hiệu năng đáng kể khi State có nhiều trường dữ liệu
  nhưng một widget chỉ cần một vài trường cụ thể.

 */

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:ngay1007/Bloc_Widget/BlocBuilder.dart';

class MyBlocSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<BlocType, StateType, String?>(
      // selector: Hàm nhận State và trả về một giá trị (có thể là một phần của State).
      selector: (state) => state.someField, // Hàm chọn dữ liệu
      // builder: Hàm nhận context và giá trị đã chọn, trả về widget.
      builder: (context, selected) {
        // selected là dữ liệu đã chọn
        return Text(selected.toString() ?? '');
      },
    );
  }
}

class SelectedType {
}