import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../core/constants/app_constants.dart';
import '../../core/l10n/app_strings.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

/// Full-screen WebView that renders a self-contained HTML simulation.
///
/// Loads the HTML from bundled assets for dev. In production this will
/// fetch from the R2 CDN instead.
class SimulationViewerScreen extends StatefulWidget {
  const SimulationViewerScreen({
    required this.subjectName,
    required this.chapterNumber,
    super.key,
  });

  final String subjectName;
  final int chapterNumber;

  @override
  State<SimulationViewerScreen> createState() => _SimulationViewerScreenState();
}

class _SimulationViewerScreenState extends State<SimulationViewerScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;
  String? _error;
  double _scrollProgress = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(AppColors.darkNavy)
      ..addJavaScriptChannel(
        'ScrollProgress',
        onMessageReceived: (message) {
          final progress = double.tryParse(message.message) ?? 0.0;
          if (mounted) setState(() => _scrollProgress = progress);
        },
      )
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (_) {
            if (mounted) {
              _injectCssVariables();
              _injectScrollListener();
              setState(() => _isLoading = false);
            }
          },
          onWebResourceError: (error) {
            if (mounted) {
              setState(() {
                _isLoading = false;
                _error = error.description;
              });
            }
          },
        ),
      );
    _loadSimulation();
  }

  Future<void> _loadSimulation() async {
    final chNum = widget.chapterNumber.toString().padLeft(2, '0');
    // Use dynamic subject name for asset path
    final subjectSlug = widget.subjectName.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '_');
    final assetKey = 'assets/simulations/${subjectSlug}_ch$chNum.html';

    try {
      final html = await rootBundle.loadString(assetKey);
      await _controller.loadHtmlString(html);
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _error = 'Simulation not found: $assetKey';
        });
      }
    }
  }

  void _injectCssVariables() {
    _controller.runJavaScript('''
      var psStyle = document.createElement('style');
      psStyle.textContent = ':root {' +
        '--ps-dark-navy: #0D3B4C;' +
        '--ps-dark-navy-light: #1A5568;' +
        '--ps-teal: #2D9596;' +
        '--ps-teal-light: #3DB5B6;' +
        '--ps-lime-green: #4ADE80;' +
        '--ps-white: #FFFFFF;' +
        '--ps-text-secondary: #B0C4CE;' +
        '--ps-text-muted: #7A9BA8;' +
        '--ps-error: #EF4444;' +
        '--ps-warning: #F59E0B;' +
        '--ps-font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;' +
        '--ps-border-radius: 16px;' +
        '--ps-spacing-s1: 8px;' +
        '--ps-spacing-s2: 16px;' +
        '--ps-spacing-s3: 24px;' +
        '--ps-spacing-s4: 32px;' +
        '--color-primary: #2D9596;' +
        '--color-success: #4ADE80;' +
        '--color-bg: #0D3B4C;' +
        '--color-card: #1A5568;' +
        '--color-text: #E8F4F5;' +
        '--color-text-muted: #7DBFBF;' +
        '--font-body: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;' +
      '}';
      document.head.appendChild(psStyle);
    ''');
  }

  void _injectScrollListener() {
    _controller.runJavaScript('''
      (function() {
        var lastReported = 0;
        window.addEventListener('scroll', function() {
          var h = document.documentElement.scrollHeight - window.innerHeight;
          var progress = h > 0 ? window.scrollY / h : 0;
          var rounded = Math.round(progress * 100) / 100;
          if (Math.abs(rounded - lastReported) >= 0.01) {
            lastReported = rounded;
            ScrollProgress.postMessage(rounded.toFixed(3));
          }
        });
      })();
    ''');
  }

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(null);
    final chNum = widget.chapterNumber.toString().padLeft(2, '0');

    return Scaffold(
      backgroundColor: AppColors.darkNavy,
      body: SafeArea(
        child: Column(
          children: [
            // Custom header (replaces AppBar)
            _buildHeader(chNum),
            // WebView content
            Expanded(
              child: _buildBody(s),
            ),
          ],
        ),
      ),
      floatingActionButton: AnimatedScale(
        scale: _scrollProgress >= 0.8 ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutBack,
        child: FloatingActionButton.extended(
          onPressed: () {
            HapticFeedback.mediumImpact();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  '${s.markDone}!',
                  style: AppTypography.bodyMedium.copyWith(color: AppColors.darkNavy),
                ),
                backgroundColor: AppColors.limeGreen,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                duration: const Duration(seconds: 2),
              ),
            );
          },
          backgroundColor: AppColors.limeGreen,
          foregroundColor: AppColors.darkNavy,
          icon: const Icon(Icons.check_rounded),
          label: Text(
            s.markDone,
            style: AppTypography.labelMedium.copyWith(
              color: AppColors.darkNavy,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(String chNum) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 8, 16, 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.darkNavy,
            AppColors.darkNavy.withValues(alpha: 0.95),
          ],
        ),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            color: AppColors.textSecondary,
            onPressed: () => context.go(
              '${AppConstants.chapterListRoute}/${widget.subjectName}',
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Ch $chNum',
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.teal,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  widget.subjectName,
                  style: AppTypography.titleMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.bookmark_border_rounded),
            color: AppColors.textSecondary,
            onPressed: () {
              // Placeholder — bookmark functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.share_outlined),
            color: AppColors.textSecondary,
            onPressed: () {
              // Placeholder — share functionality
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBody(AppStrings s) {
    if (_error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline_rounded,
                size: 56,
                color: AppColors.error.withValues(alpha: 0.7),
              ),
              const SizedBox(height: 16),
              Text(
                s.couldNotLoadSimulation,
                style: AppTypography.titleMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _error!,
                style: AppTypography.bodySmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return Stack(
      children: [
        WebViewWidget(controller: _controller),
        if (_isLoading)
          const Center(
            child: CircularProgressIndicator(color: AppColors.teal),
          ),
        // Floating scroll progress bar
        Positioned(
          left: 16,
          right: 16,
          bottom: 16,
          child: AnimatedOpacity(
            opacity: _scrollProgress > 0.01 ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 300),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: _scrollProgress,
                minHeight: 4,
                backgroundColor: AppColors.darkNavyLight,
                valueColor: const AlwaysStoppedAnimation<Color>(AppColors.teal),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
