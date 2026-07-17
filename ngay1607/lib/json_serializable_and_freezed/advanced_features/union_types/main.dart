import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ngay1607/json_serializable_and_freezed/advanced_features/union_types/auth_state.dart';

import '../../models/user.dart';

void main() {
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: AuthScreen());
  }
}

class AuthScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  // dung ValueNotifier de luu tru trang thai AuthState
  final _authState = ValueNotifier(AuthState.initial());

  void _simulateLogin() async {
    // chuyen sang trang thai loading
    _authState.value = AuthState.loading();
    await Future.delayed(Duration(seconds: 2));

    // chuyen sang trang thai authenticated sau khi "dang nhap" xong
    _authState.value = AuthState.authenticated(
      User(id: 1, name: 'Nguyen Van A', email: 'a@gmail.com'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Freezed AuthState')),
      body: Center(
        child: ValueListenableBuilder<AuthState>(
          valueListenable: _authState,
          builder: (context, state, child) {
            return state.when(
              initial: () => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Vui long dang nhap'),
                  ElevatedButton(
                    onPressed: _simulateLogin,
                    child: Text('Dat dau dang nhap'),
                  ),
                ],
              ),
              loading: () => CircularProgressIndicator(),
              authenticated: (user) => Text('Chao mung: ${user.name}'),
              unauthenticated: () => Text('Chua dang nhap'),
              error: (e) => Text('Loi: $e'),
            );
          },
        ),
      ),
    );
  }
}
