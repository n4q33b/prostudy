import '../models/chapter_data.dart';
import 'chapters_common.dart';

// ---------------------------------------------------------------------------
// English medium – Class 5 – 14 subjects
// ---------------------------------------------------------------------------

const Map<String, List<ChapterData>> englishChapters = {
  'Mathematics': _mathChaptersEnglish,
  'English Balbharati': _englishBalbharatiChapters,
  'हिंदी सुलभभारती': hindiSulabhbharatiChapters,
  'हिंदी सुगमभारती': hindiSugambharatiChapters,
  'मराठी सुलभभारती': marathiSulabhbharatiChapters,
  'मराठी सुगमभारती': marathiSugambharatiChapters,
  'Environmental Studies Part 1': _evsPart1ChaptersEnglish,
  'Environmental Studies Part 2': _evsPart2ChaptersEnglish,
  'Play Do Learn': _playDoLearnChapters,
  'ગુજરાતી સાહિત્ય પરિચય': _gujaratiSahityaChapters,
  'ಕನ್ನಡ ಸುಗಮಭಾರತಿ': _kannadaSugambharatiChapters,
  'తెలుగు సరళ భారతి': _teluguSaralBharatiChapters,
  'सिंधू भारती': _sindhuBharatiChaptersEnglish,
  'تعارفِ اُردو': _taarufeUrduChapters,
};

// ---------------------------------------------------------------------------
// Mathematics – 16 chapters
// ---------------------------------------------------------------------------
const List<ChapterData> _mathChaptersEnglish = [
  ChapterData(number: 1, name: 'Roman Numerals', nameEn: 'Roman Numerals'),
  ChapterData(number: 2, name: 'Number Work', nameEn: 'Number Work'),
  ChapterData(number: 3, name: 'Addition and Subtraction', nameEn: 'Addition and Subtraction'),
  ChapterData(number: 4, name: 'Multiplication and Division', nameEn: 'Multiplication and Division'),
  ChapterData(number: 5, name: 'Fractions', nameEn: 'Fractions'),
  ChapterData(number: 6, name: 'Angles', nameEn: 'Angles'),
  ChapterData(number: 7, name: 'Circles', nameEn: 'Circles'),
  ChapterData(number: 8, name: 'Multiples and Factors', nameEn: 'Multiples and Factors'),
  ChapterData(number: 9, name: 'Decimal Fractions', nameEn: 'Decimal Fractions'),
  ChapterData(number: 10, name: 'Measuring Time', nameEn: 'Measuring Time'),
  ChapterData(number: 11, name: 'Problems on Measurement', nameEn: 'Problems on Measurement'),
  ChapterData(number: 12, name: 'Perimeter and Area', nameEn: 'Perimeter and Area'),
  ChapterData(number: 13, name: 'Three Dimensional Objects and Nets', nameEn: 'Three Dimensional Objects and Nets'),
  ChapterData(number: 14, name: 'Pictographs', nameEn: 'Pictographs'),
  ChapterData(number: 15, name: 'Patterns', nameEn: 'Patterns'),
  ChapterData(number: 16, name: 'Preparation for Algebra', nameEn: 'Preparation for Algebra'),
];

