import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meow_collector/features/auth/bloc/auth_bloc.dart';
import 'package:meow_collector/features/auth/bloc/auth_event.dart';
import 'package:meow_collector/features/favorites/bloc/favorite_bloc.dart';
import 'package:meow_collector/features/favorites/bloc/favorite_event.dart';
import 'package:meow_collector/features/home/bloc/home_bloc.dart';
import 'package:meow_collector/features/home/bloc/home_event.dart';
import 'package:meow_collector/routes/app_router.dart';
import 'package:meow_collector/services/api/cat_api_service.dart';
import 'package:meow_collector/services/auth/auth_service.dart';
import 'package:meow_collector/services/database/database_service.dart';
import 'package:meow_collector/services/share_preferences/share_prefs_service.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SharePrefsService().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => CatApiService()),
        RepositoryProvider(create: (context) => AuthService()),
        RepositoryProvider(create: (context) => DatabaseService()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) =>
                AuthBloc(context.read<AuthService>())
                  ..add(AuthSubscriptionStarted()),
          ),
          BlocProvider<FavoriteBloc>(
            create: (context) =>
                FavoriteBloc(context.read<DatabaseService>())
                  ..add(FavoriteLoad()),
          ),
          BlocProvider<HomeBloc>(
            create: (context) => HomeBloc(
              context.read<CatApiService>(),
              context.read<FavoriteBloc>(),
            )..add(HomeLoad()),
          ),
        ],
        child: MaterialApp.router(
          routerConfig: AppRouter.router,
          title: 'Meow Collector',
          theme: ThemeData(
            inputDecorationTheme: InputDecorationTheme(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
        ),
      ),
    );
  }
}
