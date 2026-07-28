import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngay2807/models/weather.dart';
import 'package:ngay2807/screen/weather_screen.dart';
import '../bloc/weather_bloc.dart';
import '../repositories/weather_repository.dart';
import '../screen/home_screen.dart';

enum AppRoute {
  home('/'),
  weather('/weather');

  final String path;

  const AppRoute(this.path);
}

class AppRouter {
  static final router = GoRouter(
    initialLocation: AppRoute.home.path,
    routes: [
      GoRoute(
        path: AppRoute.home.path,
        builder: (context, state) => BlocProvider(
          create: (context) => WeatherBloc(WeatherRepository()),
          child: const HomeScreen(),
        ),
      ),
      GoRoute(
        path: AppRoute.weather.path,
        builder: (context, state) {
          final weather = state.extra as Weather;
          return WeatherScreen(weather);
        },
      ),
    ],
  );
}