// ---------------------------------------------------------------------------
// English Balbharati – 34 chapters
// ---------------------------------------------------------------------------
const List<ChapterData> _englishBalbharatiChapters = [
  ChapterData(number: 1, name: 'What a Bird Thought', nameEn: 'What a Bird Thought'),
  ChapterData(number: 2, name: 'Daydreams', nameEn: 'Daydreams'),
  ChapterData(number: 3, name: 'Be a Good Listener', nameEn: 'Be a Good Listener'),
  ChapterData(number: 4, name: 'Strawberries', nameEn: 'Strawberries'),
  ChapterData(number: 5, name: 'The Twelve Months', nameEn: 'The Twelve Months'),
  ChapterData(number: 6, name: 'Announcements', nameEn: 'Announcements'),
  ChapterData(number: 7, name: 'Major Dhyan Chand', nameEn: 'Major Dhyan Chand'),
  ChapterData(number: 8, name: 'Peer Profile', nameEn: 'Peer Profile'),
  ChapterData(number: 9, name: 'The Triantiwontigongolope', nameEn: 'The Triantiwontigongolope'),
  ChapterData(number: 10, name: 'Three Sacks of Rice', nameEn: 'Three Sacks of Rice'),
  ChapterData(number: 11, name: 'Be a Good Speaker', nameEn: 'Be a Good Speaker'),
  ChapterData(number: 12, name: 'Count your Garden', nameEn: 'Count your Garden'),
  ChapterData(number: 13, name: 'The Adventures of Gulliver', nameEn: 'The Adventures of Gulliver'),
  ChapterData(number: 14, name: 'A Lesson for All', nameEn: 'A Lesson for All'),
  ChapterData(number: 15, name: 'Bird Bath', nameEn: 'Bird Bath'),
  ChapterData(number: 16, name: 'Write your own Story', nameEn: 'Write your own Story'),
  ChapterData(number: 17, name: 'On the Water', nameEn: 'On the Water'),
  ChapterData(number: 18, name: 'Weeds in the Garden', nameEn: 'Weeds in the Garden'),
  ChapterData(number: 19, name: 'Be a Good Host and Guest', nameEn: 'Be a Good Host and Guest'),
  ChapterData(number: 20, name: 'Only One Mother', nameEn: 'Only One Mother'),
  ChapterData(number: 21, name: 'The Journey to the Great Oz', nameEn: 'The Journey to the Great Oz'),
  ChapterData(number: 22, name: 'A Book Review', nameEn: 'A Book Review'),
  ChapterData(number: 23, name: 'Write your own Poem', nameEn: 'Write your own Poem'),
  ChapterData(number: 24, name: 'Senses Alert', nameEn: 'Senses Alert'),
  ChapterData(number: 25, name: 'The Man in the Moon', nameEn: 'The Man in the Moon'),
  ChapterData(number: 26, name: 'Water in the Well', nameEn: 'Water in the Well'),
  ChapterData(number: 27, name: 'The Legend of Marathon', nameEn: 'The Legend of Marathon'),
  ChapterData(number: 28, name: 'All about Money', nameEn: 'All about Money'),
  ChapterData(number: 29, name: 'A Lark', nameEn: 'A Lark'),
  ChapterData(number: 30, name: 'Be a Netizen', nameEn: 'Be a Netizen'),
  ChapterData(number: 31, name: 'Give your Mind a Workout', nameEn: 'Give your Mind a Workout'),
  ChapterData(number: 32, name: 'Helen Keller', nameEn: 'Helen Keller'),
  ChapterData(number: 33, name: 'Rangoli', nameEn: 'Rangoli'),
  ChapterData(number: 34, name: 'Language Study', nameEn: 'Language Study'),
];

// ---------------------------------------------------------------------------
// Environmental Studies Part 1 – 25 chapters
// ---------------------------------------------------------------------------
const List<ChapterData> _evsPart1ChaptersEnglish = [
  ChapterData(number: 1, name: 'Our Earth and Our Solar System', nameEn: 'Our Earth and Our Solar System'),
  ChapterData(number: 2, name: 'Motions of the Earth', nameEn: 'Motions of the Earth'),
  ChapterData(number: 3, name: 'The Earth and its Living World', nameEn: 'The Earth and its Living World'),
  ChapterData(number: 4, name: 'Environmental Balance', nameEn: 'Environmental Balance'),
  ChapterData(number: 5, name: 'Family Values', nameEn: 'Family Values'),
  ChapterData(number: 6, name: 'Rules Are for Everyone', nameEn: 'Rules Are for Everyone'),
  ChapterData(number: 7, name: 'Let us Solve our own Problems', nameEn: 'Let us Solve our own Problems'),
  ChapterData(number: 8, name: 'Public Facilities and My School', nameEn: 'Public Facilities and My School'),
  ChapterData(number: 9, name: 'Maps our Companions', nameEn: 'Maps our Companions'),
  ChapterData(number: 10, name: 'Getting to Know India', nameEn: 'Getting to Know India'),
  ChapterData(number: 11, name: 'Our Home and Environment', nameEn: 'Our Home and Environment'),
  ChapterData(number: 12, name: 'Food for All', nameEn: 'Food for All'),
  ChapterData(number: 13, name: 'Methods of Preserving Food', nameEn: 'Methods of Preserving Food'),
  ChapterData(number: 14, name: 'Transport', nameEn: 'Transport'),
  ChapterData(number: 15, name: 'Communication and Mass Media', nameEn: 'Communication and Mass Media'),
  ChapterData(number: 16, name: 'Water', nameEn: 'Water'),
  ChapterData(number: 17, name: 'Clothes our Necessity', nameEn: 'Clothes our Necessity'),
  ChapterData(number: 18, name: 'The Environment and Us', nameEn: 'The Environment and Us'),
  ChapterData(number: 19, name: 'Constituents of Food', nameEn: 'Constituents of Food'),
  ChapterData(number: 20, name: 'Our Emotional World', nameEn: 'Our Emotional World'),
  ChapterData(number: 21, name: 'Busy at Work our Internal Organs', nameEn: 'Busy at Work our Internal Organs'),
  ChapterData(number: 22, name: 'Growth and Personality Development', nameEn: 'Growth and Personality Development'),
  ChapterData(number: 23, name: 'Infectious Diseases and how to Prevent them', nameEn: 'Infectious Diseases and how to Prevent them'),
  ChapterData(number: 24, name: 'Substances Objects and Energy', nameEn: 'Substances Objects and Energy'),
  ChapterData(number: 25, name: 'Community Health and Hygiene', nameEn: 'Community Health and Hygiene'),
];

