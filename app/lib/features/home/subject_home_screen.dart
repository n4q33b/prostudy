import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/providers/user_profile_provider.dart';
import '../../core/models/user_profile.dart';

/// Subject selection home screen for returning (onboarded) users
///
/// Displays a grid of subjects based on the user's selected class level,
/// with a custom app bar showing profile info, trial status, and settings access.
class SubjectHomeScreen extends ConsumerWidget {
  const SubjectHomeScreen({super.key});

  // ---------------------------------------------------------------------------
  // Subject Data by Class Level (Maharashtra Board)
  // ---------------------------------------------------------------------------

  /// Subjects available for each class level.
  /// Classes 5-6 share a curriculum, 7-8 share one, and 9-10 share one.
  static const Map<int, List<Map<String, dynamic>>> classSubjects = {
    5: [
      {'name': 'Marathi', 'icon': Icons.translate_rounded, 'chapters': 14},
      {'name': 'Hindi', 'icon': Icons.language_rounded, 'chapters': 12},
      {'name': 'English', 'icon': Icons.abc_rounded, 'chapters': 13},
      {'name': 'Mathematics', 'icon': Icons.calculate_rounded, 'chapters': 15},
      {'name': 'EVS', 'icon': Icons.eco_rounded, 'chapters': 16},
      {'name': 'GK', 'icon': Icons.lightbulb_rounded, 'chapters': 10},
    ],
    6: [
      {'name': 'Marathi', 'icon': Icons.translate_rounded, 'chapters': 15},
      {'name': 'Hindi', 'icon': Icons.language_rounded, 'chapters': 13},
      {'name': 'English', 'icon': Icons.abc_rounded, 'chapters': 14},
      {'name': 'Mathematics', 'icon': Icons.calculate_rounded, 'chapters': 16},
      {'name': 'EVS', 'icon': Icons.eco_rounded, 'chapters': 17},
      {'name': 'GK', 'icon': Icons.lightbulb_rounded, 'chapters': 10},
    ],
    7: [
      {'name': 'Marathi', 'icon': Icons.translate_rounded, 'chapters': 16},
      {'name': 'Hindi', 'icon': Icons.language_rounded, 'chapters': 14},
      {'name': 'English', 'icon': Icons.abc_rounded, 'chapters': 15},
      {'name': 'Mathematics', 'icon': Icons.calculate_rounded, 'chapters': 18},
      {'name': 'Science', 'icon': Icons.science_rounded, 'chapters': 17},
      {'name': 'History', 'icon': Icons.account_balance_rounded, 'chapters': 12},
      {'name': 'Geography', 'icon': Icons.public_rounded, 'chapters': 11},
      {'name': 'Civics', 'icon': Icons.gavel_rounded, 'chapters': 10},
    ],
    8: [
      {'name': 'Marathi', 'icon': Icons.translate_rounded, 'chapters': 16},
      {'name': 'Hindi', 'icon': Icons.language_rounded, 'chapters': 14},
      {'name': 'English', 'icon': Icons.abc_rounded, 'chapters': 15},
      {'name': 'Mathematics', 'icon': Icons.calculate_rounded, 'chapters': 18},
      {'name': 'Science', 'icon': Icons.science_rounded, 'chapters': 18},
      {'name': 'History', 'icon': Icons.account_balance_rounded, 'chapters': 13},
      {'name': 'Geography', 'icon': Icons.public_rounded, 'chapters': 12},
      {'name': 'Civics', 'icon': Icons.gavel_rounded, 'chapters': 10},
    ],
    9: [
      {'name': 'Marathi', 'icon': Icons.translate_rounded, 'chapters': 17},
      {'name': 'Hindi', 'icon': Icons.language_rounded, 'chapters': 15},
      {'name': 'English', 'icon': Icons.abc_rounded, 'chapters': 16},
      {'name': 'Mathematics', 'icon': Icons.calculate_rounded, 'chapters': 20},
      {'name': 'Science', 'icon': Icons.science_rounded, 'chapters': 19},
      {'name': 'History', 'icon': Icons.account_balance_rounded, 'chapters': 14},
      {'name': 'Geography', 'icon': Icons.public_rounded, 'chapters': 13},
      {'name': 'Civics', 'icon': Icons.gavel_rounded, 'chapters': 11},
      {'name': 'Economics', 'icon': Icons.trending_up_rounded, 'chapters': 10},
    ],
    10: [
      {'name': 'Marathi', 'icon': Icons.translate_rounded, 'chapters': 17},
      {'name': 'Hindi', 'icon': Icons.language_rounded, 'chapters': 15},
      {'name': 'English', 'icon': Icons.abc_rounded, 'chapters': 16},
      {'name': 'Mathematics', 'icon': Icons.calculate_rounded, 'chapters': 22},
      {'name': 'Science', 'icon': Icons.science_rounded, 'chapters': 20},
      {'name': 'History', 'icon': Icons.account_balance_rounded, 'chapters': 15},
      {'name': 'Geography', 'icon': Icons.public_rounded, 'chapters': 14},
      {'name': 'Civics', 'icon': Icons.gavel_rounded, 'chapters': 12},
      {'name': 'Economics', 'icon': Icons.trending_up_rounded, 'chapters': 11},
    ],
  };

