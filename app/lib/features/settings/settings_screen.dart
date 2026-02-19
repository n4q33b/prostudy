import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_constants.dart';
import '../../core/l10n/app_strings.dart';
import '../../core/models/user_profile.dart';
import '../../core/providers/gamification_provider.dart';
import '../../core/providers/user_profile_provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

/// Settings screen for ProStudy
///
/// Allows users to view and change their class level and language medium,
/// view trial status, and sign out. Follows the dark premium aesthetic
/// consistent with the rest of the application.
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  /// Resolves a board identifier to its human-readable display name.
  String _boardDisplayName(String boardId) {
    for (final board in AppConstants.boards) {
      if (board['id'] == boardId) {
        return board['name'] as String;
      }
    }
    return boardId;
  }

  /// Returns the monthly price string for a given class level.
  String _classPriceLabel(int classLevel) {
    final price = AppConstants.classPricing[classLevel.toString()];
    if (price == null) return '';
    return '\u20B9$price/mo';
  }

  // ---------------------------------------------------------------------------
  // SnackBar helpers
  // ---------------------------------------------------------------------------

  void _showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle_outline, color: AppColors.white),
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
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _showInfoSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.info_outline, color: AppColors.white),
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
        backgroundColor: AppColors.teal,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(userProfileProvider);

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
              // -- AppBar --
              _buildAppBar(context, profileAsync.valueOrNull),

              // -- Body --
              Expanded(
                child: profileAsync.when(
                  loading: () => const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.teal,
                    ),
                  ),
                  error: (error, _) {
                    final s = AppStrings.of(null);
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(
                          AppConstants.screenPadding,
                        ),
                        child: Text(
                          '${s.unableToLoadProfile}\n$error',
                          style: AppTypography.bodyMedium.copyWith(
                            color: AppColors.textSecondary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  },
                  data: (profile) {
                    if (profile == null) {
                      final s = AppStrings.of(null);
                      return Center(
                        child: Text(
                          s.noProfileFound,
                          style: AppTypography.bodyMedium.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      );
                    }
                    return _buildBody(context, ref, profile);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // AppBar
  // ---------------------------------------------------------------------------

  Widget _buildAppBar(BuildContext context, UserProfile? profile) {
    final s = AppStrings.of(profile?.medium);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 8,
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => context.go(AppConstants.homeRoute),
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColors.white,
              size: 22,
            ),
            splashRadius: 24,
          ),
          const SizedBox(width: 4),
          Text(
            s.settings,
            style: AppTypography.headlineMedium,
          ),
          const Spacer(),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Body
  // ---------------------------------------------------------------------------

  Widget _buildBody(
    BuildContext context,
    WidgetRef ref,
    UserProfile profile,
  ) {
    final s = AppStrings.of(profile.medium);
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.screenPadding,
      ),
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),

          // Section 1 -- Profile Info
          _buildProfileInfoCard(profile, s, ref),
          const SizedBox(height: 24),

          // Section 2 -- Change Medium
          _buildChangeMediumSection(context, ref, profile, s),
          const SizedBox(height: 24),

          // Section 3 -- Change Class
          _buildChangeClassSection(context, ref, profile, s),
          const SizedBox(height: 24),

          // Section 4 -- Trial Status
          _buildTrialStatusCard(context, profile, s),
          const SizedBox(height: 24),

          // Section 5 -- Account
          _buildAccountSection(context, ref, s),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Section 1 -- Profile Info
  // ---------------------------------------------------------------------------

  Widget _buildProfileInfoCard(UserProfile profile, AppStrings s, WidgetRef ref) {
    return _SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.teal.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.person_outline_rounded,
                  color: AppColors.teal,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                s.yourProfile,
                style: AppTypography.titleLarge,
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Board (read-only)
          _ProfileRow(
            label: s.board,
            value: _boardDisplayName(profile.board),
          ),
          const _ThinDivider(),

          // Class
          _ProfileRow(
            label: s.classLabel,
            value: s.classDisplay(profile.classLevel),
            trailing: const Icon(
              Icons.edit_outlined,
              color: AppColors.tealLight,
              size: 18,
            ),
          ),
          const _ThinDivider(),

          // Medium
          _ProfileRow(
            label: s.mediumLabel,
            value: profile.medium,
            trailing: const Icon(
              Icons.edit_outlined,
              color: AppColors.tealLight,
              size: 18,
            ),
          ),
          const _ThinDivider(),

          // Level
          _ProfileRow(
            label: s.level,
            value: ref.watch(gamificationProvider).levelName,
            trailing: Text(
              ref.watch(gamificationProvider).levelEmoji,
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Section 2 -- Change Medium
  // ---------------------------------------------------------------------------

  Widget _buildChangeMediumSection(
    BuildContext context,
    WidgetRef ref,
    UserProfile profile,
    AppStrings s,
  ) {
    final mediums =
        AppConstants.boardMediums[profile.board] ?? const <String>[];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          s.changeMedium,
          style: AppTypography.headlineSmall,
        ),
        const SizedBox(height: 4),
        Text(
          s.changeMediumFreeSubtitle,
          style: AppTypography.bodySmall.copyWith(
            color: AppColors.textMuted,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: mediums.map((medium) {
            final isSelected =
                medium.toLowerCase() == profile.medium.toLowerCase();
            return _MediumChip(
              label: medium,
              isSelected: isSelected,
              onTap: () {
                if (!isSelected) {
                  ref
                      .read(userProfileProvider.notifier)
                      .updateMedium(medium);
                  _showSuccessSnackBar(
                    context,
                    s.mediumUpdatedTo(medium),
                  );
                }
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Section 3 -- Change Class
  // ---------------------------------------------------------------------------

  Widget _buildChangeClassSection(
    BuildContext context,
    WidgetRef ref,
    UserProfile profile,
    AppStrings s,
  ) {
    final isTrialActive = profile.isTrialActive;
    final daysRemaining = profile.trialDaysRemaining;

    String subtitle;
    if (isTrialActive) {
      subtitle = s.freeDuringTrial(daysRemaining);
    } else {
      subtitle = s.classChangePricingApplies;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          s.changeClass,
          style: AppTypography.headlineSmall,
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: AppTypography.bodySmall.copyWith(
            color: isTrialActive ? AppColors.limeGreen : AppColors.textMuted,
          ),
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.15,
          ),
          itemCount: AppConstants.availableClasses.length,
          itemBuilder: (context, index) {
            final classLevel = AppConstants.availableClasses[index];
            final isSelected = classLevel == profile.classLevel;
            final priceLabel = _classPriceLabel(classLevel);

            return _ClassButton(
              classLevel: classLevel,
              priceLabel: priceLabel,
              isSelected: isSelected,
              classLabel: s.classLabel,
              onTap: () {
                if (isSelected) return;

                if (isTrialActive) {
                  ref
                      .read(userProfileProvider.notifier)
                      .updateClass(classLevel);
                  _showSuccessSnackBar(
                    context,
                    s.classUpdatedTo(classLevel),
                  );
                } else {
                  _showClassChangeBottomSheet(
                    context,
                    ref,
                    classLevel,
                    priceLabel,
                    s,
                  );
                }
              },
            );
          },
        ),
      ],
    );
  }

  void _showClassChangeBottomSheet(
    BuildContext context,
    WidgetRef ref,
    int classLevel,
    String priceLabel,
    AppStrings s,
  ) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (sheetContext) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.darkNavy,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(24),
            ),
            border: Border(
              top: BorderSide(
                color: AppColors.darkNavyLight,
                width: 1,
              ),
              left: BorderSide(
                color: AppColors.darkNavyLight,
                width: 1,
              ),
              right: BorderSide(
                color: AppColors.darkNavyLight,
                width: 1,
              ),
            ),
          ),
          padding: EdgeInsets.fromLTRB(
            AppConstants.screenPadding,
            24,
            AppConstants.screenPadding,
            MediaQuery.of(sheetContext).padding.bottom + 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle indicator
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.textMuted.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 24),

              // Icon
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.teal.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.school_outlined,
                  color: AppColors.teal,
                  size: 28,
                ),
              ),
              const SizedBox(height: 20),

              // Title
              Text(
                s.changeToClass(classLevel),
                style: AppTypography.headlineMedium,
              ),
              const SizedBox(height: 8),

              // Price
              Text(
                s.monthlyPrice(priceLabel),
                style: AppTypography.bodyLarge.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 28),

              // Confirm button
              SizedBox(
                width: double.infinity,
                height: AppConstants.buttonHeight,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(sheetContext).pop();
                    ref
                        .read(userProfileProvider.notifier)
                        .updateClass(classLevel);
                    _showSuccessSnackBar(
                      context,
                      s.classUpdatedTo(classLevel),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.limeGreen,
                    foregroundColor: AppColors.darkNavy,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        AppConstants.buttonBorderRadius,
                      ),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    s.confirm,
                    style: AppTypography.button.copyWith(
                      color: AppColors.darkNavy,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Cancel button
              SizedBox(
                width: double.infinity,
                height: AppConstants.buttonHeight,
                child: OutlinedButton(
                  onPressed: () => Navigator.of(sheetContext).pop(),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.textSecondary,
                    side: BorderSide(
                      color: AppColors.textMuted.withValues(alpha: 0.3),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        AppConstants.buttonBorderRadius,
                      ),
                    ),
                  ),
                  child: Text(
                    s.cancel,
                    style: AppTypography.button.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Section 4 -- Trial Status
  // ---------------------------------------------------------------------------

  Widget _buildTrialStatusCard(BuildContext context, UserProfile profile, AppStrings s) {
    final isActive = profile.isTrialActive;
    final daysRemaining = profile.trialDaysRemaining;
    final daysUsed = AppConstants.trialDays - daysRemaining;
    final progress = daysUsed / AppConstants.trialDays;

    return _SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: isActive
                      ? AppColors.limeGreen.withValues(alpha: 0.15)
                      : AppColors.textMuted.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.card_giftcard_rounded,
                  color: isActive ? AppColors.limeGreen : AppColors.textMuted,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      s.freeTrial,
                      style: AppTypography.titleMedium,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      isActive
                          ? s.daysRemainingText(daysRemaining)
                          : s.trialEnded,
                      style: AppTypography.bodySmall.copyWith(
                        color: isActive
                            ? AppColors.limeGreen
                            : AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
              if (isActive)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.limeGreen.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    s.active,
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.limeGreen,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 20),

          // Progress bar (trial active)
          if (isActive) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progress.clamp(0.0, 1.0),
                minHeight: 6,
                backgroundColor: AppColors.textMuted.withValues(alpha: 0.15),
                valueColor: const AlwaysStoppedAnimation<Color>(
                  AppColors.limeGreen,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  s.daysUsedText(daysUsed),
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.textMuted,
                  ),
                ),
                Text(
                  s.daysTotalText(AppConstants.trialDays),
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ],

          // Subscribe button (trial expired)
          if (!isActive) ...[
            const SizedBox(height: 4),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  _showInfoSnackBar(context, s.comingSoon);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.limeGreen,
                  foregroundColor: AppColors.darkNavy,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      AppConstants.buttonBorderRadius,
                    ),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  s.subscribe,
                  style: AppTypography.button.copyWith(
                    color: AppColors.darkNavy,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Section 5 -- Account
  // ---------------------------------------------------------------------------

  Widget _buildAccountSection(
    BuildContext context,
    WidgetRef ref,
    AppStrings s,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          s.account,
          style: AppTypography.headlineSmall,
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          height: AppConstants.buttonHeight,
          child: OutlinedButton.icon(
            onPressed: () {
              _showSignOutDialog(context, ref, s);
            },
            icon: Icon(
              Icons.logout_rounded,
              size: 20,
              color: AppColors.textMuted.withValues(alpha: 0.8),
            ),
            label: Text(
              s.signOut,
              style: AppTypography.button.copyWith(
                color: AppColors.textMuted.withValues(alpha: 0.8),
              ),
            ),
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                color: AppColors.textMuted.withValues(alpha: 0.25),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  AppConstants.buttonBorderRadius,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showSignOutDialog(BuildContext context, WidgetRef ref, AppStrings s) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.darkNavy,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppConstants.cardBorderRadius,
            ),
            side: BorderSide(
              color: AppColors.darkNavyLight.withValues(alpha: 0.6),
            ),
          ),
          title: Text(
            s.signOut,
            style: AppTypography.headlineMedium,
          ),
          content: Text(
            s.signOutConfirmBody,
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(
                s.cancel,
                style: AppTypography.labelMedium.copyWith(
                  color: AppColors.textMuted,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                ref.read(userProfileProvider.notifier).clearProfile();
                context.go(AppConstants.splashRoute);
              },
              child: Text(
                s.signOut,
                style: AppTypography.labelMedium.copyWith(
                  color: AppColors.error,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

// =============================================================================
// Private reusable widgets
// =============================================================================

/// Dark-themed card with subtle border used for each settings section.
class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.darkNavyLight.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
        border: Border.all(
          color: AppColors.textMuted.withValues(alpha: 0.12),
        ),
      ),
      child: child,
    );
  }
}

/// A single row inside the Profile Info card.
class _ProfileRow extends StatelessWidget {
  const _ProfileRow({
    required this.label,
    required this.value,
    this.trailing,
  });

  final String label;
  final String value;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          SizedBox(
            width: 72,
            child: Text(
              label,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textMuted,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: AppTypography.bodyMedium,
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}

/// Thin horizontal divider matching the dark theme.
class _ThinDivider extends StatelessWidget {
  const _ThinDivider();

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 0.5,
      color: AppColors.textMuted.withValues(alpha: 0.15),
    );
  }
}

/// Selectable medium chip used in the Change Medium section.
class _MediumChip extends StatelessWidget {
  const _MediumChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(
          milliseconds: AppConstants.defaultAnimationDuration,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.teal.withValues(alpha: 0.2)
              : AppColors.darkNavyLight.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(AppConstants.buttonBorderRadius),
          border: Border.all(
            color: isSelected
                ? AppColors.teal
                : AppColors.textMuted.withValues(alpha: 0.15),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Text(
          label,
          style: AppTypography.labelMedium.copyWith(
            color: isSelected ? AppColors.teal : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}

/// Selectable class level button shown in the Change Class grid.
class _ClassButton extends StatelessWidget {
  const _ClassButton({
    required this.classLevel,
    required this.priceLabel,
    required this.isSelected,
    required this.classLabel,
    required this.onTap,
  });

  final int classLevel;
  final String priceLabel;
  final bool isSelected;
  final String classLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(
          milliseconds: AppConstants.defaultAnimationDuration,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.teal.withValues(alpha: 0.2)
              : AppColors.darkNavyLight.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
          border: Border.all(
            color: isSelected
                ? AppColors.teal
                : AppColors.textMuted.withValues(alpha: 0.12),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              classLabel,
              style: AppTypography.labelSmall.copyWith(
                color: isSelected ? AppColors.tealLight : AppColors.textMuted,
                fontSize: 11,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              '$classLevel',
              style: AppTypography.headlineLarge.copyWith(
                color: isSelected ? AppColors.teal : AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              priceLabel,
              style: AppTypography.labelSmall.copyWith(
                color: isSelected
                    ? AppColors.limeGreen
                    : AppColors.textMuted,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