// ---------------------------------------------------------------------------
// Environmental Studies Part 2 – 10 chapters
// ---------------------------------------------------------------------------
const List<ChapterData> _evsPart2ChaptersEnglish = [
  ChapterData(number: 1, name: 'What is History', nameEn: 'What is History'),
  ChapterData(number: 2, name: 'History and the Concept of Time', nameEn: 'History and the Concept of Time'),
  ChapterData(number: 3, name: 'Life on Earth', nameEn: 'Life on Earth'),
  ChapterData(number: 4, name: 'Evolution', nameEn: 'Evolution'),
  ChapterData(number: 5, name: 'Evolution of Mankind', nameEn: 'Evolution of Mankind'),
  ChapterData(number: 6, name: 'Stone Age Stone Tools', nameEn: 'Stone Age Stone Tools'),
  ChapterData(number: 7, name: 'From Shelters to Village-settlements', nameEn: 'From Shelters to Village-settlements'),
  ChapterData(number: 8, name: 'Beginning of Settled Life', nameEn: 'Beginning of Settled Life'),
  ChapterData(number: 9, name: 'Settled Life and Urban Civilization', nameEn: 'Settled Life and Urban Civilization'),
  ChapterData(number: 10, name: 'Historic Period', nameEn: 'Historic Period'),
];

// ---------------------------------------------------------------------------
// Play Do Learn – 17 chapters
// ---------------------------------------------------------------------------
const List<ChapterData> _playDoLearnChapters = [
  ChapterData(number: 1, name: 'Health', nameEn: 'Health'),
  ChapterData(number: 2, name: 'Various Movements', nameEn: 'Various Movements'),
  ChapterData(number: 3, name: 'Skill-based Activities', nameEn: 'Skill-based Activities'),
  ChapterData(number: 4, name: 'Various Games', nameEn: 'Various Games'),
  ChapterData(number: 5, name: 'Exercises', nameEn: 'Exercises'),
  ChapterData(number: 6, name: 'Need-based Activities', nameEn: 'Need-based Activities'),
  ChapterData(number: 7, name: 'Activities of Interest', nameEn: 'Activities of Interest'),
  ChapterData(number: 8, name: 'Skill-based Activities Do', nameEn: 'Skill-based Activities Do'),
  ChapterData(number: 9, name: 'Productive Fields of Work', nameEn: 'Productive Fields of Work'),
  ChapterData(number: 10, name: 'Other Areas', nameEn: 'Other Areas'),
  ChapterData(number: 11, name: 'Picture', nameEn: 'Picture'),
  ChapterData(number: 12, name: 'Sculpture', nameEn: 'Sculpture'),
  ChapterData(number: 13, name: 'Singing', nameEn: 'Singing'),
  ChapterData(number: 14, name: 'Instrumental Music', nameEn: 'Instrumental Music'),
  ChapterData(number: 15, name: 'Dance', nameEn: 'Dance'),
  ChapterData(number: 16, name: 'Drama', nameEn: 'Drama'),
  ChapterData(number: 17, name: 'My Action', nameEn: 'My Action'),
];

