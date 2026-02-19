import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';
import 'app_typography.dart';

/// ProStudy theme configuration
///
/// Provides a complete ThemeData for the application with
/// dark theme optimized for the navy color scheme.
abstract final class AppTheme {
  /// Main dark theme for the app
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,

      // Color scheme
      colorScheme: const ColorScheme.dark(
        primary: AppColors.teal,
        primaryContainer: AppColors.tealLight,
        secondary: AppColors.limeGreen,
        secondaryContainer: AppColors.limeGreen,
        surface: AppColors.darkNavy,
        error: AppColors.error,
        onPrimary: AppColors.white,
        onSecondary: AppColors.darkNavy,
        onSurface: AppColors.white,
        onError: AppColors.white,
      ),

      // Scaffold
      scaffoldBackgroundColor: AppColors.darkNavy,

      // AppBar
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
        iconTheme: IconThemeData(color: AppColors.white),
        titleTextStyle: AppTypography.headlineMedium,
      ),

      // Text theme
      textTheme: const TextTheme(
        displayLarge: AppTypography.displayLarge,
        displayMedium: AppTypography.displayMedium,
        displaySmall: AppTypography.displaySmall,
        headlineLarge: AppTypography.headlineLarge,
        headlineMedium: AppTypography.headlineMedium,
        headlineSmall: AppTypography.headlineSmall,
        titleLarge: AppTypography.titleLarge,
        titleMedium: AppTypography.titleMedium,
        titleSmall: AppTypography.titleSmall,
        bodyLarge: AppTypography.bodyLarge,
        bodyMedium: AppTypography.bodyMedium,
        bodySmall: AppTypography.bodySmall,
        labelLarge: AppTypography.labelLarge,
        labelMedium: AppTypography.labelMedium,
        labelSmall: AppTypography.labelSmall,
      ),

      // Elevated button
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.teal,
          foregroundColor: AppColors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: AppTypography.button,
        ),
      ),

      // Text button
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.teal,
          textStyle: AppTypography.button,
        ),
      ),

      // Input decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.darkNavyLight,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.teal, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.error, width: 1),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        hintStyle: AppTypography.bodyMedium.copyWith(
          color: AppColors.textMuted,
        ),
      ),

      // Card
      cardTheme: CardThemeData(
        color: AppColors.darkNavyLight,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),

      // Snackbar
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.darkNavyLight,
        contentTextStyle: AppTypography.bodyMedium,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        behavior: SnackBarBehavior.floating,
      ),

      // Progress indicator
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.teal,
        circularTrackColor: AppColors.darkNavyLight,
      ),

      // Divider
      dividerTheme: DividerThemeData(
        color: AppColors.textMuted.withValues(alpha: 0.2),
        thickness: 1,
      ),

      // Icon
      iconTheme: const IconThemeData(
        color: AppColors.white,
        size: 24,
      ),

      // Splash and highlight
      splashColor: AppColors.teal.withValues(alpha: 0.1),
      highlightColor: AppColors.teal.withValues(alpha: 0.05),

      // Bottom navigation (prep for future use)
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.darkNavy,
        selectedItemColor: AppColors.teal,
        unselectedItemColor: AppColors.textMuted,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),

      // Page transitions
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.windows: CupertinoPageTransitionsBuilder(),
          TargetPlatform.linux: CupertinoPageTransitionsBuilder(),
        },
      ),
    );
  }

  /// System UI overlay style for dark screens
  static const SystemUiOverlayStyle darkOverlayStyle = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.dark,
    systemNavigationBarColor: AppColors.darkNavy,
    systemNavigationBarIconBrightness: Brightness.light,
  );
}
