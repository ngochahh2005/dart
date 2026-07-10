/*  BlocListener – Phản ứng với State thay đổi (một lần)
  1. Mục đích
  BlocListener dùng để lắng nghe các thay đổi State và thực hiện các hành động phụ (side effects) như:
  điều hướng màn hình, hiển thị SnackBar, show dialog, ghi log, v.v.
  Nó không rebuild UI mà chỉ chạy listener khi State thay đổi.

  2. Khi nào dùng?
  - Khi cần thực hiện hành động một lần khi State thay đổi (navigation, snackbar, dialog).
  - Khi muốn tách biệt rõ ràng giữa UI (hiển thị) và side effects.

  3. Lưu ý
  - Không dùng BlocListener để xây dựng UI (dùng BlocBuilder).
  - Nên kết hợp với BlocBuilder bằng cách đặt cả hai trong cùng một cây:
      BlocListener<AuthBloc, AuthState>(
      listener: (context, state) { ... },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) { ... },
      ),
    )
    hoặc dùng BlocConsumer để gộp cả hai
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'BlocBuilder.dart';

class MyBlocListener extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<BlocType, StateType>(
      // listener:	Bắt buộc. Hàm được gọi mỗi khi State thay đổi
      listener: (context, state) {
        // Thực hiện hành động dựa trên state
        if (state is AuthAuthenticated) {
          Navigator.pushReplacementNamed(context, '/home');
        }
      },

      // listenWhen:	Tùy chọn. Tương tự buildWhen, quyết định có gọi listener hay không.
      listenWhen: (previous, current) {
        return previous == current;
      },

      child: MyWidget(),
    );
  }
}

class MyWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

mixin AuthAuthenticated {
}