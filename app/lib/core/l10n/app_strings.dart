/// App UI localization strings.
///
/// Usage: `final s = AppStrings.of(profile?.medium);`
/// Then: `s.settings`, `s.nChapters(16)`, etc.
///
/// Textbook data (subject names, chapter names) is shown verbatim from the
/// textbook and is NOT localized through this class.
class AppStrings {
  const AppStrings._({
    required this.langCode,
    // Home
    required this.yourSubjects,
    required this.progress,
    required this.chapters,
    required this.aiChatTutor,
    required this.aiChatTutorComingSoon,
    // Settings
    required this.settings,
    required this.yourProfile,
    required this.board,
    required this.classLabel,
    required this.mediumLabel,
    required this.changeMedium,
    required this.changeMediumFreeSubtitle,
    required this.changeClass,
    required this.classChangePricingApplies,
    required this.confirm,
    required this.cancel,
    required this.freeTrial,
    required this.trialEnded,
    required this.active,
    required this.subscribe,
    required this.account,
    required this.signOut,
    required this.signOutConfirmBody,
    required this.unableToLoadProfile,
    required this.noProfileFound,
    // Onboarding
    required this.chooseYourBoard,
    required this.selectBoardSubtitle,
    required this.selectMedium,
    required this.continueLabel,
    required this.selectYourClass,
    required this.changeFromSettings,
    required this.getStarted,
    required this.comingSoon,
    required this.selected,
    // Chapter List
    required this.chaptersComingSoon,
    // Simulation
    required this.couldNotLoadSimulation,
  });

  /// Returns localized strings for the given medium.
  static AppStrings of(String? medium) {
    switch (medium?.toLowerCase()) {
      case 'marathi':
        return _marathi;
      default:
        return _english;
    }
  }

  final String langCode;

  // -- Home --
  final String yourSubjects;
  final String progress;
  final String chapters;
  final String aiChatTutor;
  final String aiChatTutorComingSoon;

  // -- Settings --
  final String settings;
  final String yourProfile;
  final String board;
  final String classLabel;
  final String mediumLabel;
  final String changeMedium;
  final String changeMediumFreeSubtitle;
  final String changeClass;
  final String classChangePricingApplies;
  final String confirm;
  final String cancel;
  final String freeTrial;
  final String trialEnded;
  final String active;
  final String subscribe;
  final String account;
  final String signOut;
  final String signOutConfirmBody;
  final String unableToLoadProfile;
  final String noProfileFound;

  // -- Onboarding --
  final String chooseYourBoard;
  final String selectBoardSubtitle;
  final String selectMedium;
  final String continueLabel;
  final String selectYourClass;
  final String changeFromSettings;
  final String getStarted;
  final String comingSoon;
  final String selected;

  // -- Chapter List --
  final String chaptersComingSoon;

  // -- Simulation --
  final String couldNotLoadSimulation;

  // ---------------------------------------------------------------------------
  // Parameterized strings
  // ---------------------------------------------------------------------------

  String nChapters(int n) => '$n $chapters';

  String classDisplay(int n) => '$classLabel $n';

  String freeTrialDaysRemaining(int n) {
    if (langCode == 'mr') return 'मोफत चाचणी: $n दिवस शिल्लक';
    return 'Free Trial: $n ${n == 1 ? 'day' : 'days'} remaining';
  }

  String daysRemainingText(int n) {
    if (langCode == 'mr') return '$n दिवस शिल्लक';
    return '$n ${n == 1 ? 'day' : 'days'} remaining';
  }

  String daysUsedText(int n) {
    if (langCode == 'mr') return '$n दिवस वापरले';
    return '$n ${n == 1 ? 'day' : 'days'} used';
  }

  String daysTotalText(int n) {
    if (langCode == 'mr') return 'एकूण $n दिवस';
    return '$n days total';
  }

  String mediumUpdatedTo(String m) {
    if (langCode == 'mr') return 'माध्यम $m मध्ये बदलले';
    return 'Medium updated to $m';
  }

  String classUpdatedTo(int n) {
    if (langCode == 'mr') return 'इयत्ता $n मध्ये बदलली';
    return 'Class updated to Class $n';
  }

  String changeToClass(int n) {
    if (langCode == 'mr') return 'इयत्ता $n मध्ये बदला';
    return 'Change to Class $n';
  }

  String monthlyPrice(String price) {
    if (langCode == 'mr') return 'मासिक शुल्क: $price';
    return 'Monthly price: $price';
  }

