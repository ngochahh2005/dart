import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipeify/theme/app_theme.dart';
import 'package:recipeify/theme/theme_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final themeController = ThemeController();
  await themeController.loadFromPrefs();

  runApp(ChangeNotifierProvider.value(
      value: themeController,
    child: const RecipeifyApp(),
  ));
}

class RecipeifyApp extends StatelessWidget{
  const RecipeifyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = context.watch<ThemeController>();

    return MaterialApp(
      title: 'Recipeify',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeController.themeMode,
      home: const SettingsScreen(),
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

