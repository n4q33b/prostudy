import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
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

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(AppColors.darkNavy)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (_) {
            if (mounted) setState(() => _isLoading = false);
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
    // Asset key matches the convention in ChapterData.simulationAssetPath
    final assetKey = 'assets/simulations/math_ch$chNum.html';

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

  @override
  Widget build(BuildContext context) {
    final chNum = widget.chapterNumber.toString().padLeft(2, '0');
    final title = 'Ch $chNum — ${widget.subjectName}';

    return Scaffold(
      backgroundColor: AppColors.darkNavy,
      appBar: AppBar(
        backgroundColor: AppColors.darkNavy,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          color: AppColors.textSecondary,
          onPressed: () => context.go(
            '${AppConstants.chapterListRoute}/${widget.subjectName}',
          ),
        ),
        title: Text(
          title,
          style: AppTypography.titleMedium.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
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
                AppStrings.of(null).couldNotLoadSimulation,
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
            child: CircularProgressIndicator(
              color: AppColors.teal,
            ),
          ),
      ],
    );
  }
}
