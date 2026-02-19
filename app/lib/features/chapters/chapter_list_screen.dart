import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_constants.dart';
import '../../core/l10n/app_strings.dart';
import '../../core/models/chapter_data.dart';
import '../../core/providers/chapter_provider.dart';
import '../../core/providers/user_profile_provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

/// Displays all chapters for a selected subject.
///
/// Available chapters (with simulations) are tappable and navigate to the
/// simulation viewer. Locked chapters show a lock icon.
class ChapterListScreen extends ConsumerWidget {
  const ChapterListScreen({
    required this.subjectName,
    super.key,
  });

  final String subjectName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(userProfileProvider).valueOrNull;
    final medium = profile?.medium ?? 'marathi';
    final chapters = ref.watch(chapterListProvider('$medium|$subjectName'));
    final s = AppStrings.of(profile?.medium);

    return Scaffold(
      backgroundColor: AppColors.darkNavy,
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAppBar(context),
              // Subject header with gradient fade
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(
                  AppConstants.screenPadding, 8, AppConstants.screenPadding, 16,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.darkNavy,
                      AppColors.darkNavy.withValues(alpha: 0.0),
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(subjectName, style: AppTypography.headlineLarge),
                    const SizedBox(height: 4),
                    Text(
                      s.nChapters(chapters.length),
                      style: AppTypography.bodySmall.copyWith(color: AppColors.textMuted),
                    ),
                  ],
                ),
              ),
              // Chapter list
              Expanded(
                child: chapters.isEmpty
                    ? _buildEmptyState(s)
                    : _buildChapterList(context, chapters),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // App Bar
  // ---------------------------------------------------------------------------

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, AppConstants.screenPadding, 0),
      child: Row(
        children: [
          IconButton(
            onPressed: () => context.go(AppConstants.homeRoute),
            icon: const Icon(Icons.arrow_back_rounded),
            color: AppColors.textSecondary,
            iconSize: 24,
          ),
          const SizedBox(width: 4),
          Image.asset(
            AppConstants.logoPath,
            width: 28,
            height: 28,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: 8),
          ShaderMask(
            shaderCallback: (bounds) =>
                AppColors.brandGradient.createShader(bounds),
            child: Text(
              AppConstants.appName,
              style: AppTypography.headlineMedium.copyWith(
                fontWeight: FontWeight.w700,
                letterSpacing: -0.3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Empty State
  // ---------------------------------------------------------------------------

  Widget _buildEmptyState(AppStrings s) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.menu_book_rounded,
            size: 64,
            color: AppColors.textMuted.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 16),
          Text(
            s.chaptersComingSoon,
            style: AppTypography.titleMedium.copyWith(
              color: AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Chapter List
  // ---------------------------------------------------------------------------

  Widget _buildChapterList(
    BuildContext context,
    List<ChapterData> chapters,
  ) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(
        AppConstants.screenPadding,
        0,
        AppConstants.screenPadding,
        24,
      ),
      itemCount: chapters.length,
      itemBuilder: (context, index) {
        final chapter = chapters[index];
        return _ChapterCard(
          chapter: chapter,
          subjectName: subjectName,
        )
            .animate()
            .fadeIn(
              delay: Duration(milliseconds: 80 * index),
              duration: const Duration(milliseconds: 400),
            )
            .slideY(
              begin: 0.05,
              end: 0,
              delay: Duration(milliseconds: 80 * index),
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOutCubic,
            );
      },
    );
  }
}

// =============================================================================
// Chapter Card
// =============================================================================

class _ChapterCard extends StatelessWidget {
  const _ChapterCard({
    required this.chapter,
    required this.subjectName,
  });

  final ChapterData chapter;
  final String subjectName;

  @override
  Widget build(BuildContext context) {
    final isAvailable = chapter.hasSimulation;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Stack(
        children: [
          // Main card
          Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(14),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: isAvailable
                  ? () => context.go(
                        '${AppConstants.chapterListRoute}/$subjectName'
                        '/${AppConstants.simulationSegment}/${chapter.number}',
                      )
                  : null,
              splashColor: isAvailable
                  ? AppColors.teal.withValues(alpha: 0.15)
                  : Colors.transparent,
              highlightColor: isAvailable
                  ? AppColors.teal.withValues(alpha: 0.08)
                  : Colors.transparent,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: AppColors.glassOverlay,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: isAvailable
                        ? AppColors.cardBorder
                        : AppColors.textMuted.withValues(alpha: 0.12),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    // Circular chapter number badge
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: isAvailable
                            ? AppColors.teal.withValues(alpha: 0.15)
                            : AppColors.darkNavy.withValues(alpha: 0.5),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        chapter.number.toString().padLeft(2, '0'),
                        style: AppTypography.titleSmall.copyWith(
                          color: isAvailable ? AppColors.teal : AppColors.textMuted,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    // Chapter info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Chapter name
                          Text(
                            chapter.name,
                            style: AppTypography.titleSmall.copyWith(
                              fontWeight: FontWeight.w600,
                              color: isAvailable
                                  ? AppColors.textPrimary
                                  : AppColors.textMuted,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          // Time badge row
                          Row(
                            children: [
                              Icon(
                                Icons.timer_outlined,
                                size: 12,
                                color: AppColors.textMuted,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '~${chapter.estimatedMinutes} min',
                                style: AppTypography.labelSmall.copyWith(
                                  color: AppColors.textMuted,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    // XP chip
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.limeGreen.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('\u{1F31F}', style: TextStyle(fontSize: 10)),
                          const SizedBox(width: 3),
                          Text(
                            '${chapter.xpReward} XP',
                            style: AppTypography.labelSmall.copyWith(
                              color: AppColors.limeGreen,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Status icon
                    if (chapter.isCompleted)
                      const Icon(
                        Icons.check_circle_rounded,
                        size: 24,
                        color: AppColors.limeGreen,
                      )
                          .animate(onPlay: (c) => c.repeat(reverse: true))
                          .scaleXY(
                            begin: 1.0,
                            end: 1.1,
                            duration: const Duration(milliseconds: 1500),
                            curve: Curves.easeInOut,
                          )
                    else if (isAvailable)
                      const Icon(
                        Icons.play_circle_rounded,
                        size: 24,
                        color: AppColors.limeGreen,
                      )
                    else
                      Icon(
                        Icons.lock_rounded,
                        size: 24,
                        color: AppColors.textMuted.withValues(alpha: 0.5),
                      ),
                  ],
                ),
              ),
            ),
          ),
          // Locked overlay
          if (!isAvailable)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.darkNavy.withValues(alpha: 0.35),
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