  /// Friendly display name for a board identifier
  static String _boardDisplayName(String board) {
    switch (board) {
      case AppConstants.boardMaharashtra:
        return 'Maharashtra';
      case AppConstants.boardCbse:
        return 'CBSE';
      case AppConstants.boardNcert:
        return 'NCERT';
      default:
        return board;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(userProfileProvider).valueOrNull;

    // Determine subjects for the user's class level (fallback to class 7)
    final classLevel = profile?.classLevel ?? 7;
    final subjects = classSubjects[classLevel] ?? classSubjects[7]!;

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
              // Custom App Bar
              _buildAppBar(context, profile),

              // Profile info chips
              if (profile != null) _buildProfileChips(profile),

              // Trial banner
              if (profile != null && profile.isTrialActive)
                _buildTrialBanner(profile),

              const SizedBox(height: 20),

              // Section title
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.screenPadding,
                ),
                child: Text(
                  'Your Subjects',
                  style: AppTypography.headlineLarge,
                ),
              ),
              const SizedBox(height: 16),

              // Subject cards grid
              Expanded(
                child: _buildSubjectGrid(context, subjects),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: _buildAiChatFab(context),
    );
  }

  // ---------------------------------------------------------------------------
  // App Bar
  // ---------------------------------------------------------------------------

  Widget _buildAppBar(BuildContext context, UserProfile? profile) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppConstants.screenPadding,
        12,
        AppConstants.screenPadding,
        8,
      ),
      child: Row(
        children: [
          // Logo + brand name
          Image.asset(
            AppConstants.logoPath,
            width: 32,
            height: 32,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: 10),
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
          const Spacer(),
          // Settings gear
          Material(
            color: Colors.transparent,
            shape: const CircleBorder(),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () => context.go(AppConstants.settingsRoute),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Icon(
                  Icons.settings_rounded,
                  size: 24,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Profile Chips (Board / Class / Medium)
  // ---------------------------------------------------------------------------

  Widget _buildProfileChips(UserProfile profile) {
    final boardName = _boardDisplayName(profile.board);
    final className = 'Class ${profile.classLevel}';
    final medium = profile.medium;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.screenPadding,
      ),
      child: Wrap(
        spacing: 8,
        runSpacing: 6,
        children: [
          _ProfileChip(label: boardName),
          _DotSeparator(),
          _ProfileChip(label: className),
          _DotSeparator(),
          _ProfileChip(label: medium),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Trial Banner
  // ---------------------------------------------------------------------------

  Widget _buildTrialBanner(UserProfile profile) {
    final daysLeft = profile.trialDaysRemaining;
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppConstants.screenPadding,
        12,
        AppConstants.screenPadding,
        0,
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.limeGreen.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.limeGreen.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Text(
              '\u{1F381}', // gift emoji
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Free Trial: $daysLeft ${daysLeft == 1 ? 'day' : 'days'} remaining',
                style: AppTypography.labelMedium.copyWith(
                  color: AppColors.limeGreen,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Subject Grid
  // ---------------------------------------------------------------------------

  Widget _buildSubjectGrid(
    BuildContext context,
    List<Map<String, dynamic>> subjects,
  ) {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(
        AppConstants.screenPadding,
        0,
        AppConstants.screenPadding,
        100, // extra bottom padding for FAB clearance
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 14,
        crossAxisSpacing: 14,
        childAspectRatio: 0.92,
      ),
      itemCount: subjects.length,
      itemBuilder: (context, index) {
        final subject = subjects[index];
        return _SubjectCard(
          name: subject['name'] as String,
          icon: subject['icon'] as IconData,
          chapters: subject['chapters'] as int,
          progress: 0.0, // Placeholder -- no progress yet
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  '${subject['name']} -- Coming soon',
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.white,
                  ),
                ),
                backgroundColor: AppColors.darkNavyLight,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                duration: const Duration(seconds: 2),
              ),
            );
          },
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // AI Chat Tutor FAB
  // ---------------------------------------------------------------------------

  Widget _buildAiChatFab(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'AI Chat Tutor -- Coming soon',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.white,
              ),
            ),
            backgroundColor: AppColors.darkNavyLight,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            duration: const Duration(seconds: 2),
          ),
        );
      },
      backgroundColor: AppColors.teal,
      foregroundColor: AppColors.white,
      elevation: 6,
      icon: const Icon(Icons.smart_toy_rounded),
      label: Text(
        'AI Chat Tutor',
        style: AppTypography.labelMedium.copyWith(
          color: AppColors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// =============================================================================
// Private Helper Widgets
// =============================================================================

/// A small chip showing a single piece of profile info (board, class, medium)
class _ProfileChip extends StatelessWidget {
  const _ProfileChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.teal.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.teal.withValues(alpha: 0.25),
          width: 1,
        ),
      ),
      child: Text(
        label,
        style: AppTypography.labelSmall.copyWith(
          color: AppColors.tealLight,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

/// Dot separator displayed between profile chips
class _DotSeparator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        '\u2022', // bullet character
        style: AppTypography.bodySmall.copyWith(
          color: AppColors.textMuted,
          fontSize: 10,
        ),
      ),
    );
  }
}

/// A single subject card in the 2-column grid.
///
/// Shows the subject icon, name, chapter count, and a progress bar.
class _SubjectCard extends StatelessWidget {
  const _SubjectCard({
    required this.name,
    required this.icon,
    required this.chapters,
    required this.progress,
    required this.onTap,
  });

  final String name;
  final IconData icon;
  final int chapters;
  final double progress;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        splashColor: AppColors.teal.withValues(alpha: 0.15),
        highlightColor: AppColors.teal.withValues(alpha: 0.08),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.darkNavyLight.withValues(alpha: 0.55),
            borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
            border: Border.all(
              color: AppColors.teal.withValues(alpha: 0.15),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.12),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon container with teal accent
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.teal.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  size: 24,
                  color: AppColors.teal,
                ),
              ),
              const SizedBox(height: 14),

              // Subject name
              Text(
                name,
                style: AppTypography.titleMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),

              // Chapter count
              Text(
                '$chapters Chapters',
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textMuted,
                ),
              ),

              const Spacer(),

              // Progress bar
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Progress',
                        style: AppTypography.labelSmall.copyWith(
                          color: AppColors.textMuted,
                          fontSize: 10,
                        ),
                      ),
                      Text(
                        '${(progress * 100).toInt()}%',
                        style: AppTypography.labelSmall.copyWith(
                          color: AppColors.tealLight,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 4,
                      backgroundColor: AppColors.darkNavy.withValues(alpha: 0.5),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        AppColors.teal,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
