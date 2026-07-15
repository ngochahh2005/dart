/*
  Bài tập 3 (GoRouter):
  Chuyển đổi hệ thống điều hướng sang go_router.
  Cấu hình ShellRoute để tạo Bottom Navigation Bar cho ứng dụng.
  Thêm Redirect logic: Nếu chưa đăng nhập, tự động chuyển hướng về màn hình Login.
 */
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:ngay1407/baitap/bai_1/model/Task.dart';
import 'package:ngay1407/baitap/bai_3/providers/AuthNotifier.dart';
import 'package:provider/provider.dart';
import '../bai_3/view/TaskDetailScreen.dart';
import '../bai_3/view/TaskScreen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (_) => AuthNotifier(), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final _goRouter = GoRouter(
    initialLocation: '/login',
    redirect: (context, state) {
      final auth = context.read<AuthNotifier>();
      final isLoggedIn = auth.isLoggedIn;
      final isLoginRoute = state.matchedLocation == '/login';

      if (!isLoggedIn && !isLoginRoute) return '/login';

      if (isLoggedIn && isLoginRoute) return '/home/tasks';

      return null;
    },

    routes: [
      GoRoute(path: '/login'),

      StatefulShellRoute.indexedStack(
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home/tasks',
                builder: (context, state) => TaskScreen(),
              ),

              GoRoute(
                path: '/task/:id',
                name: 'taskDetail',
                builder: (context, state) {
                  final id = state.extra as Task?;
                  return TaskDetailScreen();
                },
              ),
            ],
          ),

          StatefulShellBranch(
            routes: [GoRoute(path: '/home/profile', name: 'profile')],
          ),
        ],
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _goRouter,
    );
  }
}
