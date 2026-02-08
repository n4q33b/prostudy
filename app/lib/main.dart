import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';

/// ProStudy - AI-powered learning application
///
/// Entry point with Firebase initialization and Riverpod state management.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await _initializeFirebase();

  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(AppTheme.darkOverlayStyle);

  // Run app with Riverpod
  runApp(
    const ProviderScope(
      child: ProStudyApp(),
    ),
  );
}

/// Initialize Firebase with proper error handling
Future<void> _initializeFirebase() async {
  try {
    await Firebase.initializeApp();
    debugPrint('Firebase initialized successfully');
  } catch (e) {
    debugPrint('Firebase initialization error: $e');
    // In production, you might want to show an error screen
    // or retry initialization
  }
}

/// Root application widget
class ProStudyApp extends ConsumerWidget {
  const ProStudyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      // App info
      title: 'ProStudy',
      debugShowCheckedModeBanner: false,

      // Theme
      theme: AppTheme.darkTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,

      // Router
      routerConfig: router,

      // Builder for global app configuration
      builder: (context, child) {
        // Apply global settings
        return MediaQuery(
          // Disable text scaling to maintain design consistency
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.noScaling,
          ),
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
  }
}
