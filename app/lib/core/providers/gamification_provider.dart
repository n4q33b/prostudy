import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Gamification level tiers (Sanskrit-inspired names)
enum StudentLevel {
  shishya,     // 0-99 XP
  vidyarthi,   // 100-499 XP
  gyani,       // 500-999 XP
  acharya,     // 1000-2499 XP
  guru,        // 2500-4999 XP
  maharishi,   // 5000+ XP
}

/// Current gamification state (UI-only placeholder)
class GamificationState {
  const GamificationState({
    this.totalXp = 0,
    this.currentStreak = 0,
    this.longestStreak = 0,
    this.completedChapters = 0,
  });

  final int totalXp;
  final int currentStreak;
  final int longestStreak;
  final int completedChapters;

  StudentLevel get level {
    if (totalXp >= 5000) return StudentLevel.maharishi;
    if (totalXp >= 2500) return StudentLevel.guru;
    if (totalXp >= 1000) return StudentLevel.acharya;
    if (totalXp >= 500) return StudentLevel.gyani;
    if (totalXp >= 100) return StudentLevel.vidyarthi;
    return StudentLevel.shishya;
  }

  String get levelName {
    switch (level) {
      case StudentLevel.shishya: return 'Shishya';
      case StudentLevel.vidyarthi: return 'Vidyarthi';
      case StudentLevel.gyani: return 'Gyani';
      case StudentLevel.acharya: return 'Acharya';
      case StudentLevel.guru: return 'Guru';
      case StudentLevel.maharishi: return 'Maharishi';
    }
  }

  String get levelEmoji {
    switch (level) {
      case StudentLevel.shishya: return '\u{1F331}';       // seedling
      case StudentLevel.vidyarthi: return '\u{1F4DA}';     // books
      case StudentLevel.gyani: return '\u{1F9E0}';         // brain
      case StudentLevel.acharya: return '\u{2B50}';        // star
      case StudentLevel.guru: return '\u{1F451}';          // crown
      case StudentLevel.maharishi: return '\u{1F31F}';     // glowing star
    }
  }

  int get xpToNextLevel {
    switch (level) {
      case StudentLevel.shishya: return 100 - totalXp;
      case StudentLevel.vidyarthi: return 500 - totalXp;
      case StudentLevel.gyani: return 1000 - totalXp;
      case StudentLevel.acharya: return 2500 - totalXp;
      case StudentLevel.guru: return 5000 - totalXp;
      case StudentLevel.maharishi: return 0; // Max level
    }
  }

  GamificationState copyWith({
    int? totalXp,
    int? currentStreak,
    int? longestStreak,
    int? completedChapters,
  }) {
    return GamificationState(
      totalXp: totalXp ?? this.totalXp,
      currentStreak: currentStreak ?? this.currentStreak,
      longestStreak: longestStreak ?? this.longestStreak,
      completedChapters: completedChapters ?? this.completedChapters,
    );
  }
}

/// Provider -- currently returns hardcoded placeholder values
final gamificationProvider = StateProvider<GamificationState>((ref) {
  return const GamificationState();
});
