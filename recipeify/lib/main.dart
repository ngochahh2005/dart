import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:recipeify/core/database/database_service.dart';
import 'package:recipeify/core/router/app_router.dart';
import 'package:recipeify/core/storage/secure_storage_service.dart';
import 'package:recipeify/core/storage/shared_prefs_service.dart';
import 'package:recipeify/data/repositories/auth_repository.dart';
import 'package:recipeify/features/auth/bloc/auth_bloc.dart';
import 'package:recipeify/features/auth/bloc/auth_event.dart';
import 'package:recipeify/features/auth/screen/login_screen.dart';
import 'package:recipeify/firebase_options.dart';
import 'package:recipeify/theme/app_theme.dart';
import 'package:recipeify/theme/theme_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final themeController = ThemeController();
  await themeController.loadFromPrefs();

  runApp(
    ChangeNotifierProvider.value(
      value: themeController,
      child: const RecipeifyApp(),
    ),
  );
}

class RecipeifyApp extends StatelessWidget {
  const RecipeifyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = context.watch<ThemeController>();

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => AuthRepository()),
        RepositoryProvider(create: (context) => DatabaseService()),
        RepositoryProvider(create: (context) => SecureStorageService())
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              context.read<AuthRepository>(),
              context.read<SecureStorageService>(),
            )..add(AuthSubscriptionStarted()),
          ),
        ],
        child: MaterialApp.router(
          routerConfig: AppRouter.router,
          title: 'Recipeify',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: themeController.themeMode,
        ),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = context.watch<ThemeController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Cài đặt')),
      body: SwitchListTile(
        title: const Text('Chế độ tối'),
        subtitle: const Text('Bật để dùng giao diện tối'),
        value: themeController.isDarkMode,
        onChanged: (value) => themeController.toggleDarkMode(value),
      ),
    );
  }
}
