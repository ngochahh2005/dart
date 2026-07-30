import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/screens/login_screen.dart';
import '../features/auth/screens/register_screen.dart';
import '../features/detail/screen/detail_screen.dart';
import '../features/favorites/screen/favorite_screen.dart';
import '../features/home/bloc/home_bloc.dart';
import '../features/home/screen/home_screen.dart';
import '../models/cat_breed.dart';
import '../models/favorite_cat.dart';

enum AppRoute {
  home('/'),
  register('/register'),
  login('/login'),
  favorites('/favorites'),
  detail('/detail:id');

  final String path;

  const AppRoute(this.path);
}

class AppRouter {
  static final router = GoRouter(
    initialLocation: AppRoute.login.path,
    routes: [
      GoRoute(
        path: AppRoute.login.path,
        builder: (context, builder) => const LoginScreen(),
      ),

      GoRoute(
        path: AppRoute.register.path,
        builder: (context, builder) => const RegisterScreen(),
      ),

      ShellRoute(
        builder: (context, state, child) {
          return Scaffold(
            body: child,
            bottomNavigationBar: _buildBottomNavigationBar(context, state),
          );
        },
        routes: [
          GoRoute(
            path: AppRoute.home.path,
            builder: (context, builder) => BlocProvider.value(
              value: context.read<HomeBloc>(),
              child: const HomeScreen(),
            ),
          ),

          GoRoute(
            path: AppRoute.favorites.path,
            builder: (context, builder) => FavoriteScreen(),
          ),
        ],
      ),

      GoRoute(
        path: AppRoute.detail.path,
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          final extra = state.extra;

          CatBreed? initial;
          if (extra is CatBreed) {
            initial = extra;
          }
          if (extra is FavoriteCat) {
            initial = CatBreed(id: extra.id, name: extra.breedName, referenceImageId: extra.imageUrl.split('/').last.split('.').first);
          }

          if (initial != null) {
            return DetailScreen(breedId: initial.id, initialData: initial,);
          } else {
            return const Text('Not found!');
          }
        },
      ),
    ],
  );

  static Widget _buildBottomNavigationBar(
    BuildContext context,
    GoRouterState state,
  ) {
    final currentLocation = state.uri.toString();

    int selectedIdx = 0;
    if (currentLocation.startsWith(AppRoute.favorites.path)) {
      selectedIdx = 1;
    } else if (currentLocation == AppRoute.home.path) {
      selectedIdx = 0;
    }

    return BottomNavigationBar(
      currentIndex: selectedIdx,
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        switch (index) {
          case 0:
            context.go(AppRoute.home.path);
            break;
          case 1:
            context.go(AppRoute.favorites.path);
        }
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.pets), label: 'Explore'),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorite'),
      ],
    );
  }
}