// ---------------------------------------------------------------------------
// ગુજરાતી સાહિત્ય પરિચય – 17 chapters
// ---------------------------------------------------------------------------
const List<ChapterData> _gujaratiSahityaChapters = [
  ChapterData(number: 1, name: 'વિવિધ મરોડ \u2013 મૂળાક્ષરો', nameEn: ''),
  ChapterData(number: 2, name: 'બારાખડી', nameEn: ''),
  ChapterData(number: 3, name: 'અંકલેખન', nameEn: ''),
  ChapterData(number: 4, name: 'પ્રાર્થના', nameEn: ''),
  ChapterData(number: 5, name: 'તેજુ \u2013 નીલનો પુકુ', nameEn: ''),
  ChapterData(number: 6, name: 'વિરામચિહ્નો', nameEn: ''),
  ChapterData(number: 7, name: 'કરો રમકડાં કૂચકદમ', nameEn: ''),
  ChapterData(number: 8, name: 'બિરબલની ચતુરાઈ', nameEn: ''),
  ChapterData(number: 9, name: 'વચન \u2013 જાતિ', nameEn: ''),
  ChapterData(number: 10, name: 'ઊંટ કહે', nameEn: ''),
  ChapterData(number: 11, name: 'ધન્ય છે ગંગાને!', nameEn: ''),
  ChapterData(number: 12, name: 'પત્રલેખન', nameEn: ''),
  ChapterData(number: 13, name: 'ઢોલીડા ઢોલ ધીમે વગાડ ના', nameEn: ''),
  ChapterData(number: 14, name: 'ચિત્રવાર્તા', nameEn: ''),
  ChapterData(number: 15, name: 'નામ \u2013 સર્વનામ', nameEn: ''),
  ChapterData(number: 16, name: 'મારું ગુજરાત', nameEn: ''),
  ChapterData(number: 17, name: 'સ્વર્ગની ચકલી', nameEn: ''),
];

// ---------------------------------------------------------------------------
// ಕನ್ನಡ ಸುಗಮಭಾರತಿ – 28 chapters
// ---------------------------------------------------------------------------
const List<ChapterData> _kannadaSugambharatiChapters = [
  ChapterData(number: 1, name: 'ತಾಲೆಗೆ ಹೋಗೋಣ', nameEn: ''),
  ChapterData(number: 2, name: 'ಏರಿಸೋಣ ಬಾವುಟ', nameEn: ''),
  ChapterData(number: 3, name: 'ಜಾಣದ ಕಾಗೆ', nameEn: ''),
  ChapterData(number: 4, name: 'ಕಾಮಗಲ್ಲ ಮನಮುಟ್ಟ', nameEn: ''),
  ChapterData(number: 5, name: 'ಅಕ್ಷರಗಳ ಅವಯವಗಳು', nameEn: ''),
  ChapterData(number: 6, name: 'ಕನ್ನಡ ವರ್ಣಮಾಲೆ', nameEn: ''),
  ChapterData(number: 7, name: 'ಅಜಯ', nameEn: ''),
  ChapterData(number: 8, name: 'ಕಶ', nameEn: ''),
  ChapterData(number: 9, name: 'ದಳ', nameEn: ''),
  ChapterData(number: 10, name: 'ವಿಷಯ', nameEn: ''),
  ChapterData(number: 11, name: 'ಊಟ', nameEn: ''),
  ChapterData(number: 12, name: 'ಓದಿರಿ ಬರೆಯಿರಿ (1)', nameEn: ''),
  ChapterData(number: 13, name: 'ಓದಿರಿ ಬರೆಯಿರಿ (2)', nameEn: ''),
  ChapterData(number: 14, name: 'ಓದಿರಿ ಬರೆಯಿರಿ (3)', nameEn: ''),
  ChapterData(number: 15, name: 'ಗುಣಿತಾಕ್ಷರಗಳ ಪರಿಚಯ', nameEn: ''),
  ChapterData(number: 16, name: 'ಮನೆ', nameEn: ''),
  ChapterData(number: 17, name: 'ಕಸುಬುಗಾರರು', nameEn: ''),
  ChapterData(number: 18, name: 'ನಮ್ಮ ಶಾಲೆ (ಕವಿತೆ)', nameEn: ''),
  ChapterData(number: 19, name: 'ಓದಿರಿ ಬರೆಯಿರಿ (4)', nameEn: ''),
  ChapterData(number: 20, name: 'ಓದಿರಿ ಬರೆಯಿರಿ (5)', nameEn: ''),
  ChapterData(number: 21, name: 'ಓದಿರಿ ಬರೆಯಿರಿ (6)', nameEn: ''),
  ChapterData(number: 22, name: 'ಒತ್ತಕ್ಷರಗಳ ಪರಿಚಯ', nameEn: ''),
  ChapterData(number: 23, name: 'ಓದಿರಿ ಬರೆಯಿರಿ (7)', nameEn: ''),
  ChapterData(number: 24, name: 'ಓದಿರಿ ಬರೆಯಿರಿ (8)', nameEn: ''),
  ChapterData(number: 25, name: 'ಓದಿರಿ ಬರೆಯಿರಿ (9)', nameEn: ''),
  ChapterData(number: 26, name: 'ದೀಪಾವಳಿ (ಕವಿತೆ)', nameEn: ''),
  ChapterData(number: 27, name: 'ಕೃಷ್ಣ \u2013 ಸುಧಾಮ', nameEn: ''),
  ChapterData(number: 28, name: 'ಪರಿಸರ ಕಲಿಸುವ ಪಾಠ (ಕವಿತೆ)', nameEn: ''),
];

