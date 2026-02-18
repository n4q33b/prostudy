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
              const SizedBox(height: 8),
              // Subject header
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.screenPadding,
                ),
                child: Text(
                  subjectName,
                  style: AppTypography.headlineLarge,
                ),
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.screenPadding,
                ),
                child: Text(
                  s.nChapters(chapters.length),
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textMuted,
                  ),
                ),
              ),
              const SizedBox(height: 16),
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
              delay: Duration(milliseconds: 50 * index),
              duration: const Duration(milliseconds: 400),
            )
            .slideX(
              begin: 0.1,
              end: 0,
              delay: Duration(milliseconds: 50 * index),
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
      child: Material(
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
              color: AppColors.darkNavyLight.withValues(alpha: 0.55),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: isAvailable
                    ? AppColors.teal.withValues(alpha: 0.25)
                    : AppColors.textMuted.withValues(alpha: 0.12),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                // Chapter number badge
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: isAvailable
                        ? AppColors.teal.withValues(alpha: 0.15)
                        : AppColors.darkNavy.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(10),
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
                // Chapter name(s)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                      if (chapter.nameEn.isNotEmpty) ...[
                        const SizedBox(height: 2),
                        Text(
                          chapter.nameEn,
                          style: AppTypography.bodySmall.copyWith(
                            color: isAvailable
                                ? AppColors.textSecondary
                                : AppColors.textMuted.withValues(alpha: 0.7),
                            fontSize: 12,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                // Status icon
                Icon(
                  isAvailable ? Icons.play_circle_rounded : Icons.lock_rounded,
                  size: 24,
                  color: isAvailable
                      ? AppColors.limeGreen
                      : AppColors.textMuted.withValues(alpha: 0.5),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
