import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_profile.dart';

/// Local storage service using SharedPreferences
///
/// Handles persistence of [UserProfile] data as JSON strings.
/// Used as the single source of truth for user profile storage on device.
class LocalStorageService {
  static const String _profileKey = 'user_profile';

  /// Saves the [UserProfile] to local storage as a JSON string
  Future<void> saveProfile(UserProfile profile) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = jsonEncode(profile.toJson());
      await prefs.setString(_profileKey, jsonString);
      debugPrint('LocalStorage: Profile saved successfully');
    } catch (e) {
      debugPrint('LocalStorage: Error saving profile - $e');
      rethrow;
    }
  }

  /// Loads the [UserProfile] from local storage
  ///
  /// Returns `null` if no profile is stored or if deserialization fails.
  Future<UserProfile?> loadProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_profileKey);

      if (jsonString == null) {
        debugPrint('LocalStorage: No profile found');
        return null;
      }

      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      final profile = UserProfile.fromJson(json);
      debugPrint('LocalStorage: Profile loaded successfully');
      return profile;
    } catch (e) {
      debugPrint('LocalStorage: Error loading profile - $e');
      return null;
    }
  }

  /// Removes the stored profile from local storage
  Future<void> clearProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_profileKey);
      debugPrint('LocalStorage: Profile cleared');
    } catch (e) {
      debugPrint('LocalStorage: Error clearing profile - $e');
      rethrow;
    }
  }

  /// Returns `true` if a profile exists in local storage
  Future<bool> hasProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.containsKey(_profileKey);
    } catch (e) {
      debugPrint('LocalStorage: Error checking profile existence - $e');
      return false;
    }
  }
}
