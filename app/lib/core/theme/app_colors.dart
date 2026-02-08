import 'package:flutter/material.dart';

/// ProStudy brand colors
///
/// Design system colors for consistent theming across the application.
/// All colors are carefully chosen to ensure accessibility and visual harmony.
abstract final class AppColors {
  // Primary Palette
  /// Main background color - deep, professional navy
  static const Color darkNavy = Color(0xFF0D3B4C);

  /// Accent teal - used for "Pro" branding and icons
  static const Color teal = Color(0xFF2D9596);

  /// Vibrant lime green - used for "Study" branding and CTAs
  static const Color limeGreen = Color(0xFF4ADE80);

  // Extended Palette
  /// Lighter variant of navy for gradients and surfaces
  static const Color darkNavyLight = Color(0xFF1A5568);

  /// Lighter teal for hover states and secondary elements
  static const Color tealLight = Color(0xFF3DB5B6);

  /// Pure white for text and icons
  static const Color white = Color(0xFFFFFFFF);

  /// Off-white for subtle backgrounds
  static const Color offWhite = Color(0xFFF8FAFA);

  // Semantic Colors
  /// Error state color
  static const Color error = Color(0xFFEF4444);

  /// Success state color
  static const Color success = Color(0xFF22C55E);

  /// Warning state color
  static const Color warning = Color(0xFFF59E0B);

  // Text Colors
  /// Primary text on dark backgrounds
  static const Color textPrimary = white;

  /// Secondary/muted text on dark backgrounds
  static const Color textSecondary = Color(0xFFB0C4CE);

  /// Muted text for disclaimers and hints
  static const Color textMuted = Color(0xFF7A9BA8);

  // Gradients
  /// Main background gradient (top to bottom)
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [darkNavy, darkNavyLight],
  );

  /// Brand gradient for "ProStudy" text (teal to lime green)
  static const LinearGradient brandGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [teal, limeGreen],
  );

  /// Shimmer gradient for loading effects
  static const LinearGradient shimmerGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0x00FFFFFF),
      Color(0x33FFFFFF),
      Color(0x00FFFFFF),
    ],
    stops: [0.0, 0.5, 1.0],
  );

  // Button Colors
  /// Google button background
  static const Color googleButtonBg = white;

  /// Google button text
  static const Color googleButtonText = Color(0xFF3C4043);

  /// Apple button background
  static const Color appleButtonBg = Color(0xFF000000);

  /// Apple button text
  static const Color appleButtonText = white;

  // Shadows
  /// Subtle shadow for elevated surfaces
  static List<BoxShadow> get subtleShadow => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.1),
      blurRadius: 10,
      offset: const Offset(0, 4),
    ),
  ];

  /// Prominent shadow for buttons and cards
  static List<BoxShadow> get prominentShadow => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.15),
      blurRadius: 20,
      offset: const Offset(0, 8),
    ),
  ];

  /// Glow effect for brand elements
  static List<BoxShadow> glowEffect(Color color) => [
    BoxShadow(
      color: color.withValues(alpha: 0.4),
      blurRadius: 30,
      spreadRadius: 2,
    ),
  ];
}