  String freeDuringTrial(int n) {
    if (langCode == 'mr') return 'चाचणी दरम्यान मोफत ($n दिवस शिल्लक)';
    return 'Free during trial ($n ${n == 1 ? 'day' : 'days'} remaining)';
  }

  // ---------------------------------------------------------------------------
  // English
  // ---------------------------------------------------------------------------

  static const _english = AppStrings._(
    langCode: 'en',
    // Home
    yourSubjects: 'Your Subjects',
    progress: 'Progress',
    chapters: 'Chapters',
    aiChatTutor: 'AI Chat Tutor',
    aiChatTutorComingSoon: 'AI Chat Tutor -- Coming soon',
    // Settings
    settings: 'Settings',
    yourProfile: 'Your Profile',
    board: 'Board',
    classLabel: 'Class',
    mediumLabel: 'Medium',
    changeMedium: 'Change Medium',
    changeMediumFreeSubtitle: 'You can change your medium anytime for free',
    changeClass: 'Change Class',
    classChangePricingApplies: 'Class change pricing applies',
    confirm: 'Confirm',
    cancel: 'Cancel',
    freeTrial: 'Free Trial',
    trialEnded: 'Trial ended',
    active: 'Active',
    subscribe: 'Subscribe',
    account: 'Account',
    signOut: 'Sign Out',
    signOutConfirmBody:
        'Are you sure you want to sign out? Your progress will be saved.',
    unableToLoadProfile: 'Unable to load profile.',
    noProfileFound: 'No profile found.',
    // Onboarding
    chooseYourBoard: 'Choose Your Board',
    selectBoardSubtitle: 'Select your education board to get started',
    selectMedium: 'Select Medium',
    continueLabel: 'Continue',
    selectYourClass: 'Select Your Class',
    changeFromSettings: 'You can change this later from settings',
    getStarted: 'Get Started',
    comingSoon: 'Coming Soon',
    selected: 'Selected',
    // Chapter List
    chaptersComingSoon: 'Chapters coming soon',
    // Simulation
    couldNotLoadSimulation: 'Could not load simulation',
  );

  // ---------------------------------------------------------------------------
  // Marathi
  // ---------------------------------------------------------------------------

  static const _marathi = AppStrings._(
    langCode: 'mr',
    // Home
    yourSubjects: 'तुमचे विषय',
    progress: 'प्रगती',
    chapters: 'धडे',
    aiChatTutor: 'AI चॅट शिक्षक',
    aiChatTutorComingSoon: 'AI चॅट शिक्षक -- लवकरच येत आहे',
    // Settings
    settings: 'सेटिंग्ज',
    yourProfile: 'तुमचे प्रोफाइल',
    board: 'बोर्ड',
    classLabel: 'इयत्ता',
    mediumLabel: 'माध्यम',
    changeMedium: 'माध्यम बदला',
    changeMediumFreeSubtitle: 'तुम्ही कधीही माध्यम मोफत बदलू शकता',
    changeClass: 'इयत्ता बदला',
    classChangePricingApplies: 'इयत्ता बदलासाठी शुल्क लागू',
    confirm: 'पुष्टी करा',
    cancel: 'रद्द करा',
    freeTrial: 'मोफत चाचणी',
    trialEnded: 'चाचणी संपली',
    active: 'सक्रिय',
    subscribe: 'सदस्यता घ्या',
    account: 'खाते',
    signOut: 'साइन आउट',
    signOutConfirmBody:
        'तुम्हाला खात्री आहे का? तुमची प्रगती सेव्ह केली जाईल.',
    unableToLoadProfile: 'प्रोफाइल लोड करता आले नाही.',
    noProfileFound: 'प्रोफाइल सापडले नाही.',
    // Onboarding
    chooseYourBoard: 'तुमचा बोर्ड निवडा',
    selectBoardSubtitle: 'सुरू करण्यासाठी तुमचा शिक्षण बोर्ड निवडा',
    selectMedium: 'माध्यम निवडा',
    continueLabel: 'पुढे',
    selectYourClass: 'तुमची इयत्ता निवडा',
    changeFromSettings: 'तुम्ही हे नंतर सेटिंग्जमधून बदलू शकता',
    getStarted: 'सुरू करा',
    comingSoon: 'लवकरच',
    selected: 'निवडले',
    // Chapter List
    chaptersComingSoon: 'धडे लवकरच येत आहेत',
    // Simulation
    couldNotLoadSimulation: 'सिम्युलेशन लोड करता आले नाही',
  );
}
