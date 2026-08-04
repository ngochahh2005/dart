import 'package:go_router/go_router.dart';
import 'package:recipeify/features/splash/screen/splash_screen.dart';
import '../../features/auth/screen/login_screen.dart';
import '../../features/auth/screen/register_screen.dart';
import '../../features/home/screen/home_screen.dart';

enum AppRoute {
  home('/'),
  splash('/splash'),
  login('/login'),
  register('/register'),
  pinVerification('/pin-verification'),
  favorites('/favorites');

  final String path;

  const AppRoute(this.path);
}

class AppRouter {
  static final router = GoRouter(
    initialLocation: AppRoute.splash.path,
    routes: [
      GoRoute(
        path: AppRoute.splash.path,
        builder: (context, builder) => const SplashScreen(),
      ),

      GoRoute(
        path: AppRoute.login.path,
        builder: (context, builder) => const LoginScreen(),
      ),

      GoRoute(
        path: AppRoute.register.path,
        builder: (context, builder) => const RegisterScreen(),
      ),

      GoRoute(
        path: AppRoute.home.path,
        builder: (context, builder) => const HomeScreen(),
      ),
    ],
  );
}
