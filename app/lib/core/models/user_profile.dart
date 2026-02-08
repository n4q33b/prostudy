import 'dart:math';

/// Immutable user profile model for ProStudy
///
/// Stores the user's selected board, class level, and medium.
/// Includes trial period tracking and JSON serialization for local storage.
class UserProfile {
  const UserProfile({
    required this.board,
    required this.classLevel,
    required this.medium,
    required this.trialStartDate,
    required this.createdAt,
  });

  /// Education board identifier: 'maharashtra', 'cbse', 'ncert'
  final String board;

  /// Student class level: 5-10
  final int classLevel;

  /// Language medium: 'marathi', 'hindi', 'english', 'urdu', etc.
  final String medium;

  /// Date when the free trial period began
  final DateTime trialStartDate;

  /// Date when the profile was first created
  final DateTime createdAt;

  // ---------------------------------------------------------------------------
  // Computed Properties
  // ---------------------------------------------------------------------------

  /// Whether the 15-day free trial is still active
  bool get isTrialActive =>
      DateTime.now().difference(trialStartDate).inDays < 15;

  /// Number of trial days remaining (0 if trial has expired)
  int get trialDaysRemaining =>
      max(0, 15 - DateTime.now().difference(trialStartDate).inDays);

  // ---------------------------------------------------------------------------
  // Copy
  // ---------------------------------------------------------------------------

  /// Creates a copy of this profile with the given fields replaced
  UserProfile copyWith({
    String? board,
    int? classLevel,
    String? medium,
    DateTime? trialStartDate,
    DateTime? createdAt,
  }) {
    return UserProfile(
      board: board ?? this.board,
      classLevel: classLevel ?? this.classLevel,
      medium: medium ?? this.medium,
      trialStartDate: trialStartDate ?? this.trialStartDate,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  // ---------------------------------------------------------------------------
  // JSON Serialization (for SharedPreferences storage)
  // ---------------------------------------------------------------------------

  /// Creates a [UserProfile] from a JSON map
  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      board: json['board'] as String,
      classLevel: json['classLevel'] as int,
      medium: json['medium'] as String,
      trialStartDate: DateTime.parse(json['trialStartDate'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  /// Converts this profile to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'board': board,
      'classLevel': classLevel,
      'medium': medium,
      'trialStartDate': trialStartDate.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // ---------------------------------------------------------------------------
  // Equality & Debug
  // ---------------------------------------------------------------------------

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserProfile &&
        other.board == board &&
        other.classLevel == classLevel &&
        other.medium == medium &&
        other.trialStartDate == trialStartDate &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode => Object.hash(
        board,
        classLevel,
        medium,
        trialStartDate,
        createdAt,
      );

  @override
  String toString() {
    return 'UserProfile('
        'board: $board, '
        'classLevel: $classLevel, '
        'medium: $medium, '
        'trialStartDate: $trialStartDate, '
        'createdAt: $createdAt'
        ')';
  }
}
