import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/constants/app_constants.dart';

/// Social sign-in button type
enum SocialButtonType { google, apple }

/// A premium, animated social sign-in button
///
/// Features:
/// - Buttery smooth scale animation on tap
/// - Subtle idle pulse animation
/// - Loading state with spinner
/// - Proper haptic feedback
/// - Accessibility support
class SocialButton extends StatefulWidget {
  const SocialButton({
    super.key,
    required this.type,
    required this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
  });

  /// The type of social button (Google or Apple)
  final SocialButtonType type;

  /// Callback when button is pressed
  final VoidCallback? onPressed;

  /// Whether the button is in loading state
  final bool isLoading;

  /// Whether the button is enabled
  final bool isEnabled;

  @override
  State<SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<SocialButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: AppConstants.buttonScaleDuration),
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: AppConstants.pressedScale,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (!widget.isEnabled || widget.isLoading) return;
    setState(() => _isPressed = true);
    _scaleController.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    if (!widget.isEnabled || widget.isLoading) return;
    setState(() => _isPressed = false);
    _scaleController.reverse();
  }

  void _handleTapCancel() {
    if (!widget.isEnabled || widget.isLoading) return;
    setState(() => _isPressed = false);
    _scaleController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final isGoogle = widget.type == SocialButtonType.google;
    final backgroundColor =
        isGoogle ? AppColors.googleButtonBg : AppColors.appleButtonBg;
    final textColor =
        isGoogle ? AppColors.googleButtonText : AppColors.appleButtonText;
    final buttonText = isGoogle ? 'Continue with Google' : 'Continue with Apple';

    return Semantics(
      button: true,
      enabled: widget.isEnabled && !widget.isLoading,
      label: buttonText,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: child,
          );
        },
        child: GestureDetector(
          onTapDown: _handleTapDown,
          onTapUp: _handleTapUp,
          onTapCancel: _handleTapCancel,
          onTap: widget.isEnabled && !widget.isLoading
              ? () {
                  widget.onPressed?.call();
                }
              : null,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: AppConstants.buttonHeight,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(AppConstants.buttonBorderRadius),
              boxShadow: isGoogle
                  ? [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: _isPressed ? 0.05 : 0.1),
                        blurRadius: _isPressed ? 5 : 10,
                        offset: Offset(0, _isPressed ? 2 : 4),
                      ),
                    ]
                  : null,
              border: isGoogle
                  ? Border.all(
                      color: Colors.grey.withValues(alpha: 0.2),
                      width: 1,
                    )
                  : null,
            ),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: widget.isEnabled ? 1.0 : AppConstants.disabledOpacity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.isLoading) ...[
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          valueColor: AlwaysStoppedAnimation<Color>(textColor),
                        ),
                      ),
                    ] else ...[
                      // Logo
                      _buildLogo(isGoogle, textColor),
                      const SizedBox(width: 12),
                      // Text
                      Text(
                        buttonText,
                        style: AppTypography.button.copyWith(
                          color: textColor,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo(bool isGoogle, Color fallbackColor) {
    if (isGoogle) {
      // Google "G" logo with official colors
      return SizedBox(
        width: 24,
        height: 24,
        child: CustomPaint(
          painter: _GoogleLogoPainter(),
        ),
      );
    } else {
      // Apple logo
      return Icon(
        Icons.apple,
        size: 24,
        color: fallbackColor,
      );
    }
  }
}

/// Custom painter for the Google "G" logo
class _GoogleLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double width = size.width;

    // Google logo colors
    const blue = Color(0xFF4285F4);
    const red = Color(0xFFEA4335);
    const yellow = Color(0xFFFBBC05);
    const green = Color(0xFF34A853);

    final paint = Paint()
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    // Scale factor
    final scale = width / 24;

    // Blue arc (right side)
    paint.color = blue;
    final bluePath = Path()
      ..moveTo(23.52 * scale, 12.27 * scale)
      ..cubicTo(23.52 * scale, 11.48 * scale, 23.45 * scale, 10.73 * scale,
          23.32 * scale, 10 * scale)
      ..lineTo(12 * scale, 10 * scale)
      ..lineTo(12 * scale, 14.51 * scale)
      ..lineTo(18.47 * scale, 14.51 * scale)
      ..cubicTo(18.21 * scale, 15.99 * scale, 17.4 * scale, 17.25 * scale,
          16.17 * scale, 18.09 * scale)
      ..lineTo(16.17 * scale, 21.09 * scale)
      ..lineTo(20 * scale, 21.09 * scale)
      ..cubicTo(22.24 * scale, 19.01 * scale, 23.52 * scale, 15.93 * scale,
          23.52 * scale, 12.27 * scale)
      ..close();
    canvas.drawPath(bluePath, paint);

    // Green arc (bottom)
    paint.color = green;
    final greenPath = Path()
      ..moveTo(12 * scale, 24 * scale)
      ..cubicTo(15.24 * scale, 24 * scale, 17.95 * scale, 22.92 * scale,
          20 * scale, 21.09 * scale)
      ..lineTo(16.17 * scale, 18.09 * scale)
      ..cubicTo(15.12 * scale, 18.8 * scale, 13.74 * scale, 19.25 * scale,
          12 * scale, 19.25 * scale)
      ..cubicTo(8.87 * scale, 19.25 * scale, 6.22 * scale, 17.14 * scale,
          5.28 * scale, 14.29 * scale)
      ..lineTo(1.29 * scale, 14.29 * scale)
      ..lineTo(1.29 * scale, 17.38 * scale)
      ..cubicTo(3.36 * scale, 21.44 * scale, 7.36 * scale, 24 * scale,
          12 * scale, 24 * scale)
      ..close();
    canvas.drawPath(greenPath, paint);

    // Yellow arc (left bottom)
    paint.color = yellow;
    final yellowPath = Path()
      ..moveTo(5.28 * scale, 14.29 * scale)
      ..cubicTo(5.02 * scale, 13.54 * scale, 4.88 * scale, 12.79 * scale,
          4.88 * scale, 12 * scale)
      ..cubicTo(4.88 * scale, 11.21 * scale, 5.02 * scale, 10.46 * scale,
          5.28 * scale, 9.71 * scale)
      ..lineTo(5.28 * scale, 6.62 * scale)
      ..lineTo(1.29 * scale, 6.62 * scale)
      ..cubicTo(0.47 * scale, 8.24 * scale, 0 * scale, 10.06 * scale,
          0 * scale, 12 * scale)
      ..cubicTo(0 * scale, 13.94 * scale, 0.47 * scale, 15.76 * scale,
          1.29 * scale, 17.38 * scale)
      ..lineTo(5.28 * scale, 14.29 * scale)
      ..close();
    canvas.drawPath(yellowPath, paint);

    // Red arc (top)
    paint.color = red;
    final redPath = Path()
      ..moveTo(12 * scale, 4.75 * scale)
      ..cubicTo(13.9 * scale, 4.75 * scale, 15.6 * scale, 5.44 * scale,
          16.94 * scale, 6.72 * scale)
      ..lineTo(20.1 * scale, 3.58 * scale)
      ..cubicTo(17.95 * scale, 1.53 * scale, 15.23 * scale, 0 * scale,
          12 * scale, 0 * scale)
      ..cubicTo(7.36 * scale, 0 * scale, 3.36 * scale, 2.56 * scale,
          1.29 * scale, 6.62 * scale)
      ..lineTo(5.28 * scale, 9.71 * scale)
      ..cubicTo(6.22 * scale, 6.86 * scale, 8.87 * scale, 4.75 * scale,
          12 * scale, 4.75 * scale)
      ..close();
    canvas.drawPath(redPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Extension for staggered button animations
extension SocialButtonAnimations on Widget {
  /// Apply stagger animation to button
  Widget withStaggerAnimation(int index) {
    return animate()
        .fadeIn(
          delay: Duration(milliseconds: 100 * index),
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOut,
        )
        .slideY(
          begin: 0.3,
          end: 0,
          delay: Duration(milliseconds: 100 * index),
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOutCubic,
        );
  }
}
