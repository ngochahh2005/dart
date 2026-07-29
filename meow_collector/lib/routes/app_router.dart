import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:meow_collector/features/auth/bloc/auth_bloc.dart';
import 'package:meow_collector/features/auth/screens/login_screen.dart';
import 'package:meow_collector/features/auth/screens/register_screen.dart';
import 'package:meow_collector/features/home/screen/home_screen.dart';

enum AppRoute {
  home('/'),
  register('/register'),
  login('/login'),
  detail('/detail');

  final String path;

  const AppRoute(this.path);
}

class AppRouter {
  static final router = GoRouter(
    initialLocation: AppRoute.login.path,
    routes: [
      GoRoute(
        path: AppRoute.home.path,
        builder: (context, builder) => const HomeScreen(),
      ),
      GoRoute(
        path: AppRoute.login.path,
        builder: (context, builder) => const LoginScreen(),
      ),

      GoRoute(
        path: AppRoute.register.path,
        builder: (context, builder) => const RegisterScreen(),
      ),
    ],
  );
}