// ---------------------------------------------------------------------------
// తెలుగు సరళ భారతి – 22 chapters
// ---------------------------------------------------------------------------
const List<ChapterData> _teluguSaralBharatiChapters = [
  ChapterData(number: 1, name: 'భావి సేనానులం', nameEn: ''),
  ChapterData(number: 2, name: 'విందయము (పద్యములు)', nameEn: ''),
  ChapterData(number: 3, name: 'వాక్యములం పాట', nameEn: ''),
  ChapterData(number: 4, name: 'అమ్మయ', nameEn: ''),
  ChapterData(number: 5, name: 'అంకెల పాట', nameEn: ''),
  ChapterData(number: 6, name: 'హల్లులు', nameEn: ''),
  ChapterData(number: 7, name: 'బళ్ళమానా', nameEn: ''),
  ChapterData(number: 8, name: 'తెలుగువాడినౌ! వావ్!', nameEn: ''),
  ChapterData(number: 9, name: 'పద బేరాలం', nameEn: ''),
  ChapterData(number: 10, name: 'గొంతీరం - భాగం 1', nameEn: ''),
  ChapterData(number: 11, name: 'కథలు', nameEn: ''),
  ChapterData(number: 12, name: 'గొంతీరం - భాగం 2', nameEn: ''),
  ChapterData(number: 13, name: 'రాజసూయాగా', nameEn: ''),
  ChapterData(number: 14, name: 'విద్యాప్రాశస్త్రాలు - భాగం 1', nameEn: ''),
  ChapterData(number: 15, name: 'కొండరాయలు లోయము', nameEn: ''),
  ChapterData(number: 16, name: 'విద్యాప్రాశస్త్రాలు - భాగం 2', nameEn: ''),
  ChapterData(number: 17, name: 'సామ్యుముఖ్యరాలు', nameEn: ''),
  ChapterData(number: 18, name: 'పేరు - పేరు (పద్యములు)', nameEn: ''),
  ChapterData(number: 19, name: 'డుయొం గోవిందా', nameEn: ''),
  ChapterData(number: 20, name: 'నేవారు ?', nameEn: ''),
  ChapterData(number: 21, name: 'ఇమ్ముడింపు మహారులం', nameEn: ''),
  ChapterData(number: 22, name: 'సుమతి !', nameEn: ''),
];

