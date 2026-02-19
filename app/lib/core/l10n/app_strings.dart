/// App UI localization strings.
///
/// Usage: `final s = AppStrings.of(profile?.medium);`
/// Then: `s.settings`, `s.nChapters(16)`, etc.
///
/// Textbook data (subject names, chapter names) is shown verbatim from the
/// textbook and is NOT localized through this class.
///
/// Supported languages: English, Marathi, Hindi, Urdu, Gujarati, Kannada, Telugu.
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
    // Gamification & Enhanced UI
    required this.continueLearning,
    required this.markDone,
    required this.leaderboard,
    required this.minutesShort,
    required this.level,
  });

  /// Returns localized strings for the given medium.
  static AppStrings of(String? medium) {
    switch (medium?.toLowerCase()) {
      case 'marathi':
        return _marathi;
      case 'hindi':
        return _hindi;
      case 'urdu':
        return _urdu;
      case 'gujarati':
        return _gujarati;
      case 'kannada':
        return _kannada;
      case 'telugu':
        return _telugu;
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

  // -- Gamification & Enhanced UI --
  final String continueLearning;
  final String markDone;
  final String leaderboard;
  final String minutesShort;
  final String level;

  // ---------------------------------------------------------------------------
  // Parameterized strings
  // ---------------------------------------------------------------------------

  String nChapters(int n) => '$n $chapters';

  String classDisplay(int n) => '$classLabel $n';

  String freeTrialDaysRemaining(int n) {
    switch (langCode) {
      case 'mr':
        return 'मोफत चाचणी: $n दिवस शिल्लक';
      case 'hi':
        return 'मुफ्त परीक्षण: $n दिन शेष';
      case 'ur':
        return 'مفت آزمائش: $n دن باقی';
      case 'gu':
        return 'મફત ટ્રાયલ: $n દિવસ બાકી';
      case 'kn':
        return 'ಉಚಿತ ಪ್ರಯೋಗ: $n ದಿನ ಬಾಕಿ';
      case 'te':
        return 'ఉచిత ట్రయల్: $n రోజులు మిగిలి ఉన్నాయి';
      default:
        return 'Free Trial: $n ${n == 1 ? 'day' : 'days'} remaining';
    }
  }

  String daysRemainingText(int n) {
    switch (langCode) {
      case 'mr':
        return '$n दिवस शिल्लक';
      case 'hi':
        return '$n दिन शेष';
      case 'ur':
        return '$n دن باقی';
      case 'gu':
        return '$n દિવસ બાકી';
      case 'kn':
        return '$n ದಿನ ಬಾಕಿ';
      case 'te':
        return '$n రోజులు మిగిలి ఉన్నాయి';
      default:
        return '$n ${n == 1 ? 'day' : 'days'} remaining';
    }
  }

  String daysUsedText(int n) {
    switch (langCode) {
      case 'mr':
        return '$n दिवस वापरले';
      case 'hi':
        return '$n दिन उपयोग किए';
      case 'ur':
        return '$n دن استعمال ہوئے';
      case 'gu':
        return '$n દિવસ વપરાયા';
      case 'kn':
        return '$n ದಿನ ಬಳಸಲಾಗಿದೆ';
      case 'te':
        return '$n రోజులు వాడారు';
      default:
        return '$n ${n == 1 ? 'day' : 'days'} used';
    }
  }

  String daysTotalText(int n) {
    switch (langCode) {
      case 'mr':
        return 'एकूण $n दिवस';
      case 'hi':
        return 'कुल $n दिन';
      case 'ur':
        return 'کل $n دن';
      case 'gu':
        return 'કુલ $n દિવસ';
      case 'kn':
        return 'ಒಟ್ಟು $n ದಿನ';
      case 'te':
        return 'మొత్తం $n రోజులు';
      default:
        return '$n days total';
    }
  }

  String mediumUpdatedTo(String m) {
    switch (langCode) {
      case 'mr':
        return 'माध्यम $m मध्ये बदलले';
      case 'hi':
        return 'माध्यम $m में बदला गया';
      case 'ur':
        return 'ذریعہ $m میں تبدیل ہو گیا';
      case 'gu':
        return 'માધ્યમ $m માં બદલાયું';
      case 'kn':
        return 'ಮಾಧ್ಯಮವನ್ನು $m ಗೆ ಬದಲಾಯಿಸಲಾಗಿದೆ';
      case 'te':
        return 'మాధ్యమం $m కి మార్చబడింది';
      default:
        return 'Medium updated to $m';
    }
  }

  String classUpdatedTo(int n) {
    switch (langCode) {
      case 'mr':
        return 'इयत्ता $n मध्ये बदलली';
      case 'hi':
        return 'कक्षा $n में बदला गया';
      case 'ur':
        return 'جماعت $n میں تبدیل ہو گئی';
      case 'gu':
        return 'ધોરણ $n માં બદલાયું';
      case 'kn':
        return 'ತರಗತಿ $n ಗೆ ಬದಲಾಯಿಸಲಾಗಿದೆ';
      case 'te':
        return 'తరగతి $n కి మార్చబడింది';
      default:
        return 'Class updated to Class $n';
    }
  }

  String changeToClass(int n) {
    switch (langCode) {
      case 'mr':
        return 'इयत्ता $n मध्ये बदला';
      case 'hi':
        return 'कक्षा $n में बदलें';
      case 'ur':
        return 'جماعت $n میں تبدیل کریں';
      case 'gu':
        return 'ધોરણ $n માં બદલો';
      case 'kn':
        return 'ತರಗತಿ $n ಗೆ ಬದಲಾಯಿಸಿ';
      case 'te':
        return 'తరగతి $n కి మార్చండి';
      default:
        return 'Change to Class $n';
    }
  }

  String monthlyPrice(String price) {
    switch (langCode) {
      case 'mr':
        return 'मासिक शुल्क: $price';
      case 'hi':
        return 'मासिक शुल्क: $price';
      case 'ur':
        return 'ماہانہ قیمت: $price';
      case 'gu':
        return 'માસિક કિંમત: $price';
      case 'kn':
        return 'ಮಾಸಿಕ ಬೆಲೆ: $price';
      case 'te':
        return 'నెలవారీ ధర: $price';
      default:
        return 'Monthly price: $price';
    }
  }

  String freeDuringTrial(int n) {
    switch (langCode) {
      case 'mr':
        return 'चाचणी दरम्यान मोफत ($n दिवस शिल्लक)';
      case 'hi':
        return 'परीक्षण के दौरान मुफ्त ($n दिन शेष)';
      case 'ur':
        return 'آزمائش کے دوران مفت ($n دن باقی)';
      case 'gu':
        return 'ટ્રાયલ દરમિયાન મફત ($n દિવસ બાકી)';
      case 'kn':
        return 'ಪ್ರಯೋಗದ ಸಮಯದಲ್ಲಿ ಉಚಿತ ($n ದಿನ ಬಾಕಿ)';
      case 'te':
        return 'ట్రయల్ సమయంలో ఉచితం ($n రోజులు మిగిలి ఉన్నాయి)';
      default:
        return 'Free during trial ($n ${n == 1 ? 'day' : 'days'} remaining)';
    }
  }

  String xpDisplay(int xp) => '$xp XP';

  String streakDisplay(int days) {
    switch (langCode) {
      case 'mr':
        return '$days दिवस';
      case 'hi':
        return '$days दिन';
      case 'ur':
        return '$days دن';
      case 'gu':
        return '$days દિવસ';
      case 'kn':
        return '$days ದಿನ';
      case 'te':
        return '$days రోజులు';
      default:
        return '$days ${days == 1 ? 'day' : 'days'}';
    }
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
    // Gamification & Enhanced UI
    continueLearning: 'Continue Learning',
    markDone: 'Mark Done',
    leaderboard: 'Leaderboard',
    minutesShort: 'min',
    level: 'Level',
  );

  // ---------------------------------------------------------------------------
  // Marathi (मराठी)
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
    // Gamification & Enhanced UI
    continueLearning: 'शिकणे सुरू ठेवा',
    markDone: 'पूर्ण झाले',
    leaderboard: 'लीडरबोर्ड',
    minutesShort: 'मिनि',
    level: 'स्तर',
  );

  // ---------------------------------------------------------------------------
  // Hindi (हिन्दी)
  // ---------------------------------------------------------------------------

  static const _hindi = AppStrings._(
    langCode: 'hi',
    // Home
    yourSubjects: 'आपके विषय',
    progress: 'प्रगति',
    chapters: 'अध्याय',
    aiChatTutor: 'AI चैट ट्यूटर',
    aiChatTutorComingSoon: 'AI चैट ट्यूटर -- जल्द आ रहा है',
    // Settings
    settings: 'सेटिंग्स',
    yourProfile: 'आपकी प्रोफ़ाइल',
    board: 'बोर्ड',
    classLabel: 'कक्षा',
    mediumLabel: 'माध्यम',
    changeMedium: 'माध्यम बदलें',
    changeMediumFreeSubtitle: 'आप कभी भी माध्यम मुफ्त में बदल सकते हैं',
    changeClass: 'कक्षा बदलें',
    classChangePricingApplies: 'कक्षा बदलने पर शुल्क लागू',
    confirm: 'पुष्टि करें',
    cancel: 'रद्द करें',
    freeTrial: 'मुफ्त परीक्षण',
    trialEnded: 'परीक्षण समाप्त',
    active: 'सक्रिय',
    subscribe: 'सदस्यता लें',
    account: 'खाता',
    signOut: 'साइन आउट',
    signOutConfirmBody:
        'क्या आप साइन आउट करना चाहते हैं? आपकी प्रगति सुरक्षित रहेगी।',
    unableToLoadProfile: 'प्रोफ़ाइल लोड नहीं हो सकी।',
    noProfileFound: 'कोई प्रोफ़ाइल नहीं मिली।',
    // Onboarding
    chooseYourBoard: 'अपना बोर्ड चुनें',
    selectBoardSubtitle: 'शुरू करने के लिए अपना शिक्षा बोर्ड चुनें',
    selectMedium: 'माध्यम चुनें',
    continueLabel: 'आगे बढ़ें',
    selectYourClass: 'अपनी कक्षा चुनें',
    changeFromSettings: 'आप इसे बाद में सेटिंग्स से बदल सकते हैं',
    getStarted: 'शुरू करें',
    comingSoon: 'जल्द आ रहा है',
    selected: 'चयनित',
    // Chapter List
    chaptersComingSoon: 'अध्याय जल्द आ रहे हैं',
    // Simulation
    couldNotLoadSimulation: 'सिमुलेशन लोड नहीं हो सका',
    // Gamification & Enhanced UI
    continueLearning: 'पढ़ाई जारी रखें',
    markDone: 'पूर्ण करें',
    leaderboard: 'लीडरबोर्ड',
    minutesShort: 'मिनट',
    level: 'स्तर',
  );

  // ---------------------------------------------------------------------------
  // Urdu (اردو)
  // ---------------------------------------------------------------------------

  static const _urdu = AppStrings._(
    langCode: 'ur',
    // Home
    yourSubjects: 'آپ کے مضامین',
    progress: 'پیش رفت',
    chapters: 'ابواب',
    aiChatTutor: 'AI چیٹ ٹیوٹر',
    aiChatTutorComingSoon: 'AI چیٹ ٹیوٹر -- جلد آ رہا ہے',
    // Settings
    settings: 'ترتیبات',
    yourProfile: 'آپ کی پروفائل',
    board: 'بورڈ',
    classLabel: 'جماعت',
    mediumLabel: 'ذریعہ',
    changeMedium: 'ذریعہ تبدیل کریں',
    changeMediumFreeSubtitle: 'آپ کسی بھی وقت ذریعہ مفت میں تبدیل کر سکتے ہیں',
    changeClass: 'جماعت تبدیل کریں',
    classChangePricingApplies: 'جماعت تبدیل کرنے پر فیس لاگو ہوگی',
    confirm: 'تصدیق کریں',
    cancel: 'منسوخ کریں',
    freeTrial: 'مفت آزمائش',
    trialEnded: 'آزمائش ختم ہوئی',
    active: 'فعال',
    subscribe: 'سبسکرائب کریں',
    account: 'اکاؤنٹ',
    signOut: 'سائن آؤٹ',
    signOutConfirmBody:
        'کیا آپ سائن آؤٹ کرنا چاہتے ہیں؟ آپ کی پیش رفت محفوظ رہے گی۔',
    unableToLoadProfile: 'پروفائل لوڈ نہیں ہو سکی۔',
    noProfileFound: 'کوئی پروفائل نہیں ملی۔',
    // Onboarding
    chooseYourBoard: 'اپنا بورڈ چنیں',
    selectBoardSubtitle: 'شروع کرنے کے لیے اپنا تعلیمی بورڈ چنیں',
    selectMedium: 'ذریعہ چنیں',
    continueLabel: 'آگے بڑھیں',
    selectYourClass: 'اپنی جماعت چنیں',
    changeFromSettings: 'آپ بعد میں ترتیبات سے تبدیل کر سکتے ہیں',
    getStarted: 'شروع کریں',
    comingSoon: 'جلد آ رہا ہے',
    selected: 'منتخب',
    // Chapter List
    chaptersComingSoon: 'ابواب جلد آ رہے ہیں',
    // Simulation
    couldNotLoadSimulation: 'سمیولیشن لوڈ نہیں ہو سکا',
    // Gamification & Enhanced UI
    continueLearning: 'پڑھائی جاری رکھیں',
    markDone: 'مکمل کریں',
    leaderboard: 'لیڈر بورڈ',
    minutesShort: 'منٹ',
    level: 'درجہ',
  );

  // ---------------------------------------------------------------------------
  // Gujarati (ગુજરાતી)
  // ---------------------------------------------------------------------------

  static const _gujarati = AppStrings._(
    langCode: 'gu',
    // Home
    yourSubjects: 'તમારા વિષયો',
    progress: 'પ્રગતિ',
    chapters: 'પ્રકરણો',
    aiChatTutor: 'AI ચેટ ટ્યૂટર',
    aiChatTutorComingSoon: 'AI ચેટ ટ્યૂટર -- ટૂંક સમયમાં આવી રહ્યું છે',
    // Settings
    settings: 'સેટિંગ્સ',
    yourProfile: 'તમારી પ્રોફાઇલ',
    board: 'બોર્ડ',
    classLabel: 'ધોરણ',
    mediumLabel: 'માધ્યમ',
    changeMedium: 'માધ્યમ બદલો',
    changeMediumFreeSubtitle: 'તમે ગમે ત્યારે માધ્યમ મફતમાં બદલી શકો છો',
    changeClass: 'ધોરણ બદલો',
    classChangePricingApplies: 'ધોરણ બદલવા પર શુલ્ક લાગુ',
    confirm: 'ખાતરી કરો',
    cancel: 'રદ કરો',
    freeTrial: 'મફત ટ્રાયલ',
    trialEnded: 'ટ્રાયલ સમાપ્ત',
    active: 'સક્રિય',
    subscribe: 'સબ્સ્ક્રાઇબ કરો',
    account: 'ખાતું',
    signOut: 'સાઇન આઉટ',
    signOutConfirmBody:
        'શું તમે સાઇન આઉટ કરવા માગો છો? તમારી પ્રગતિ સાચવવામાં આવશે.',
    unableToLoadProfile: 'પ્રોફાઇલ લોડ થઈ શકી નથી.',
    noProfileFound: 'કોઈ પ્રોફાઇલ મળી નથી.',
    // Onboarding
    chooseYourBoard: 'તમારું બોર્ડ પસંદ કરો',
    selectBoardSubtitle: 'શરૂ કરવા માટે તમારું શિક્ષણ બોર્ડ પસંદ કરો',
    selectMedium: 'માધ્યમ પસંદ કરો',
    continueLabel: 'આગળ વધો',
    selectYourClass: 'તમારું ધોરણ પસંદ કરો',
    changeFromSettings: 'તમે આ પછીથી સેટિંગ્સમાંથી બદલી શકો છો',
    getStarted: 'શરૂ કરો',
    comingSoon: 'ટૂંક સમયમાં',
    selected: 'પસંદ કરેલ',
    // Chapter List
    chaptersComingSoon: 'પ્રકરણો ટૂંક સમયમાં આવી રહ્યા છે',
    // Simulation
    couldNotLoadSimulation: 'સિમ્યુલેશન લોડ થઈ શક્યું નથી',
    // Gamification & Enhanced UI
    continueLearning: 'ભણવાનું ચાલુ રાખો',
    markDone: 'પૂર્ણ કરો',
    leaderboard: 'લીડરબોર્ડ',
    minutesShort: 'મિનિટ',
    level: 'સ્તર',
  );

  // ---------------------------------------------------------------------------
  // Kannada (ಕನ್ನಡ)
  // ---------------------------------------------------------------------------

  static const _kannada = AppStrings._(
    langCode: 'kn',
    // Home
    yourSubjects: 'ನಿಮ್ಮ ವಿಷಯಗಳು',
    progress: 'ಪ್ರಗತಿ',
    chapters: 'ಅಧ್ಯಾಯಗಳು',
    aiChatTutor: 'AI ಚಾಟ್ ಟ್ಯೂಟರ್',
    aiChatTutorComingSoon: 'AI ಚಾಟ್ ಟ್ಯೂಟರ್ -- ಶೀಘ್ರದಲ್ಲಿ ಬರಲಿದೆ',
    // Settings
    settings: 'ಸೆಟ್ಟಿಂಗ್ಸ್',
    yourProfile: 'ನಿಮ್ಮ ಪ್ರೊಫೈಲ್',
    board: 'ಬೋರ್ಡ್',
    classLabel: 'ತರಗತಿ',
    mediumLabel: 'ಮಾಧ್ಯಮ',
    changeMedium: 'ಮಾಧ್ಯಮ ಬದಲಾಯಿಸಿ',
    changeMediumFreeSubtitle: 'ನೀವು ಯಾವಾಗ ಬೇಕಾದರೂ ಮಾಧ್ಯಮವನ್ನು ಉಚಿತವಾಗಿ ಬದಲಾಯಿಸಬಹುದು',
    changeClass: 'ತರಗತಿ ಬದಲಾಯಿಸಿ',
    classChangePricingApplies: 'ತರಗತಿ ಬದಲಾವಣೆಗೆ ಶುಲ್ಕ ಅನ್ವಯವಾಗುತ್ತದೆ',
    confirm: 'ದೃಢೀಕರಿಸಿ',
    cancel: 'ರದ್ದುಮಾಡಿ',
    freeTrial: 'ಉಚಿತ ಪ್ರಯೋಗ',
    trialEnded: 'ಪ್ರಯೋಗ ಮುಗಿದಿದೆ',
    active: 'ಸಕ್ರಿಯ',
    subscribe: 'ಚಂದಾದಾರರಾಗಿ',
    account: 'ಖಾತೆ',
    signOut: 'ಸೈನ್ ಔಟ್',
    signOutConfirmBody:
        'ನೀವು ಸೈನ್ ಔಟ್ ಮಾಡಲು ಖಚಿತವಾಗಿದ್ದೀರಾ? ನಿಮ್ಮ ಪ್ರಗತಿ ಉಳಿಸಲಾಗುವುದು.',
    unableToLoadProfile: 'ಪ್ರೊಫೈಲ್ ಲೋಡ್ ಮಾಡಲು ಸಾಧ್ಯವಾಗಲಿಲ್ಲ.',
    noProfileFound: 'ಯಾವುದೇ ಪ್ರೊಫೈಲ್ ಕಂಡುಬಂದಿಲ್ಲ.',
    // Onboarding
    chooseYourBoard: 'ನಿಮ್ಮ ಬೋರ್ಡ್ ಆಯ್ಕೆಮಾಡಿ',
    selectBoardSubtitle: 'ಪ್ರಾರಂಭಿಸಲು ನಿಮ್ಮ ಶಿಕ್ಷಣ ಬೋರ್ಡ್ ಆಯ್ಕೆಮಾಡಿ',
    selectMedium: 'ಮಾಧ್ಯಮ ಆಯ್ಕೆಮಾಡಿ',
    continueLabel: 'ಮುಂದುವರಿಸಿ',
    selectYourClass: 'ನಿಮ್ಮ ತರಗತಿ ಆಯ್ಕೆಮಾಡಿ',
    changeFromSettings: 'ನೀವು ಇದನ್ನು ನಂತರ ಸೆಟ್ಟಿಂಗ್ಸ್‌ನಿಂದ ಬದಲಾಯಿಸಬಹುದು',
    getStarted: 'ಪ್ರಾರಂಭಿಸಿ',
    comingSoon: 'ಶೀಘ್ರದಲ್ಲಿ',
    selected: 'ಆಯ್ಕೆಮಾಡಲಾಗಿದೆ',
    // Chapter List
    chaptersComingSoon: 'ಅಧ್ಯಾಯಗಳು ಶೀಘ್ರದಲ್ಲಿ ಬರಲಿವೆ',
    // Simulation
    couldNotLoadSimulation: 'ಸಿಮ್ಯುಲೇಶನ್ ಲೋಡ್ ಮಾಡಲು ಸಾಧ್ಯವಾಗಲಿಲ್ಲ',
    // Gamification & Enhanced UI
    continueLearning: 'ಕಲಿಕೆ ಮುಂದುವರಿಸಿ',
    markDone: 'ಪೂರ್ಣಗೊಳಿಸಿ',
    leaderboard: 'ಲೀಡರ್‌ಬೋರ್ಡ್',
    minutesShort: 'ನಿಮಿ',
    level: 'ಮಟ್ಟ',
  );

  // ---------------------------------------------------------------------------
  // Telugu (తెలుగు)
  // ---------------------------------------------------------------------------

  static const _telugu = AppStrings._(
    langCode: 'te',
    // Home
    yourSubjects: 'మీ విషయాలు',
    progress: 'పురోగతి',
    chapters: 'అధ్యాయాలు',
    aiChatTutor: 'AI చాట్ ట్యూటర్',
    aiChatTutorComingSoon: 'AI చాట్ ట్యూటర్ -- త్వరలో వస్తుంది',
    // Settings
    settings: 'సెట్టింగ్స్',
    yourProfile: 'మీ ప్రొఫైల్',
    board: 'బోర్డు',
    classLabel: 'తరగతి',
    mediumLabel: 'మాధ్యమం',
    changeMedium: 'మాధ్యమం మార్చండి',
    changeMediumFreeSubtitle: 'మీరు ఎప్పుడైనా మాధ్యమాన్ని ఉచితంగా మార్చుకోవచ్చు',
    changeClass: 'తరగతి మార్చండి',
    classChangePricingApplies: 'తరగతి మార్పుకు రుసుము వర్తిస్తుంది',
    confirm: 'నిర్ధారించండి',
    cancel: 'రద్దు చేయండి',
    freeTrial: 'ఉచిత ట్రయల్',
    trialEnded: 'ట్రయల్ ముగిసింది',
    active: 'యాక్టివ్',
    subscribe: 'సబ్‌స్క్రైబ్ చేయండి',
    account: 'ఖాతా',
    signOut: 'సైన్ అవుట్',
    signOutConfirmBody:
        'మీరు సైన్ అవుట్ చేయాలనుకుంటున్నారా? మీ పురోగతి సేవ్ చేయబడుతుంది.',
    unableToLoadProfile: 'ప్రొఫైల్ లోడ్ చేయడం సాధ్యం కాలేదు.',
    noProfileFound: 'ప్రొఫైల్ కనుగొనబడలేదు.',
    // Onboarding
    chooseYourBoard: 'మీ బోర్డును ఎంచుకోండి',
    selectBoardSubtitle: 'ప్రారంభించడానికి మీ విద్యా బోర్డును ఎంచుకోండి',
    selectMedium: 'మాధ్యమం ఎంచుకోండి',
    continueLabel: 'కొనసాగించండి',
    selectYourClass: 'మీ తరగతిని ఎంచుకోండి',
    changeFromSettings: 'మీరు దీన్ని తర్వాత సెట్టింగ్స్ నుండి మార్చవచ్చు',
    getStarted: 'ప్రారంభించండి',
    comingSoon: 'త్వరలో',
    selected: 'ఎంపిక చేయబడింది',
    // Chapter List
    chaptersComingSoon: 'అధ్యాయాలు త్వరలో వస్తున్నాయి',
    // Simulation
    couldNotLoadSimulation: 'సిమ్యులేషన్ లోడ్ చేయడం సాధ్యం కాలేదు',
    // Gamification & Enhanced UI
    continueLearning: 'నేర్చుకోవడం కొనసాగించండి',
    markDone: 'పూర్తి చేయండి',
    leaderboard: 'లీడర్‌బోర్డ్',
    minutesShort: 'నిమి',
    level: 'స్థాయి',
  );
}
