/// ProStudy application-wide constants
///
/// Centralized location for all magic numbers, durations, and configuration values.
abstract final class AppConstants {
  // App Information
  static const String appName = 'ProStudy';
  static const String appTagline = 'Learn smarter, not harder';
  static const String appVersion = '1.0.0';

  // Animation Durations (in milliseconds)
  static const int splashLogoFadeDelay = 500;
  static const int splashLogoFadeDuration = 800;
  static const int splashLogoScaleDuration = 1200;
  static const int splashTotalDuration = 2500;
  static const int loginStaggerDelay = 100;
  static const int buttonScaleDuration = 150;
  static const int defaultAnimationDuration = 300;
  static const int pageTransitionDuration = 400;

  // Animation Curves
  static const String splashCurve = 'elasticOut';

  // Layout Constants
  static const double buttonBorderRadius = 14.0;
  static const double cardBorderRadius = 16.0;
  static const double screenPadding = 24.0;
  static const double buttonHeight = 56.0;
  static const double buttonSpacing = 16.0;
  static const double chunkyBorderWidth = 4.0;
  static const double chunkyBorderWidthSmall = 3.0;

  // Spacing Grid (8pt base)
  static const double s1 = 8.0;
  static const double s2 = 16.0;
  static const double s3 = 24.0;
  static const double s4 = 32.0;
  static const double s5 = 40.0;
  static const double s6 = 48.0;

  static const double logoSizeSplash = 180.0;
  static const double logoSizeLogin = 100.0;

  // Opacity Values
  static const double disabledOpacity = 0.5;
  static const double hoverOpacity = 0.8;
  static const double pressedScale = 0.95;
  static const double idlePulseScale = 1.02;

  // Route Names
  static const String splashRoute = '/splash';
  static const String loginRoute = '/login';
  static const String homeRoute = '/home';

  // Asset Paths
  static const String logoPath = 'assets/images/logo.png';
  static const String googleIconPath = 'assets/icons/google.svg';
  static const String appleIconPath = 'assets/icons/apple.svg';

  // Legal Text
  static const String termsText =
      'By continuing, you agree to our Terms of Service & Privacy Policy';

  // Error Messages
  static const String genericError = 'Something went wrong. Please try again.';
  static const String networkError =
      'Please check your internet connection and try again.';
  static const String authCancelled = 'Sign in was cancelled.';
  static const String authFailed = 'Authentication failed. Please try again.';

  // -------------------------------------------------------------------------
  // Onboarding & Education Configuration
  // -------------------------------------------------------------------------

  static const String onboardingRoute = '/onboarding';
  static const String settingsRoute = '/settings';
  static const String chapterListRoute = '/chapters';
  static const String simulationSegment = 'simulation';
  static const double logoSizeOnboarding = 40.0;

  /// Board identifiers used during onboarding
  static const String boardMaharashtra = 'maharashtra';
  static const String boardCbse = 'cbse';
  static const String boardNcert = 'ncert';

  /// Boards with display names and availability flags
  static const List<Map<String, dynamic>> boards = [
    {'id': boardMaharashtra, 'name': 'Maharashtra State Board', 'available': true},
    {'id': boardCbse, 'name': 'CBSE', 'available': false},
    {'id': boardNcert, 'name': 'NCERT', 'available': false},
  ];

  /// Available class levels for student selection
  static const List<int> availableClasses = [5, 6, 7, 8, 9, 10];

  /// Available mediums per board
  static const Map<String, List<String>> boardMediums = {
    boardMaharashtra: [
      'Marathi',
      'Hindi',
      'English',
      'Urdu',
      'Gujarati',
      'Kannada',
      'Telugu',
    ],
    boardCbse: ['English', 'Hindi'],
    boardNcert: ['English', 'Hindi'],
  };

  // -------------------------------------------------------------------------
  // Trial & Pricing
  // -------------------------------------------------------------------------

  /// Number of free trial days for new users
  static const int trialDays = 15;

  /// Monthly pricing per class level in INR
  static const Map<String, int> classPricing = {
    '5': 99,
    '6': 99,
    '7': 149,
    '8': 149,
    '9': 149,
    '10': 199,
  };

  // Particle Animation Constants (for splash)
  static const int particleCount = 30;
  static const double particleMinSize = 2.0;
  static const double particleMaxSize = 6.0;
  static const double particleMinSpeed = 0.5;
  static const double particleMaxSpeed = 2.0;
  static const double particleMinOpacity = 0.1;
  static const double particleMaxOpacity = 0.4;
}
