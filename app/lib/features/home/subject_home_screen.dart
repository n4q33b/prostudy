import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_constants.dart';
import '../../core/l10n/app_strings.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/providers/gamification_provider.dart';
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

  // ---------------------------------------------------------------------------
  // Class 5 — per-medium subject lists
  // ---------------------------------------------------------------------------

  static const List<Map<String, dynamic>> _class5Marathi = [
    {'name': 'गणित', 'icon': Icons.calculate_rounded, 'chapters': 16},
    {'name': 'बालभारती', 'icon': Icons.auto_stories_rounded, 'chapters': 28},
    {'name': 'सुलभभारती', 'icon': Icons.menu_book_rounded, 'chapters': 40},
    {'name': 'सुगमभारती', 'icon': Icons.book_rounded, 'chapters': 34},
    {'name': 'माय इंग्लिश', 'icon': Icons.abc_rounded, 'chapters': 7},
    {'name': 'सिंधुभारती', 'icon': Icons.translate_rounded, 'chapters': 20},
    {'name': 'परिसर अभ्यास भाग-१', 'icon': Icons.eco_rounded, 'chapters': 25},
    {'name': 'परिसर अभ्यास भाग-२', 'icon': Icons.public_rounded, 'chapters': 10},
    {'name': 'खेळू, करू, शिकू', 'icon': Icons.sports_rounded, 'chapters': 17},
  ];

  static const List<Map<String, dynamic>> _class5Hindi = [
    {'name': 'गणित', 'icon': Icons.calculate_rounded, 'chapters': 16},
    {'name': 'हिंदी बालभारती', 'icon': Icons.auto_stories_rounded, 'chapters': 45},
    {'name': 'मराठी सुलभभारती', 'icon': Icons.menu_book_rounded, 'chapters': 28},
    {'name': 'मराठी सुगमभारती', 'icon': Icons.book_rounded, 'chapters': 20},
    {'name': 'My English Book', 'icon': Icons.abc_rounded, 'chapters': 7},
    {'name': 'परिसर अध्ययन भाग-१', 'icon': Icons.eco_rounded, 'chapters': 25},
    {'name': 'परिसर अध्ययन भाग-२', 'icon': Icons.public_rounded, 'chapters': 10},
    {'name': 'खेलें करें सीखें', 'icon': Icons.sports_rounded, 'chapters': 17},
  ];

  static const List<Map<String, dynamic>> _class5English = [
    {'name': 'Mathematics', 'icon': Icons.calculate_rounded, 'chapters': 16},
    {'name': 'English Balbharati', 'icon': Icons.auto_stories_rounded, 'chapters': 34},
    {'name': 'हिंदी सुलभभारती', 'icon': Icons.menu_book_rounded, 'chapters': 40},
    {'name': 'हिंदी सुगमभारती', 'icon': Icons.book_rounded, 'chapters': 34},
    {'name': 'मराठी सुलभभारती', 'icon': Icons.translate_rounded, 'chapters': 28},
    {'name': 'मराठी सुगमभारती', 'icon': Icons.translate_rounded, 'chapters': 20},
    {'name': 'Environmental Studies Part 1', 'icon': Icons.eco_rounded, 'chapters': 25},
    {'name': 'Environmental Studies Part 2', 'icon': Icons.public_rounded, 'chapters': 10},
    {'name': 'Play Do Learn', 'icon': Icons.sports_rounded, 'chapters': 17},
    {'name': 'ગુજરાતી સાહિત્ય પરિચય', 'icon': Icons.language_rounded, 'chapters': 17},
    {'name': 'ಕನ್ನಡ ಸುಗಮಭಾರತಿ', 'icon': Icons.language_rounded, 'chapters': 28},
    {'name': 'తెలుగు సరళ భారతి', 'icon': Icons.language_rounded, 'chapters': 22},
    {'name': 'सिंधू भारती', 'icon': Icons.language_rounded, 'chapters': 20},
    {'name': 'تعارفِ اُردو', 'icon': Icons.language_rounded, 'chapters': 23},
  ];

  static const List<Map<String, dynamic>> _class5Gujarati = [
    {'name': 'ગણિત', 'icon': Icons.calculate_rounded, 'chapters': 16},
    {'name': 'ગુજરાતી બાલભારતી', 'icon': Icons.auto_stories_rounded, 'chapters': 27},
    {'name': 'हिंदी सुलभभारती', 'icon': Icons.menu_book_rounded, 'chapters': 40},
    {'name': 'हिंदी सुगमभारती', 'icon': Icons.book_rounded, 'chapters': 34},
    {'name': 'मराठी सुलभभारती', 'icon': Icons.translate_rounded, 'chapters': 28},
    {'name': 'मराठी सुगमभारती', 'icon': Icons.translate_rounded, 'chapters': 20},
    {'name': 'My English Book', 'icon': Icons.abc_rounded, 'chapters': 6},
    {'name': 'પરિસર અભ્યાસ ભાગ-૧', 'icon': Icons.eco_rounded, 'chapters': 25},
    {'name': 'પરિસર અભ્યાસ ભાગ-૨', 'icon': Icons.public_rounded, 'chapters': 10},
    {'name': 'રમીએ કરીએ શીખીએ', 'icon': Icons.sports_rounded, 'chapters': 17},
  ];

  static const List<Map<String, dynamic>> _class5Kannada = [
    {'name': 'ಗಣಿತ', 'icon': Icons.calculate_rounded, 'chapters': 16},
    {'name': 'ಕನ್ನಡ ಬಾಲಭಾರತಿ', 'icon': Icons.auto_stories_rounded, 'chapters': 23},
    {'name': 'हिंदी सुलभभारती', 'icon': Icons.menu_book_rounded, 'chapters': 40},
    {'name': 'हिंदी सुगमभारती', 'icon': Icons.book_rounded, 'chapters': 34},
    {'name': 'मराठी सुलभभारती', 'icon': Icons.translate_rounded, 'chapters': 28},
    {'name': 'मराठी सुगमभारती', 'icon': Icons.translate_rounded, 'chapters': 20},
    {'name': 'My English Book', 'icon': Icons.abc_rounded, 'chapters': 7},
    {'name': 'ಪರಿಸರ ಅಭ್ಯಾಸ ಭಾಗ-೧', 'icon': Icons.eco_rounded, 'chapters': 25},
    {'name': 'ಪರಿಸರ ಅಭ್ಯಾಸ ಭಾಗ-೨', 'icon': Icons.public_rounded, 'chapters': 10},
    {'name': 'ಆಡೋಣ ಮಾಡೋಣ ಕಲಿಯೋಣ', 'icon': Icons.sports_rounded, 'chapters': 16},
  ];

  static const List<Map<String, dynamic>> _class5Telugu = [
    {'name': 'గణితశాస్త్రం', 'icon': Icons.calculate_rounded, 'chapters': 16},
    {'name': 'తెలుగు బాలభారతి', 'icon': Icons.auto_stories_rounded, 'chapters': 29},
    {'name': 'हिंदी सुलभभारती', 'icon': Icons.menu_book_rounded, 'chapters': 40},
    {'name': 'हिंदी सुगमभारती', 'icon': Icons.book_rounded, 'chapters': 34},
    {'name': 'मराठी सुलभभारती', 'icon': Icons.translate_rounded, 'chapters': 28},
    {'name': 'मराठी सुगमभारती', 'icon': Icons.translate_rounded, 'chapters': 20},
    {'name': 'My English Book', 'icon': Icons.abc_rounded, 'chapters': 6},
    {'name': 'పరిసరాల అధ్యయనం భాగం-౧', 'icon': Icons.eco_rounded, 'chapters': 25},
    {'name': 'పరిసరాల అధ్యయనం భాగం-౨', 'icon': Icons.public_rounded, 'chapters': 10},
    {'name': 'ఆడుదాం చేద్దాం నేర్చుకొందాం', 'icon': Icons.sports_rounded, 'chapters': 16},
  ];

  static const List<Map<String, dynamic>> _class5Urdu = [
    {'name': 'ریاضی', 'icon': Icons.calculate_rounded, 'chapters': 16},
    {'name': 'اُردو بال بھارتی', 'icon': Icons.auto_stories_rounded, 'chapters': 26},
    {'name': 'हिंदी सुलभभारती', 'icon': Icons.menu_book_rounded, 'chapters': 40},
    {'name': 'हिंदी सुगमभारती', 'icon': Icons.book_rounded, 'chapters': 34},
    {'name': 'मराठी सुलभभारती', 'icon': Icons.translate_rounded, 'chapters': 28},
    {'name': 'मराठी सुगमभारती', 'icon': Icons.translate_rounded, 'chapters': 20},
    {'name': 'My English Book', 'icon': Icons.abc_rounded, 'chapters': 7},
    {'name': 'ماحول کا مطالعہ حصّہ-۱', 'icon': Icons.eco_rounded, 'chapters': 25},
    {'name': 'ماحول کا مطالعہ حصّہ-۲', 'icon': Icons.public_rounded, 'chapters': 10},
    {'name': 'کھیلیں کریں سیکھیں', 'icon': Icons.sports_rounded, 'chapters': 17},
  ];

  /// Returns subjects for a given class + medium combination.
  static List<Map<String, dynamic>> getSubjects(int classLevel, String medium) {
    if (classLevel == 5) {
      switch (medium.toLowerCase()) {
        case 'marathi': return _class5Marathi;
        case 'hindi': return _class5Hindi;
        case 'english': return _class5English;
        case 'gujarati': return _class5Gujarati;
        case 'kannada': return _class5Kannada;
        case 'telugu': return _class5Telugu;
        case 'urdu': return _class5Urdu;
      }
    }
    // Fallback for other classes (placeholder data until those classes are added)
    return classSubjects[classLevel] ?? classSubjects[7]!;
  }

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

    // Determine subjects for the user's class level + medium
    final classLevel = profile?.classLevel ?? 7;
    final medium = profile?.medium ?? 'english';
    final subjects = getSubjects(classLevel, medium);
    final s = AppStrings.of(medium);

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
              _buildAppBar(context, profile, ref),

              // Profile info chips
              if (profile != null) _buildProfileChips(profile, s),

              // Trial banner
              if (profile != null && profile.isTrialActive)
                _buildTrialBanner(profile, s),

              // Continue Learning card
              _buildContinueLearning(s)
                  .animate()
                  .fadeIn(
                    duration: const Duration(milliseconds: 500),
                    delay: const Duration(milliseconds: 200),
                  )
                  .slideY(
                    begin: 0.03,
                    end: 0,
                    duration: const Duration(milliseconds: 500),
                    delay: const Duration(milliseconds: 200),
                    curve: Curves.easeOutCubic,
                  ),

              const SizedBox(height: 20),

              // Section title
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.screenPadding,
                ),
                child: Text(
                  s.yourSubjects,
                  style: AppTypography.headlineLarge,
                ),
              ),
              const SizedBox(height: 8),

              // Leaderboard teaser
              _buildLeaderboardTeaser(s),
              const SizedBox(height: 12),

              // Subject cards grid
              Expanded(
                child: _buildSubjectGrid(context, subjects, s),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: _buildAiChatFab(context, s),
    );
  }

  // ---------------------------------------------------------------------------
  // App Bar
  // ---------------------------------------------------------------------------

  Widget _buildAppBar(BuildContext context, UserProfile? profile, WidgetRef ref) {
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
          // XP display
          _buildXpChip(ref),
          const SizedBox(width: 6),
          // Streak display
          _buildStreakChip(ref),
          const SizedBox(width: 8),
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

  Widget _buildProfileChips(UserProfile profile, AppStrings s) {
    final boardName = _boardDisplayName(profile.board);
    final className = s.classDisplay(profile.classLevel);
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
  // Trial Banner (animated gradient border)
  // ---------------------------------------------------------------------------

  Widget _buildTrialBanner(UserProfile profile, AppStrings s) {
    final daysLeft = profile.trialDaysRemaining;
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppConstants.screenPadding, 12, AppConstants.screenPadding, 0,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [
              AppColors.teal.withValues(alpha: 0.4),
              AppColors.limeGreen.withValues(alpha: 0.4),
              AppColors.teal.withValues(alpha: 0.4),
            ],
          ),
        ),
        padding: const EdgeInsets.all(1.5),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.darkNavy,
            borderRadius: BorderRadius.circular(10.5),
          ),
          child: Row(
            children: [
              const Text('\u{1F381}', style: TextStyle(fontSize: 18)),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  s.freeTrialDaysRemaining(daysLeft),
                  style: AppTypography.labelMedium.copyWith(
                    color: AppColors.limeGreen,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ).animate(onPlay: (c) => c.repeat(reverse: true))
        .shimmer(
          duration: const Duration(milliseconds: 2000),
          color: AppColors.limeGreen.withValues(alpha: 0.15),
        ),
    );
  }

  // ---------------------------------------------------------------------------
  // Continue Learning Card
  // ---------------------------------------------------------------------------

  Widget _buildContinueLearning(AppStrings s) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppConstants.screenPadding, 12, AppConstants.screenPadding, 0,
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.teal.withValues(alpha: 0.15),
              AppColors.glassOverlay,
            ],
          ),
          borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
          border: Border.all(
            color: AppColors.cardBorder,
            width: 1,
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Play icon
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.teal.withValues(alpha: 0.20),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.play_arrow_rounded,
                color: AppColors.teal,
                size: 24,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    s.continueLearning,
                    style: AppTypography.labelMedium,
                  ),
                  Text(
                    'Coming soon...',
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: AppColors.textMuted,
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Leaderboard Teaser Card
  // ---------------------------------------------------------------------------

  Widget _buildLeaderboardTeaser(AppStrings s) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.screenPadding,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.glassOverlay,
          borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
          border: Border.all(
            color: AppColors.glassBorder,
            width: 1,
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Text(
              '\u{1F3C6}',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    s.leaderboard,
                    style: AppTypography.titleSmall,
                  ),
                  Text(
                    'Coming soon...',
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
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
    AppStrings s,
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
        final chapterCount = subject['chapters'] as int;
        return _SubjectCard(
          name: subject['name'] as String,
          icon: subject['icon'] as IconData,
          chapters: chapterCount,
          chaptersLabel: s.nChapters(chapterCount),
          progress: 0.0, // Placeholder -- no progress yet
          onTap: () {
            final name = subject['name'] as String;
            context.go('${AppConstants.chapterListRoute}/$name');
          },
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

  // ---------------------------------------------------------------------------
  // AI Chat Tutor FAB (pulsing glow + tooltip)
  // ---------------------------------------------------------------------------

  Widget _buildAiChatFab(BuildContext context, AppStrings s) {
    return Tooltip(
      message: 'Ask your AI tutor',
      preferBelow: false,
      child: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                s.aiChatTutorComingSoon,
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
          s.aiChatTutor,
          style: AppTypography.labelMedium.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ).animate(onPlay: (c) => c.repeat(reverse: true))
      .custom(
        duration: const Duration(milliseconds: 2000),
        curve: Curves.easeInOut,
        builder: (context, value, child) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppColors.teal.withValues(alpha: 0.35 * value),
                blurRadius: 20 * value,
                spreadRadius: 2 * value,
              ),
            ],
          ),
          child: child,
        ),
      );
  }

  // ---------------------------------------------------------------------------
  // Gamification Chips
  // ---------------------------------------------------------------------------

  Widget _buildXpChip(WidgetRef ref) {
    final gamification = ref.watch(gamificationProvider);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.teal.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('\u{1F48E}', style: TextStyle(fontSize: 12)),
          const SizedBox(width: 4),
          Text(
            '${gamification.totalXp}',
            style: AppTypography.labelSmall.copyWith(
              color: AppColors.tealLight,
              fontWeight: FontWeight.w600,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStreakChip(WidgetRef ref) {
    final gamification = ref.watch(gamificationProvider);
    if (gamification.currentStreak == 0) return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.warning.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('\u{1F525}', style: TextStyle(fontSize: 12))
              .animate(onPlay: (c) => c.repeat(reverse: true))
              .scaleXY(
                begin: 1.0,
                end: 1.15,
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeInOut,
              ),
          const SizedBox(width: 3),
          Text(
            '${gamification.currentStreak}',
            style: AppTypography.labelSmall.copyWith(
              color: AppColors.warning,
              fontWeight: FontWeight.w600,
              fontSize: 11,
            ),
          ),
        ],
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
/// Shows the subject icon, name, chapter count, and a circular progress ring.
class _SubjectCard extends StatelessWidget {
  const _SubjectCard({
    required this.name,
    required this.icon,
    required this.chapters,
    required this.chaptersLabel,
    required this.progress,
    required this.onTap,
  });

  final String name;
  final IconData icon;
  final int chapters;
  final String chaptersLabel;
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
            color: AppColors.glassOverlay,
            borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
            border: Border.all(
              color: AppColors.glassBorder,
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
          child: Row(
            children: [
              // Teal-to-lime left gradient border
              Container(
                width: 4,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [AppColors.teal, AppColors.limeGreen],
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(AppConstants.cardBorderRadius),
                    bottomLeft: Radius.circular(AppConstants.cardBorderRadius),
                  ),
                ),
              ),
              // Card content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 16, 16, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Icon + circular progress
                      Row(
                        children: [
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
                          const Spacer(),
                          // Circular progress ring
                          SizedBox(
                            width: 36,
                            height: 36,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                CircularProgressIndicator(
                                  value: progress,
                                  strokeWidth: 3,
                                  backgroundColor:
                                      AppColors.darkNavy.withValues(alpha: 0.5),
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                    AppColors.limeGreen,
                                  ),
                                ),
                                Text(
                                  '${(progress * 100).toInt()}%',
                                  style: AppTypography.labelSmall.copyWith(
                                    fontSize: 9,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.tealLight,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Subject name
                      Text(
                        name,
                        style: AppTypography.titleMedium.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),

                      // Chapter count
                      Text(
                        chaptersLabel,
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
