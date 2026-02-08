import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_constants.dart';
import '../../core/models/user_profile.dart';
import '../../core/providers/user_profile_provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../core/theme/app_typography.dart';

// ---------------------------------------------------------------------------
// Data model for board selection cards
// ---------------------------------------------------------------------------

/// Represents a selectable education board in the onboarding wizard.
class _BoardOption {
  const _BoardOption({
    required this.id,
    required this.name,
    required this.icon,
    required this.isAvailable,
  });

  final String id;
  final String name;
  final IconData icon;
  final bool isAvailable;
}

// ---------------------------------------------------------------------------
// OnboardingScreen
// ---------------------------------------------------------------------------

/// Premium two-step onboarding wizard for ProStudy.
///
/// Guides new users through two sequential steps:
///   1. **Board & Medium selection** -- pick a board, then choose language medium
///      on the same page via a dropdown that animates in smoothly.
///   2. **Class selection** -- classes 5-10 in a 2-column grid, then "Get Started".
///
/// The screen uses a [PageView] with disabled swipe gestures so navigation is
/// controlled programmatically, ensuring the user completes each step in order.
///
/// Design decisions:
/// - Dark navy gradient background consistent with splash and login screens.
/// - Stagger entrance animations via `flutter_animate` matching the premium
///   feel established by the login screen.
/// - Teal (#2D9596) used for active selections; lime green (#4ADE80) for the
///   final call-to-action button.
/// - Haptic feedback on every selection for a tactile, polished feel.
/// - Medium dropdown animates in with [AnimatedSize] + [AnimatedOpacity] when
///   a board is selected, creating a smooth reveal transition.
///
/// On completion, persists a [UserProfile] through [userProfileProvider] and
/// navigates to the home route.
class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen>
    with TickerProviderStateMixin {
  // -------------------------------------------------------------------------
  // Controllers & State
  // -------------------------------------------------------------------------

  final PageController _pageController = PageController();
  int _currentStep = 0;

  String? _selectedBoard;
  int? _selectedClass;
  String? _selectedMedium;

  /// Tracks whether entrance animations for each step have already played,
  /// preventing re-triggers when navigating back.
  final List<bool> _stepAnimated = [false, false];

  // Per-step animation controllers for staggered entrance effects
  late final AnimationController _step0Controller;
  late final AnimationController _step1Controller;

  // Animation controller for the medium dropdown reveal
  late final AnimationController _mediumRevealController;
  late final Animation<double> _mediumRevealOpacity;

  // -------------------------------------------------------------------------
  // Board definitions
  // -------------------------------------------------------------------------

  static const List<_BoardOption> _boards = [
    _BoardOption(
      id: AppConstants.boardMaharashtra,
      name: 'Maharashtra State Board',
      icon: Icons.account_balance_rounded,
      isAvailable: true,
    ),
    _BoardOption(
      id: AppConstants.boardCbse,
      name: 'CBSE',
      icon: Icons.school_rounded,
      isAvailable: false,
    ),
    _BoardOption(
      id: AppConstants.boardNcert,
      name: 'NCERT',
      icon: Icons.menu_book_rounded,
      isAvailable: false,
    ),
  ];

  // -------------------------------------------------------------------------
  // Lifecycle
  // -------------------------------------------------------------------------

  @override
  void initState() {
    super.initState();
    _setupSystemUI();

    _step0Controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _step1Controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _mediumRevealController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _mediumRevealOpacity = CurvedAnimation(
      parent: _mediumRevealController,
      curve: Curves.easeOut,
    );

    // Kick off step 0 entrance after the first frame renders
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _step0Controller.forward();
      _stepAnimated[0] = true;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _step0Controller.dispose();
    _step1Controller.dispose();
    _mediumRevealController.dispose();
    super.dispose();
  }

  void _setupSystemUI() {
    SystemChrome.setSystemUIOverlayStyle(AppTheme.darkOverlayStyle);
  }

  // -------------------------------------------------------------------------
  // Navigation helpers
  // -------------------------------------------------------------------------

  void _goToStep(int step) {
    setState(() => _currentStep = step);
    _pageController.animateToPage(
      step,
      duration: const Duration(
        milliseconds: AppConstants.pageTransitionDuration,
      ),
      curve: Curves.easeInOutCubic,
    );

    // Fire entrance animation for the target step if it hasn't played yet
    if (!_stepAnimated[step]) {
      _stepAnimated[step] = true;
      if (step == 1) {
        _step1Controller.forward();
      }
    }
  }

  void _goBack() {
    if (_currentStep > 0) {
      _goToStep(_currentStep - 1);
    }
  }

  // -------------------------------------------------------------------------
  // Selection handlers
  // -------------------------------------------------------------------------

  void _onBoardSelected(String boardId) {
    if (_selectedBoard == boardId) return;

    HapticFeedback.lightImpact();
    setState(() {
      _selectedBoard = boardId;
      // Reset medium when board changes
      _selectedMedium = null;
    });

    // Animate in the medium dropdown
    _mediumRevealController.forward(from: 0.0);
  }

  void _onClassSelected(int classLevel) {
    HapticFeedback.lightImpact();
    setState(() => _selectedClass = classLevel);
  }

  void _onMediumChanged(String? medium) {
    if (medium == null) return;
    HapticFeedback.lightImpact();
    setState(() => _selectedMedium = medium);
  }

  // -------------------------------------------------------------------------
  // Complete onboarding
  // -------------------------------------------------------------------------

  void _onComplete() {
    if (_selectedBoard == null ||
        _selectedClass == null ||
        _selectedMedium == null) {
      return;
    }

    final profile = UserProfile(
      board: _selectedBoard!,
      classLevel: _selectedClass!,
      medium: _selectedMedium!.toLowerCase(),
      trialStartDate: DateTime.now(),
      createdAt: DateTime.now(),
    );

    ref.read(userProfileProvider.notifier).saveProfile(profile);
    context.go('/home');
  }

  // =========================================================================
  // BUILD
  // =========================================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildTopBar(),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (index) =>
                      setState(() => _currentStep = index),
                  children: [
                    _buildBoardAndMediumStep(),
                    _buildClassStep(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =========================================================================
  // TOP BAR  (back button | step dots | logo)
  // =========================================================================

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.screenPadding,
        vertical: 16,
      ),
      child: Row(
        children: [
          // Back button -- invisible on step 0 to keep layout balanced
          AnimatedOpacity(
            opacity: _currentStep > 0 ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 200),
            child: IgnorePointer(
              ignoring: _currentStep == 0,
              child: GestureDetector(
                onTap: _goBack,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.darkNavyLight.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.arrow_back_rounded,
                    color: AppColors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),

          const Spacer(),

          // Step indicator dots (2 steps)
          _buildStepDots(),

          const Spacer(),

          // ProStudy logo (right side)
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: AppColors.teal.withValues(alpha: 0.15),
                  blurRadius: 12,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                AppConstants.logoPath,
                width: AppConstants.logoSizeOnboarding,
                height: AppConstants.logoSizeOnboarding,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepDots() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(2, (index) {
        final isActive = index == _currentStep;
        final isCompleted = index < _currentStep;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 28 : 10,
          height: 10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: isActive
                ? AppColors.teal
                : isCompleted
                    ? AppColors.teal.withValues(alpha: 0.5)
                    : AppColors.darkNavyLight,
          ),
        );
      }),
    );
  }

  // =========================================================================
  // STEP 1  --  BOARD & MEDIUM SELECTION (combined)
  // =========================================================================

  Widget _buildBoardAndMediumStep() {
    final bool showMediumSection = _selectedBoard != null;
    final bool canContinue =
        _selectedBoard != null && _selectedMedium != null;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.screenPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),

          // Title
          Text('Choose Your Board', style: AppTypography.headlineLarge)
              .animate(controller: _step0Controller)
              .fadeIn(duration: 500.ms, curve: Curves.easeOut)
              .slideY(
                begin: 0.2,
                end: 0,
                duration: 500.ms,
                curve: Curves.easeOutCubic,
              ),

          const SizedBox(height: 8),

          // Subtitle
          Text(
            'Select your education board to get started',
            style: AppTypography.subtitle,
          )
              .animate(controller: _step0Controller)
              .fadeIn(
                delay: 100.ms,
                duration: 500.ms,
                curve: Curves.easeOut,
              )
              .slideY(
                begin: 0.2,
                end: 0,
                delay: 100.ms,
                duration: 500.ms,
                curve: Curves.easeOutCubic,
              ),

          const SizedBox(height: 36),

          // Maharashtra board card
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _buildBoardCard(_boards[0])
                .animate(controller: _step0Controller)
                .fadeIn(
                  delay: 200.ms,
                  duration: 500.ms,
                  curve: Curves.easeOut,
                )
                .slideX(
                  begin: 0.15,
                  end: 0,
                  delay: 200.ms,
                  duration: 500.ms,
                  curve: Curves.easeOutCubic,
                ),
          ),

          // Medium dropdown — slides in directly under Maharashtra card
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            alignment: Alignment.topCenter,
            child: showMediumSection
                ? FadeTransition(
                    opacity: _mediumRevealOpacity,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _buildMediumDropdownSection(),
                    ),
                  )
                : const SizedBox(width: double.infinity, height: 0),
          ),

          // CBSE card
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _buildBoardCard(_boards[1])
                .animate(controller: _step0Controller)
                .fadeIn(
                  delay: 320.ms,
                  duration: 500.ms,
                  curve: Curves.easeOut,
                )
                .slideX(
                  begin: 0.15,
                  end: 0,
                  delay: 320.ms,
                  duration: 500.ms,
                  curve: Curves.easeOutCubic,
                ),
          ),

          // NCERT card
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _buildBoardCard(_boards[2])
                .animate(controller: _step0Controller)
                .fadeIn(
                  delay: 440.ms,
                  duration: 500.ms,
                  curve: Curves.easeOut,
                )
                .slideX(
                  begin: 0.15,
                  end: 0,
                  delay: 440.ms,
                  duration: 500.ms,
                  curve: Curves.easeOutCubic,
                ),
          ),

          // Continue button
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            alignment: Alignment.topCenter,
            child: canContinue
                ? FadeTransition(
                    opacity: _mediumRevealOpacity,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: _buildActionButton(
                        label: 'Continue',
                        isEnabled: canContinue,
                        onTap: () => _goToStep(1),
                      ),
                    ),
                  )
                : const SizedBox(width: double.infinity, height: 0),
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildMediumDropdownSection() {
    final mediums = _selectedBoard != null
        ? (AppConstants.boardMediums[_selectedBoard!] ?? <String>[])
        : <String>[];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),

        // Section title
        Text(
          'Select Medium',
          style: AppTypography.headlineMedium,
        ),

        const SizedBox(height: 16),

        // Themed dropdown -- keyed by board to force rebuild on board change
        DropdownButtonFormField<String>(
          key: ValueKey<String>('medium_dropdown_$_selectedBoard'),
          initialValue: _selectedMedium,
          decoration: InputDecoration(
            labelText: 'Select Medium',
            labelStyle: const TextStyle(color: AppColors.textSecondary),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppColors.teal.withValues(alpha: 0.3),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.teal,
                width: 2,
              ),
            ),
            filled: true,
            fillColor: AppColors.darkNavyLight,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
          dropdownColor: AppColors.darkNavyLight,
          style: const TextStyle(color: AppColors.textPrimary),
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppColors.teal,
          ),
          isExpanded: true,
          items: mediums.map((medium) {
            return DropdownMenuItem<String>(
              value: medium,
              child: Text(
                medium,
                style: AppTypography.titleMedium.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            );
          }).toList(),
          onChanged: _onMediumChanged,
        ),
      ],
    );
  }

  Widget _buildBoardCard(_BoardOption board) {
    final isSelected = _selectedBoard == board.id;
    final isAvailable = board.isAvailable;

    return GestureDetector(
      onTap: isAvailable ? () => _onBoardSelected(board.id) : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          color: isAvailable
              ? AppColors.darkNavyLight.withValues(alpha: 0.6)
              : AppColors.darkNavyLight.withValues(alpha: 0.25),
          borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
          border: Border.all(
            color: isSelected
                ? AppColors.teal
                : isAvailable
                    ? AppColors.teal.withValues(alpha: 0.15)
                    : Colors.transparent,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.teal.withValues(alpha: 0.3),
                    blurRadius: 24,
                    spreadRadius: 1,
                  ),
                ]
              : AppColors.subtleShadow,
        ),
        child: Stack(
          children: [
            Row(
              children: [
                // Icon container
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    gradient: isSelected ? AppColors.brandGradient : null,
                    color: isSelected
                        ? null
                        : isAvailable
                            ? AppColors.teal.withValues(alpha: 0.15)
                            : AppColors.darkNavyLight.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    board.icon,
                    color: isAvailable
                        ? (isSelected ? AppColors.white : AppColors.teal)
                        : AppColors.textMuted.withValues(alpha: 0.5),
                    size: 26,
                  ),
                ),

                const SizedBox(width: 16),

                // Board name + selection label
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        board.name,
                        style: AppTypography.titleMedium.copyWith(
                          color: isAvailable
                              ? AppColors.textPrimary
                              : AppColors.textMuted.withValues(alpha: 0.6),
                        ),
                      ),
                      if (isSelected) ...[
                        const SizedBox(height: 4),
                        Text(
                          'Selected',
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.teal,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                // Checkmark for selected board
                if (isSelected)
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: AppColors.teal,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.check_rounded,
                      color: AppColors.white,
                      size: 18,
                    ),
                  ),
              ],
            ),

            // "Coming Soon" badge overlay for unavailable boards
            if (!isAvailable)
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.warning.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppColors.warning.withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    'Coming Soon',
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.warning,
                      fontWeight: FontWeight.w600,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // =========================================================================
  // STEP 2  --  CLASS SELECTION
  // =========================================================================

  Widget _buildClassStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.screenPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),

          // Title
          Text('Select Your Class', style: AppTypography.headlineLarge)
              .animate(controller: _step1Controller)
              .fadeIn(duration: 500.ms, curve: Curves.easeOut)
              .slideY(
                begin: 0.2,
                end: 0,
                duration: 500.ms,
                curve: Curves.easeOutCubic,
              ),

          const SizedBox(height: 8),

          // Subtitle
          Text(
            'You can change this later from settings',
            style: AppTypography.subtitle,
          )
              .animate(controller: _step1Controller)
              .fadeIn(
                delay: 100.ms,
                duration: 500.ms,
                curve: Curves.easeOut,
              )
              .slideY(
                begin: 0.2,
                end: 0,
                delay: 100.ms,
                duration: 500.ms,
                curve: Curves.easeOutCubic,
              ),

          const SizedBox(height: 32),

          // Class grid  (2 columns, classes 5-10)
          _buildClassGrid(),

          const SizedBox(height: 40),

          // "Get Started" button
          _buildActionButton(
            label: 'Get Started',
            isEnabled: _selectedClass != null,
            onTap: _onComplete,
            useAccentGradient: true,
          )
              .animate(controller: _step1Controller)
              .fadeIn(delay: 600.ms, duration: 400.ms)
              .slideY(
                begin: 0.15,
                end: 0,
                delay: 600.ms,
                duration: 400.ms,
                curve: Curves.easeOutCubic,
              ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildClassGrid() {
    final classes = AppConstants.availableClasses;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.6,
      ),
      itemCount: classes.length,
      itemBuilder: (context, index) {
        return _buildClassCard(classes[index], index);
      },
    );
  }

  Widget _buildClassCard(int classLevel, int index) {
    final isSelected = _selectedClass == classLevel;

    return GestureDetector(
      onTap: () => _onClassSelected(classLevel),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.teal.withValues(alpha: 0.12)
              : AppColors.darkNavyLight.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
          border: Border.all(
            color: isSelected
                ? AppColors.teal
                : AppColors.teal.withValues(alpha: 0.1),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.teal.withValues(alpha: 0.2),
                    blurRadius: 16,
                  ),
                ]
              : [],
        ),
        child: Stack(
          children: [
            // Class number + label
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$classLevel',
                    style: AppTypography.displaySmall.copyWith(
                      color: isSelected
                          ? AppColors.teal
                          : AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Class',
                    style: AppTypography.bodySmall.copyWith(
                      color: isSelected
                          ? AppColors.tealLight
                          : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),

            // Lime green checkmark badge
            if (isSelected)
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: AppColors.limeGreen,
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: const Icon(
                    Icons.check_rounded,
                    color: AppColors.darkNavy,
                    size: 16,
                  ),
                ),
              ),
          ],
        ),
      ),
    )
        .animate(controller: _step1Controller)
        .fadeIn(
          delay: Duration(milliseconds: 200 + index * 80),
          duration: 400.ms,
          curve: Curves.easeOut,
        )
        .scale(
          begin: const Offset(0.85, 0.85),
          end: const Offset(1, 1),
          delay: Duration(milliseconds: 200 + index * 80),
          duration: 400.ms,
          curve: Curves.easeOutBack,
        );
  }

  // =========================================================================
  // SHARED WIDGETS
  // =========================================================================

  /// Primary action button used at the bottom of each step.
  ///
  /// When [useAccentGradient] is true the button uses the brand gradient
  /// (teal -> lime green) with dark text -- used for the final "Get Started"
  /// call-to-action.  Otherwise it uses a teal gradient with white text.
  Widget _buildActionButton({
    required String label,
    required bool isEnabled,
    required VoidCallback onTap,
    bool useAccentGradient = false,
  }) {
    return GestureDetector(
      onTap: isEnabled ? onTap : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        width: double.infinity,
        height: AppConstants.buttonHeight,
        decoration: BoxDecoration(
          gradient: isEnabled
              ? (useAccentGradient
                  ? AppColors.brandGradient
                  : const LinearGradient(
                      colors: [AppColors.teal, AppColors.tealLight],
                    ))
              : null,
          color: isEnabled
              ? null
              : AppColors.darkNavyLight.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(
            AppConstants.buttonBorderRadius,
          ),
          boxShadow: isEnabled
              ? [
                  BoxShadow(
                    color: (useAccentGradient
                            ? AppColors.limeGreen
                            : AppColors.teal)
                        .withValues(alpha: 0.3),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ]
              : [],
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: AppTypography.button.copyWith(
                  color: isEnabled
                      ? (useAccentGradient
                          ? AppColors.darkNavy
                          : AppColors.white)
                      : AppColors.textMuted.withValues(alpha: 0.5),
                ),
              ),
              if (isEnabled) ...[
                const SizedBox(width: 8),
                Icon(
                  Icons.arrow_forward_rounded,
                  color: useAccentGradient
                      ? AppColors.darkNavy
                      : AppColors.white,
                  size: 20,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
