/*  BlocConsumer – Kết hợp Builder và Listener
  1. Mục đích
  BlocConsumer là sự kết hợp của BlocBuilder và BlocListener trong một widget duy nhất.
  Nó vừa xây dựng UI, vừa thực hiện side effects.

  2. Khi nào nên dùng BlocConsumer?
  - Khi bạn cần cả xây dựng UI và thực hiện side effects trên cùng một State.
  - Giúp code gọn gàng hơn so với việc lồng BlocListener bên ngoài BlocBuilder.

  3. Lưu ý
  - builder vẫn được gọi khi State thay đổi, ngay cả khi listener cũng được gọi.
  Hãy đảm bảo bạn không vi phạm nguyên tắc tách biệt (listener chỉ làm side effects, builder chỉ xây dựng UI).
  - Có thể dùng listenWhen và buildWhen độc lập để tối ưu.
 */

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:ngay1007/Bloc_Widget/BlocBuilder.dart';

class MyBlocConsumer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BlocType, StateType>(
      builder: (context, state) {
        // xay dung UI
        return Container();
      },
      listener: (context, state) {
        // xu ly side effects
      },
      listenWhen: (previous, current) => true, // tùy chọn
      buildWhen: (previous, current) => true, // tùy chọn
    );
  }
}
