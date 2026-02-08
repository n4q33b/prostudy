import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/app_theme.dart';
import '../../core/constants/app_constants.dart';
import '../../shared/widgets/social_button.dart';
import 'auth_service.dart';

/// Premium login screen for ProStudy
///
/// Features:
/// - Dark navy gradient background
/// - Animated logo transition from splash
/// - Gradient "ProStudy" branding text
/// - Elegant staggered fade-in animations
/// - Google and Apple sign-in buttons with animations
/// - Loading states and error handling
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen>
    with SingleTickerProviderStateMixin {
  bool _isGoogleLoading = false;
  bool _isAppleLoading = false;

  @override
  void initState() {
    super.initState();
    _setupSystemUI();
  }

  void _setupSystemUI() {
    SystemChrome.setSystemUIOverlayStyle(AppTheme.darkOverlayStyle);
  }

  bool get _isAnyLoading => _isGoogleLoading || _isAppleLoading;

  Future<void> _handleGoogleSignIn() async {
    if (_isAnyLoading) return;

    setState(() => _isGoogleLoading = true);

    try {
      final authService = ref.read(authServiceProvider);
      final result = await authService.signInWithGoogle();

      if (!mounted) return;

      if (result.success) {
        // Navigation is handled by router based on auth state
        context.go(AppConstants.homeRoute);
      } else if (result.error != null && result.error != 'Sign in cancelled') {
        _showErrorSnackBar(result.error!);
      }
    } finally {
      if (mounted) {
        setState(() => _isGoogleLoading = false);
      }
    }
  }

  Future<void> _handleAppleSignIn() async {
    if (_isAnyLoading) return;

    setState(() => _isAppleLoading = true);

    try {
      final authService = ref.read(authServiceProvider);
      final result = await authService.signInWithApple();

      if (!mounted) return;

      if (result.success) {
        // Navigation is handled by router based on auth state
        context.go(AppConstants.homeRoute);
      } else if (result.error != null && result.error != 'Sign in cancelled') {
        _showErrorSnackBar(result.error!);
      }
    } finally {
      if (mounted) {
        setState(() => _isAppleLoading = false);
      }
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: AppColors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.error,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 4),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.screenPadding,
            ),
            child: Column(
              children: [
                // Top spacing
                SizedBox(height: screenHeight * 0.08),

                // Logo
                _buildLogo()
                    .animate()
                    .fadeIn(
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeOut,
                    )
                    .scale(
                      begin: const Offset(0.8, 0.8),
                      end: const Offset(1.0, 1.0),
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeOutBack,
                    ),

                SizedBox(height: screenHeight * 0.04),

                // Welcome text
                _buildWelcomeText()
                    .animate()
                    .fadeIn(
                      delay: const Duration(milliseconds: 200),
                      duration: const Duration(milliseconds: 500),
                    )
                    .slideY(
                      begin: 0.3,
                      end: 0,
                      delay: const Duration(milliseconds: 200),
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeOutCubic,
                    ),

                const SizedBox(height: 8),

                // Subtitle
                _buildSubtitle()
                    .animate()
                    .fadeIn(
                      delay: const Duration(milliseconds: 300),
                      duration: const Duration(milliseconds: 500),
                    )
                    .slideY(
                      begin: 0.3,
                      end: 0,
                      delay: const Duration(milliseconds: 300),
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeOutCubic,
                    ),

                // Flexible space
                const Spacer(),

                // Sign-in buttons
                _buildSignInButtons(),

                SizedBox(height: screenHeight * 0.04),

                // Terms text
                _buildTermsText()
                    .animate()
                    .fadeIn(
                      delay: const Duration(milliseconds: 600),
                      duration: const Duration(milliseconds: 500),
                    ),

                // Bottom spacing
                SizedBox(height: bottomPadding > 0 ? 16 : 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      width: AppConstants.logoSizeLogin,
      height: AppConstants.logoSizeLogin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.teal.withValues(alpha: 0.3),
            blurRadius: 30,
            spreadRadius: 5,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(
          AppConstants.logoPath,
          width: AppConstants.logoSizeLogin,
          height: AppConstants.logoSizeLogin,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _buildWelcomeText() {
    return Column(
      children: [
        Text(
          'Welcome to',
          style: AppTypography.welcomeText,
        ),
        const SizedBox(height: 4),
        ShaderMask(
          shaderCallback: (bounds) {
            return AppColors.brandGradient.createShader(
              Rect.fromLTWH(0, 0, bounds.width, bounds.height),
            );
          },
          child: Text(
            AppConstants.appName,
            style: AppTypography.brandName.copyWith(
              color: AppColors.white, // This will be masked by the gradient
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSubtitle() {
    return Text(
      AppConstants.appTagline,
      style: AppTypography.subtitle,
      textAlign: TextAlign.center,
    );
  }

  Widget _buildSignInButtons() {
    return Column(
      children: [
        // Google Sign-In Button
        SocialButton(
          type: SocialButtonType.google,
          onPressed: _handleGoogleSignIn,
          isLoading: _isGoogleLoading,
          isEnabled: !_isAnyLoading,
        )
            .animate()
            .fadeIn(
              delay: const Duration(milliseconds: 400),
              duration: const Duration(milliseconds: 500),
            )
            .slideY(
              begin: 0.3,
              end: 0,
              delay: const Duration(milliseconds: 400),
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOutCubic,
            ),

        const SizedBox(height: AppConstants.buttonSpacing),

        // Apple Sign-In Button (only on iOS/macOS)
        if (Platform.isIOS || Platform.isMacOS)
          SocialButton(
            type: SocialButtonType.apple,
            onPressed: _handleAppleSignIn,
            isLoading: _isAppleLoading,
            isEnabled: !_isAnyLoading,
          )
              .animate()
              .fadeIn(
                delay: const Duration(milliseconds: 500),
                duration: const Duration(milliseconds: 500),
              )
              .slideY(
                begin: 0.3,
                end: 0,
                delay: const Duration(milliseconds: 500),
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOutCubic,
              ),

        // Show Apple button on Android for testing (comment out for production)
        if (Platform.isAndroid)
          SocialButton(
            type: SocialButtonType.apple,
            onPressed: _handleAppleSignIn,
            isLoading: _isAppleLoading,
            isEnabled: !_isAnyLoading,
          )
              .animate()
              .fadeIn(
                delay: const Duration(milliseconds: 500),
                duration: const Duration(milliseconds: 500),
              )
              .slideY(
                begin: 0.3,
                end: 0,
                delay: const Duration(milliseconds: 500),
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOutCubic,
              ),
      ],
    );
  }

  Widget _buildTermsText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Text.rich(
        TextSpan(
          text: 'By continuing, you agree to our ',
          style: AppTypography.legal,
          children: [
            TextSpan(
              text: 'Terms of Service',
              style: AppTypography.legal.copyWith(
                color: AppColors.tealLight,
                decoration: TextDecoration.underline,
                decorationColor: AppColors.tealLight,
              ),
            ),
            const TextSpan(text: ' & '),
            TextSpan(
              text: 'Privacy Policy',
              style: AppTypography.legal.copyWith(
                color: AppColors.tealLight,
                decoration: TextDecoration.underline,
                decorationColor: AppColors.tealLight,
              ),
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
