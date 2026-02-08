import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user_profile.dart';
import '../services/local_storage_service.dart';

// -----------------------------------------------------------------------------
// Service Provider
// -----------------------------------------------------------------------------

/// Provides a singleton instance of [LocalStorageService]
final localStorageProvider = Provider<LocalStorageService>(
  (ref) => LocalStorageService(),
);

// -----------------------------------------------------------------------------
// Profile State Notifier
// -----------------------------------------------------------------------------

/// Manages user profile state with persistence through [LocalStorageService]
///
/// Loads the profile from local storage on initialization and keeps the
/// in-memory state synchronized with storage on every mutation.
class UserProfileNotifier extends StateNotifier<AsyncValue<UserProfile?>> {
  UserProfileNotifier(this._storage) : super(const AsyncValue.loading()) {
    _loadProfile();
  }

  final LocalStorageService _storage;

  /// Loads the profile from local storage into state
  Future<void> _loadProfile() async {
    try {
      final profile = await _storage.loadProfile();
      state = AsyncValue.data(profile);
      debugPrint('UserProfileNotifier: Profile loaded - ${profile != null}');
    } catch (e, st) {
      debugPrint('UserProfileNotifier: Error loading profile - $e');
      state = AsyncValue.error(e, st);
    }
  }

  /// Saves a new or updated [UserProfile] to storage and updates state
  Future<void> saveProfile(UserProfile profile) async {
    try {
      await _storage.saveProfile(profile);
      state = AsyncValue.data(profile);
      debugPrint('UserProfileNotifier: Profile saved');
    } catch (e, st) {
      debugPrint('UserProfileNotifier: Error saving profile - $e');
      state = AsyncValue.error(e, st);
    }
  }

  /// Updates only the medium on the current profile
  ///
  /// Medium changes are always free regardless of trial status.
  Future<void> updateMedium(String medium) async {
    final current = state.valueOrNull;
    if (current == null) {
      debugPrint('UserProfileNotifier: Cannot update medium - no profile');
      return;
    }

    final updated = current.copyWith(medium: medium);
    await saveProfile(updated);
    debugPrint('UserProfileNotifier: Medium updated to $medium');
  }

  /// Updates only the class level on the current profile
  ///
  /// Class changes are free during the trial period. After the trial expires,
  /// this may require credits (enforced at the UI/business logic layer).
  Future<void> updateClass(int classLevel) async {
    final current = state.valueOrNull;
    if (current == null) {
      debugPrint('UserProfileNotifier: Cannot update class - no profile');
      return;
    }

    final updated = current.copyWith(classLevel: classLevel);
    await saveProfile(updated);
    debugPrint('UserProfileNotifier: Class updated to $classLevel');
  }

  /// Clears the stored profile and resets state (for sign-out)
  Future<void> clearProfile() async {
    try {
      await _storage.clearProfile();
      state = const AsyncValue.data(null);
      debugPrint('UserProfileNotifier: Profile cleared');
    } catch (e, st) {
      debugPrint('UserProfileNotifier: Error clearing profile - $e');
      state = AsyncValue.error(e, st);
    }
  }
}

/// Provides the user profile state with automatic loading from local storage
final userProfileProvider =
    StateNotifierProvider<UserProfileNotifier, AsyncValue<UserProfile?>>(
  (ref) {
    final storage = ref.read(localStorageProvider);
    return UserProfileNotifier(storage);
  },
);

// -----------------------------------------------------------------------------
// Derived Providers
// -----------------------------------------------------------------------------

/// Whether the user has completed onboarding and has a saved profile
final isOnboardedProvider = Provider<bool>((ref) {
  final profile = ref.watch(userProfileProvider);
  return profile.valueOrNull != null;
});

/// Whether the user's free trial period is still active
final isTrialActiveProvider = Provider<bool>((ref) {
  final profile = ref.watch(userProfileProvider);
  return profile.valueOrNull?.isTrialActive ?? false;
});

/// Number of trial days remaining (0 if expired or no profile)
final trialDaysRemainingProvider = Provider<int>((ref) {
  final profile = ref.watch(userProfileProvider);
  return profile.valueOrNull?.trialDaysRemaining ?? 0;
});
