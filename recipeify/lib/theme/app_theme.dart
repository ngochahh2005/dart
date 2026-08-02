import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get light {
    final scheme = ColorScheme.light(
      primary: AppColors.lightPrimary,
      onPrimary: AppColors.lightBackground,
      secondary: AppColors.lightSecondary,
      onSecondary: Colors.white,
      tertiary: AppColors.lightAccent,
      onTertiary: Colors.white,
      surface: AppColors.lightSurface,
      onSurface: AppColors.lightTextPrimary,
      surfaceContainerHighest: AppColors.lightSurfaceVariant,
      error: AppColors.lightError,
      onError: Colors.white,
      outline: AppColors.lightBorder,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.lightBackground,

      appBarTheme: AppBarTheme(
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
        elevation: 0,
        centerTitle: false,
      ),

      cardTheme: CardThemeData(
        color: scheme.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: scheme.outline, width: 0.5),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: scheme.primary,
          side: BorderSide(color: scheme.outline),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),

      textTheme: TextTheme(
        titleMedium: TextStyle(
          color: AppColors.lightTextPrimary,
          fontWeight: FontWeight.w600,
        ),
        bodyMedium: TextStyle(color: AppColors.lightTextSecondary),
      ),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: scheme.surface,
        selectedItemColor: scheme.primary,
        unselectedItemColor: AppColors.lightTextSecondary,
      ),

      iconTheme: IconThemeData(color: AppColors.lightTextSecondary),

      chipTheme: ChipThemeData(
        backgroundColor: AppColors.lightSurfaceVariant,
        labelStyle: TextStyle(color: AppColors.lightSecondary, fontSize: 12),
        shape: StadiumBorder(side: BorderSide(color: scheme.outline)),
      ),

      switchTheme: SwitchThemeData(
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.lightPrimary;
          }
          return AppColors.lightSurfaceVariant;
        }),
        trackOutlineColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.transparent;
          }
          return AppColors.lightBorder;
        }),
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.white;
          }
          return AppColors.lightTextSecondary;
        }),
        // Overlay hover/pressed: alpha thấp, không phủ kín track.
        overlayColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.lightPrimary.withValues(alpha: 0.12);
          }
          return AppColors.lightTextSecondary.withValues(alpha: 0.08);
        }),
      ),
    );
  }

  static ThemeData get dark {
    final scheme = ColorScheme.dark(
      primary: AppColors.darkPrimary,
      onPrimary: AppColors.darkBackground,
      secondary: AppColors.darkSecondary,
      onSecondary: AppColors.darkBackground,
      tertiary: AppColors.darkAccent,
      onTertiary: AppColors.darkBackground,
      surface: AppColors.darkSurface,
      onSurface: AppColors.darkTextPrimary,
      surfaceContainerHighest: AppColors.darkSurfaceVariant,
      error: AppColors.darkError,
      onError: AppColors.darkBackground,
      outline: AppColors.darkBorder,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.darkBackground,

      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.darkSurfaceVariant,
        foregroundColor: scheme.primary,
        elevation: 0,
        centerTitle: false,
      ),

      cardTheme: CardThemeData(
        color: scheme.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: scheme.outline, width: 0.5),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: scheme.primary,
          side: BorderSide(color: scheme.outline),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),

      textTheme: TextTheme(
        titleMedium: TextStyle(
          color: AppColors.darkTextPrimary,
          fontWeight: FontWeight.w600,
        ),
        bodyMedium: TextStyle(color: AppColors.darkTextSecondary),
      ),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: scheme.surface,
        selectedItemColor: scheme.primary,
        unselectedItemColor: AppColors.darkTextSecondary,
      ),

      iconTheme: IconThemeData(color: AppColors.darkTextSecondary),

      chipTheme: ChipThemeData(
        backgroundColor: AppColors.darkSurfaceVariant,
        labelStyle: TextStyle(color: AppColors.darkAccent, fontSize: 12),
        shape: StadiumBorder(side: BorderSide(color: scheme.outline)),
      ),

      switchTheme: SwitchThemeData(
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.darkPrimary;
          }
          return AppColors.darkSurfaceVariant;
        }),
        trackOutlineColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.transparent;
          }
          return AppColors.darkBorder;
        }),
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.darkBackground;
          }
          return AppColors.darkTextSecondary;
        }),
        overlayColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.darkPrimary.withValues(alpha: 0.16);
          }
          return AppColors.darkTextSecondary.withValues(alpha: 0.12);
        }),
      ),
    );
  }
}