// ---------------------------------------------------------------------------
// सिंधू भारती – 20 chapters
// ---------------------------------------------------------------------------
const List<ChapterData> _sindhuBharatiChaptersEnglish = [
  ChapterData(number: 1, name: 'गीत', nameEn: ''),
  ChapterData(number: 2, name: 'हर्फ़', nameEn: ''),
  ChapterData(number: 3, name: 'आईंवेटा - सिंधी अखरनि ऐं अंगनि लाइ बुनियादी लीकूं', nameEn: ''),
  ChapterData(number: 4, name: '(अ) जी मात्रा वारा लफ़्ज़', nameEn: ''),
  ChapterData(number: 5, name: '(आ) जी मात्रा वारा लफ़्ज़', nameEn: ''),
  ChapterData(number: 6, name: '(इ) जी मात्रा वारा लफ़्ज़', nameEn: ''),
  ChapterData(number: 7, name: '(ई) जी मात्रा वारा लफ़्ज़', nameEn: ''),
  ChapterData(number: 8, name: '(उ) जी मात्रा वारा लफ़्ज़', nameEn: ''),
  ChapterData(number: 9, name: 'मात्राऊं', nameEn: ''),
  ChapterData(number: 10, name: 'अंग', nameEn: ''),
  ChapterData(number: 11, name: 'प्रार्थना (बैतु)', nameEn: ''),
  ChapterData(number: 12, name: 'मूरतुनि मां आखाणी', nameEn: ''),
  ChapterData(number: 13, name: 'बाग़ीचो', nameEn: ''),
  ChapterData(number: 14, name: 'कांउ ऐं कोइलि (बैतु)', nameEn: ''),
  ChapterData(number: 15, name: 'महिना ऐं ख़ासि ड्रींहं', nameEn: ''),
  ChapterData(number: 16, name: 'डियारी', nameEn: ''),
  ChapterData(number: 17, name: 'वाह डे तारा (बैतु)', nameEn: ''),
  ChapterData(number: 18, name: 'हम्दर्दी', nameEn: ''),
  ChapterData(number: 19, name: 'ख़तु', nameEn: ''),
  ChapterData(number: 20, name: 'ब्रालु सिपाही', nameEn: ''),
];

// ---------------------------------------------------------------------------
// تعارفِ اُردو – 23 chapters
// ---------------------------------------------------------------------------
const List<ChapterData> _taarufeUrduChapters = [
  ChapterData(number: 1, name: 'حروفِ تہجی - سبق ١', nameEn: ''),
  ChapterData(number: 2, name: 'حروفِ تہجی - سبق ٢', nameEn: ''),
  ChapterData(number: 3, name: 'حروفِ تہجی - سبق ٣', nameEn: ''),
  ChapterData(number: 4, name: 'حروفِ تہجی - سبق ٤', nameEn: ''),
  ChapterData(number: 5, name: 'حروفِ تہجی - سبق ٥', nameEn: ''),
  ChapterData(number: 6, name: 'حروفِ تہجی - سبق ٦', nameEn: ''),
  ChapterData(number: 7, name: 'حروفِ تہجی - سبق ٧', nameEn: ''),
  ChapterData(number: 8, name: 'حروفِ تہجی - سبق ٨', nameEn: ''),
  ChapterData(number: 9, name: 'حروفِ تہجی - سبق ٩', nameEn: ''),
  ChapterData(number: 10, name: 'حروفِ تہجی - سبق ١٠', nameEn: ''),
  ChapterData(number: 11, name: 'نانی کا گاؤں', nameEn: ''),
  ChapterData(number: 12, name: 'ابا آئے', nameEn: ''),
  ChapterData(number: 13, name: 'بہار سنجے', nameEn: ''),
  ChapterData(number: 14, name: 'پیاری کیاری', nameEn: ''),
  ChapterData(number: 15, name: 'حروف کی جوڑ شکلیں', nameEn: ''),
  ChapterData(number: 16, name: 'آؤ دعا مانگیں', nameEn: ''),
  ChapterData(number: 17, name: 'بی بی فاطمہؓ', nameEn: ''),
  ChapterData(number: 18, name: 'خوددار لکڑ ہارا', nameEn: ''),
  ChapterData(number: 19, name: 'آہا آہا نکلا چاند', nameEn: ''),
  ChapterData(number: 20, name: 'مکالمہ', nameEn: ''),
  ChapterData(number: 21, name: 'ہماری ریل', nameEn: ''),
  ChapterData(number: 22, name: 'شیخ چلّی', nameEn: ''),
  ChapterData(number: 23, name: 'بچّوں کا ترانہ', nameEn: ''),
];
