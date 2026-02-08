import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

/// Authentication result type using Dart 3 records
typedef AuthResult = ({bool success, String? error, User? user});

/// Firebase Auth instance provider
final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

/// Auth state stream provider
final authStateProvider = StreamProvider<User?>((ref) {
  return ref.watch(firebaseAuthProvider).authStateChanges();
});

/// Current user provider
final currentUserProvider = Provider<User?>((ref) {
  return ref.watch(authStateProvider).valueOrNull;
});

/// Auth service provider
final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService(ref.watch(firebaseAuthProvider));
});

/// Authentication service handling Google and Apple Sign-In
///
/// Provides secure authentication methods with proper error handling
/// and state management integration.
class AuthService {
  AuthService(this._auth);

  final FirebaseAuth _auth;

  // Google Sign-In instance
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
  );

  /// Stream of auth state changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  /// Current user getter
  User? get currentUser => _auth.currentUser;

  /// Check if user is signed in
  bool get isSignedIn => _auth.currentUser != null;

  /// Sign in with Google
  ///
  /// Returns an [AuthResult] record with success status, optional error message,
  /// and the authenticated user if successful.
  Future<AuthResult> signInWithGoogle() async {
    try {
      // Trigger the Google Sign-In flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      // User cancelled the sign-in
      if (googleUser == null) {
        return (success: false, error: 'Sign in cancelled', user: null);
      }

      // Obtain auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create Firebase credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase
      final userCredential = await _auth.signInWithCredential(credential);

      debugPrint('Google sign-in successful: ${userCredential.user?.email}');

      return (
        success: true,
        error: null,
        user: userCredential.user,
      );
    } on FirebaseAuthException catch (e) {
      debugPrint('Firebase Auth Error: ${e.code} - ${e.message}');
      return (
        success: false,
        error: _getFirebaseErrorMessage(e.code),
        user: null,
      );
    } catch (e) {
      debugPrint('Google Sign-In Error: $e');
      return (
        success: false,
        error: 'Failed to sign in with Google. Please try again.',
        user: null,
      );
    }
  }

  /// Sign in with Apple
  ///
  /// Implements Apple's secure authentication flow with nonce generation
  /// for replay attack prevention. Returns an [AuthResult] record.
  Future<AuthResult> signInWithApple() async {
    try {
      // Generate secure nonce
      final rawNonce = _generateNonce();
      final nonce = _sha256ofString(rawNonce);

      // Request Apple ID credentials
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      // Create OAuth credential
      final oauthCredential = OAuthProvider('apple.com').credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );

      // Sign in to Firebase
      final userCredential = await _auth.signInWithCredential(oauthCredential);

      // Update display name if available (Apple only provides name on first sign-in)
      if (appleCredential.givenName != null) {
        final displayName =
            '${appleCredential.givenName} ${appleCredential.familyName ?? ''}'
                .trim();
        await userCredential.user?.updateDisplayName(displayName);
      }

      debugPrint('Apple sign-in successful: ${userCredential.user?.email}');

      return (
        success: true,
        error: null,
        user: userCredential.user,
      );
    } on SignInWithAppleAuthorizationException catch (e) {
      debugPrint('Apple Sign-In Authorization Error: ${e.code} - ${e.message}');
      if (e.code == AuthorizationErrorCode.canceled) {
        return (success: false, error: 'Sign in cancelled', user: null);
      }
      return (
        success: false,
        error: 'Apple Sign-In failed. Please try again.',
        user: null,
      );
    } on FirebaseAuthException catch (e) {
      debugPrint('Firebase Auth Error: ${e.code} - ${e.message}');
      return (
        success: false,
        error: _getFirebaseErrorMessage(e.code),
        user: null,
      );
    } catch (e) {
      debugPrint('Apple Sign-In Error: $e');
      return (
        success: false,
        error: 'Failed to sign in with Apple. Please try again.',
        user: null,
      );
    }
  }

  /// Sign out from all providers
  Future<void> signOut() async {
    try {
      // Sign out from Google if signed in
      if (await _googleSignIn.isSignedIn()) {
        await _googleSignIn.signOut();
      }

      // Sign out from Firebase
      await _auth.signOut();

      debugPrint('Sign out successful');
    } catch (e) {
      debugPrint('Sign out error: $e');
      rethrow;
    }
  }

  /// Delete user account
  Future<AuthResult> deleteAccount() async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        return (
          success: false,
          error: 'No user signed in',
          user: null,
        );
      }

      await user.delete();

      // Sign out from Google if signed in
      if (await _googleSignIn.isSignedIn()) {
        await _googleSignIn.signOut();
      }

      return (success: true, error: null, user: null);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        return (
          success: false,
          error: 'Please sign in again before deleting your account.',
          user: null,
        );
      }
      return (
        success: false,
        error: _getFirebaseErrorMessage(e.code),
        user: null,
      );
    } catch (e) {
      debugPrint('Delete account error: $e');
      return (
        success: false,
        error: 'Failed to delete account. Please try again.',
        user: null,
      );
    }
  }

  /// Generate cryptographically secure random nonce
  String _generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// SHA256 hash of string for nonce
  String _sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  /// Get user-friendly error message from Firebase error code
  String _getFirebaseErrorMessage(String code) {
    switch (code) {
      case 'account-exists-with-different-credential':
        return 'An account already exists with the same email but different sign-in credentials.';
      case 'invalid-credential':
        return 'The credential is invalid or has expired.';
      case 'operation-not-allowed':
        return 'This sign-in method is not enabled.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'user-not-found':
        return 'No account found with these credentials.';
      case 'wrong-password':
        return 'Invalid password.';
      case 'network-request-failed':
        return 'Network error. Please check your connection.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';
      default:
        return 'Authentication failed. Please try again.';
    }
  }
}

/// Loading state provider for auth operations
final authLoadingProvider = StateProvider<bool>((ref) => false);

/// Error state provider for auth operations
final authErrorProvider = StateProvider<String?>((ref) => null);
