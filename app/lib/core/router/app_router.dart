import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/splash/splash_screen.dart';
import '../../features/auth/login_screen.dart';
// TODO: Remove dev bypass - auth_service used by commented-out auth logic
// ignore: unused_import
import '../../features/auth/auth_service.dart';
import '../../features/onboarding/onboarding_screen.dart';
import '../../features/home/subject_home_screen.dart';
import '../../features/settings/settings_screen.dart';
import '../constants/app_constants.dart';
import '../providers/user_profile_provider.dart';

/// Navigation key for accessing navigator state
final rootNavigatorKey = GlobalKey<NavigatorState>();

// ---------------------------------------------------------------------------
// RouterNotifier: bridges Riverpod state -> GoRouter refreshListenable
// ---------------------------------------------------------------------------

/// A [ChangeNotifier] that listens to the user-profile Riverpod provider and
/// calls [notifyListeners] whenever the "has profile" status changes.
///
/// This avoids calling `ref.watch` directly inside the [GoRouter] provider,
/// which would cause a full provider rebuild and trigger the
/// `_dependents.isEmpty` assertion error.
class RouterNotifier extends ChangeNotifier {
  RouterNotifier(this._ref) {
    _ref.listen<AsyncValue>(userProfileProvider, (_, next) {
      final newHasProfile = next.valueOrNull != null;
      if (newHasProfile != _hasProfile) {
        _hasProfile = newHasProfile;
        notifyListeners();
      }
    });
  }

  final Ref _ref;
  bool _hasProfile = false;

  /// Whether the user has a saved profile (completed onboarding).
  bool get hasProfile => _hasProfile;
}

/// Provider for the [RouterNotifier] singleton.
final _routerNotifierProvider = Provider<RouterNotifier>((ref) {
  return RouterNotifier(ref);
});

// ---------------------------------------------------------------------------
// GoRouter provider
// ---------------------------------------------------------------------------

/// GoRouter provider for the application
final routerProvider = Provider<GoRouter>((ref) {
  // TODO: Remove dev bypass - uncomment auth state watching
  // final authState = ref.watch(authStateProvider);

  // Use the RouterNotifier to safely bridge Riverpod -> GoRouter without
  // ref.watch inside the router provider (prevents _dependents.isEmpty crash).
  final notifier = ref.watch(_routerNotifierProvider);

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: AppConstants.splashRoute,
    debugLogDiagnostics: true,

    // Use refreshListenable so GoRouter re-evaluates redirect when profile
    // state changes, without rebuilding the entire provider.
    refreshListenable: notifier,

    // DEV MODE: Auth bypass - original auth refreshListenable disabled
    // TODO: Remove dev bypass - uncomment refreshListenable for auth
    // refreshListenable: GoRouterRefreshStream(
    //   ref.read(authServiceProvider).authStateChanges,
    // ),

    // DEV MODE: Auth bypass - original auth redirect disabled
    // TODO: Remove dev bypass - uncomment original redirect logic
    // redirect: (context, state) {
    //   final isLoggedIn = authState.valueOrNull != null;
    //   final isOnSplash = state.matchedLocation == AppConstants.splashRoute;
    //   final isOnLogin = state.matchedLocation == AppConstants.loginRoute;
    //
    //   // Allow splash screen to complete its animation
    //   if (isOnSplash) return null;
    //
    //   // If not logged in and not on login, go to login
    //   if (!isLoggedIn && !isOnLogin) {
    //     return AppConstants.loginRoute;
    //   }
    //
    //   // If logged in and on login, go to home
    //   if (isLoggedIn && isOnLogin) {
    //     return AppConstants.homeRoute;
    //   }
    //
    //   return null;
    // },

    // Onboarding redirect logic (active in dev mode)
    redirect: (context, state) {
      final hasProfile = notifier.hasProfile;
      final isOnSplash = state.matchedLocation == AppConstants.splashRoute;
      final isOnOnboarding =
          state.matchedLocation == AppConstants.onboardingRoute;

      // Allow splash to complete
      if (isOnSplash) return null;

      // If no profile and not on onboarding, go to onboarding
      if (!hasProfile && !isOnOnboarding) {
        return AppConstants.onboardingRoute;
      }

      // If has profile and on onboarding, go to home
      if (hasProfile && isOnOnboarding) {
        return AppConstants.homeRoute;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: AppConstants.splashRoute,
        name: 'splash',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const SplashScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
      ),
      GoRoute(
        path: AppConstants.loginRoute,
        name: 'login',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const LoginScreen(),
          transitionDuration: const Duration(milliseconds: 600),
          reverseTransitionDuration: const Duration(milliseconds: 400),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Smooth fade transition from splash
            return FadeTransition(
              opacity: CurvedAnimation(
                parent: animation,
                curve: Curves.easeInOut,
              ),
              child: child,
            );
          },
        ),
      ),
      GoRoute(
        path: AppConstants.onboardingRoute,
        name: 'onboarding',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const OnboardingScreen(),
          transitionDuration: const Duration(milliseconds: 500),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: CurvedAnimation(
                parent: animation,
                curve: Curves.easeInOut,
              ),
              child: child,
            );
          },
        ),
      ),
      GoRoute(
        path: AppConstants.homeRoute,
        name: 'home',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const SubjectHomeScreen(),
          transitionDuration: const Duration(milliseconds: 400),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutCubic,
              )),
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
        ),
      ),
      GoRoute(
        path: AppConstants.settingsRoute,
        name: 'settings',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const SettingsScreen(),
          transitionDuration: const Duration(milliseconds: 350),
          reverseTransitionDuration: const Duration(milliseconds: 300),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutCubic,
              )),
              child: child,
            );
          },
        ),
      ),
    ],
    errorPageBuilder: (context, state) => MaterialPage(
      key: state.pageKey,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                'Page not found',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              Text(
                state.error?.message ?? 'Unknown error',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => context.go(AppConstants.loginRoute),
                child: const Text('Go to Login'),
              ),
            ],
          ),
        ),
      ),
    ),
  );
});

/// Helper class to convert Stream to Listenable for GoRouter refresh
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  late final dynamic _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
