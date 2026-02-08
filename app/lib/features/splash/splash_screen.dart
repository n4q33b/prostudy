import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../core/constants/app_constants.dart';

/// Premium animated splash screen for ProStudy
///
/// Features:
/// - Elegant logo fade-in with spring scale animation
/// - Subtle shimmer/glow effect
/// - Background particle animation for premium feel
/// - Smooth transition to login screen
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _shimmerController;
  late AnimationController _particleController;

  late Animation<double> _logoScaleAnimation;
  late Animation<double> _logoFadeAnimation;
  late Animation<double> _shimmerAnimation;

  @override
  void initState() {
    super.initState();
    _setupSystemUI();
    _initializeAnimations();
    _startAnimationSequence();
  }

  void _setupSystemUI() {
    SystemChrome.setSystemUIOverlayStyle(AppTheme.darkOverlayStyle);
  }

  void _initializeAnimations() {
    // Logo animation controller
    _logoController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: AppConstants.splashLogoScaleDuration),
    );

    // Shimmer animation controller
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    // Particle animation controller
    _particleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );

    // Logo scale animation with elastic curve
    _logoScaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: Curves.elasticOut,
    ));

    // Logo fade animation
    _logoFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
    ));

    // Shimmer animation
    _shimmerAnimation = Tween<double>(
      begin: -1.0,
      end: 2.0,
    ).animate(CurvedAnimation(
      parent: _shimmerController,
      curve: Curves.easeInOut,
    ));
  }

  void _startAnimationSequence() async {
    // Wait for initial delay
    await Future.delayed(
        Duration(milliseconds: AppConstants.splashLogoFadeDelay));

    // Start logo animation
    _logoController.forward();

    // Start shimmer animation (looping)
    _shimmerController.repeat();

    // Start particle animation (looping)
    _particleController.repeat();

    // Navigate after total duration
    await Future.delayed(
      Duration(
        milliseconds: AppConstants.splashTotalDuration -
            AppConstants.splashLogoFadeDelay,
      ),
    );

    if (mounted) {
      // TODO: Remove dev bypass - original: context.go(AppConstants.loginRoute);
      context.go(AppConstants.homeRoute); // DEV MODE: Auth bypass
    }
  }

  @override
  void dispose() {
    _logoController.dispose();
    _shimmerController.dispose();
    _particleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkNavy,
      body: Stack(
        children: [
          // Background particles
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _particleController,
              builder: (context, child) {
                return CustomPaint(
                  painter: ParticlePainter(
                    progress: _particleController.value,
                    particleCount: AppConstants.particleCount,
                  ),
                );
              },
            ),
          ),

          // Centered logo with animations
          Center(
            child: AnimatedBuilder(
              animation: Listenable.merge([_logoController, _shimmerController]),
              builder: (context, child) {
                return Opacity(
                  opacity: _logoFadeAnimation.value,
                  child: Transform.scale(
                    scale: _logoScaleAnimation.value,
                    child: _buildLogoWithGlow(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogoWithGlow() {
    return SizedBox(
      width: AppConstants.logoSizeSplash,
      height: AppConstants.logoSizeSplash,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Glow effect behind logo
          Container(
            width: AppConstants.logoSizeSplash * 0.8,
            height: AppConstants.logoSizeSplash * 0.8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.teal.withValues(alpha: 0.3),
                  blurRadius: 40,
                  spreadRadius: 10,
                ),
                BoxShadow(
                  color: AppColors.limeGreen.withValues(alpha: 0.2),
                  blurRadius: 60,
                  spreadRadius: 20,
                ),
              ],
            ),
          ),

          // Logo with shimmer
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                // Actual logo
                Image.asset(
                  AppConstants.logoPath,
                  width: AppConstants.logoSizeSplash,
                  height: AppConstants.logoSizeSplash,
                  fit: BoxFit.contain,
                ),

                // Shimmer overlay
                Positioned.fill(
                  child: AnimatedBuilder(
                    animation: _shimmerAnimation,
                    builder: (context, child) {
                      return ShaderMask(
                        shaderCallback: (bounds) {
                          return LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: const [
                              Colors.transparent,
                              Colors.white24,
                              Colors.transparent,
                            ],
                            stops: const [0.0, 0.5, 1.0],
                            transform: _ShimmerTransform(_shimmerAnimation.value),
                          ).createShader(bounds);
                        },
                        blendMode: BlendMode.srcATop,
                        child: Container(
                          color: Colors.white,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    )
        .animate(
          onComplete: (_) {},
        )
        .shimmer(
          delay: const Duration(milliseconds: 1500),
          duration: const Duration(milliseconds: 1000),
          color: AppColors.white.withValues(alpha: 0.2),
        );
  }
}

/// Custom gradient transform for shimmer effect
class _ShimmerTransform extends GradientTransform {
  const _ShimmerTransform(this.progress);

  final double progress;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * progress, 0.0, 0.0);
  }
}

/// Custom painter for background particle animation
class ParticlePainter extends CustomPainter {
  ParticlePainter({
    required this.progress,
    required this.particleCount,
  });

  final double progress;
  final int particleCount;

  // Pre-computed random values for particles
  static List<_Particle>? _particles;

  @override
  void paint(Canvas canvas, Size size) {
    // Initialize particles once
    _particles ??= List.generate(particleCount, (index) {
      final random = math.Random(index);
      return _Particle(
        x: random.nextDouble(),
        y: random.nextDouble(),
        size: AppConstants.particleMinSize +
            random.nextDouble() *
                (AppConstants.particleMaxSize - AppConstants.particleMinSize),
        speed: AppConstants.particleMinSpeed +
            random.nextDouble() *
                (AppConstants.particleMaxSpeed - AppConstants.particleMinSpeed),
        opacity: AppConstants.particleMinOpacity +
            random.nextDouble() *
                (AppConstants.particleMaxOpacity - AppConstants.particleMinOpacity),
        phase: random.nextDouble() * 2 * math.pi,
      );
    });

    final paint = Paint()..style = PaintingStyle.fill;

    for (final particle in _particles!) {
      // Calculate animated position
      final animatedY =
          (particle.y + progress * particle.speed) % 1.0;
      final animatedX =
          particle.x + math.sin(progress * 2 * math.pi + particle.phase) * 0.02;

      // Fade in/out near edges
      double opacity = particle.opacity;
      if (animatedY < 0.1) {
        opacity *= animatedY / 0.1;
      } else if (animatedY > 0.9) {
        opacity *= (1.0 - animatedY) / 0.1;
      }

      paint.color = AppColors.tealLight.withValues(alpha: opacity);

      canvas.drawCircle(
        Offset(
          animatedX * size.width,
          animatedY * size.height,
        ),
        particle.size,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant ParticlePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

/// Particle data class
class _Particle {
  const _Particle({
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
    required this.opacity,
    required this.phase,
  });

  final double x;
  final double y;
  final double size;
  final double speed;
  final double opacity;
  final double phase;
}
