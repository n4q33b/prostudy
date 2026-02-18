import '../models/chapter_data.dart';
import 'chapters_common.dart';

// =============================================================================
// Hindi Medium — Class 5 chapter data (8 subjects)
// =============================================================================

const Map<String, List<ChapterData>> hindiChapters = {
  'गणित': _mathChaptersHindi,
  'हिंदी बालभारती': _hindiBalbharatiChapters,
  'मराठी सुलभभारती': marathiSulabhbharatiChapters,
  'मराठी सुगमभारती': marathiSugambharatiChapters,
  'My English Book': _myEnglishChaptersHindi,
  'परिसर अध्ययन भाग-१': _evsPart1ChaptersHindi,
  'परिसर अध्ययन भाग-२': _evsPart2ChaptersHindi,
  'खेलें करें सीखें': _khelenKarenSikhenChapters,
};

// ---------------------------------------------------------------------------
// गणित (Mathematics) — 16 chapters
// Source: textbooks/class 5/Hindi/गणित/chapters.csv
// ---------------------------------------------------------------------------
const List<ChapterData> _mathChaptersHindi = [
  ChapterData(number: 1, name: 'रोमन संख्यांक', nameEn: 'Roman Numerals'),
  ChapterData(number: 2, name: 'संख्याज्ञान', nameEn: 'Number Work'),
  ChapterData(number: 3, name: 'जोड़ तथा घटाव', nameEn: 'Addition and Subtraction'),
  ChapterData(number: 4, name: 'गुणन और भाजन', nameEn: 'Multiplication and Division'),
  ChapterData(number: 5, name: 'भिन्न', nameEn: 'Fractions'),
  ChapterData(number: 6, name: 'कोण', nameEn: 'Angles'),
  ChapterData(number: 7, name: 'वृत्त', nameEn: 'Circles'),
  ChapterData(number: 8, name: 'विभाजक और विभाज्य', nameEn: 'Divisibility and Factors'),
  ChapterData(number: 9, name: 'दशमलव भिन्न', nameEn: 'Decimal Fractions'),
  ChapterData(number: 10, name: 'कालमापन', nameEn: 'Measuring Time'),
  ChapterData(number: 11, name: 'मापन पर आधारित प्रश्न', nameEn: 'Problems on Measurement'),
  ChapterData(number: 12, name: 'परिमिति और क्षेत्रफल', nameEn: 'Perimeter and Area'),
  ChapterData(number: 13, name: 'त्रिविम वस्तुएँ और रचनाएँ', nameEn: '3D Objects and Nets'),
  ChapterData(number: 14, name: 'चित्रालेख', nameEn: 'Bar Graphs'),
  ChapterData(number: 15, name: 'प्रतिरूप (आकृतिबंध)', nameEn: 'Patterns'),
  ChapterData(number: 16, name: 'बीजगणित की पूर्वतैयारी', nameEn: 'Introduction to Algebra'),
];

// ---------------------------------------------------------------------------
// हिंदी बालभारती — 45 chapters
// Source: textbooks/class 5/Hindi/हिंदी बालभारती/chapters.csv
// ---------------------------------------------------------------------------
const List<ChapterData> _hindiBalbharatiChapters = [
  ChapterData(number: 1, name: 'जन्मदिन', nameEn: ''),
  ChapterData(number: 2, name: 'प्राकृतिक दृश्य', nameEn: ''),
  ChapterData(number: 3, name: 'पथ मेरा आलोकित कर दो', nameEn: ''),
  ChapterData(number: 4, name: 'असली गहने', nameEn: ''),
  ChapterData(number: 5, name: 'कश्मिरा', nameEn: ''),
  ChapterData(number: 6, name: 'बात से बात', nameEn: ''),
  ChapterData(number: 7, name: 'मेरा बचपन', nameEn: ''),
  ChapterData(number: 8, name: 'शुभकामना कार्ड', nameEn: ''),
  ChapterData(number: 9, name: 'अपनापन', nameEn: ''),
  ChapterData(number: 10, name: 'अक्षरमाला', nameEn: ''),
  ChapterData(number: 11, name: 'दिमाग चलाओ', nameEn: ''),
  ChapterData(number: 12, name: 'नाम हमारे', nameEn: ''),
  ChapterData(number: 13, name: 'संबोधन तुम्हारे', nameEn: ''),
  ChapterData(number: 14, name: 'अनोखा यात्री', nameEn: ''),
  ChapterData(number: 15, name: 'पंच परमेश्वर', nameEn: ''),
  ChapterData(number: 16, name: 'बूझो तो जानें', nameEn: ''),
  ChapterData(number: 17, name: 'कला का सम्मान', nameEn: ''),
  ChapterData(number: 18, name: 'कूड़ा-करकट से बिजली', nameEn: ''),
  ChapterData(number: 19, name: 'नाट्यकला', nameEn: ''),
  ChapterData(number: 20, name: 'पुनरावर्तन-1', nameEn: ''),
  ChapterData(number: 21, name: 'पुनरावर्तन-2', nameEn: ''),
  ChapterData(number: 22, name: 'निसर्ग खेल', nameEn: ''),
  ChapterData(number: 23, name: 'संगणक', nameEn: ''),
  ChapterData(number: 24, name: 'रिश्ता-नाता', nameEn: ''),
  ChapterData(number: 25, name: 'बुद्धिमान मेमना', nameEn: ''),
  ChapterData(number: 26, name: 'क्या तुम जानते हो', nameEn: ''),
  ChapterData(number: 27, name: 'खूब पढ़ो खूब खेलो', nameEn: ''),
  ChapterData(number: 28, name: 'दिलों को जोड़ना जरूरी', nameEn: ''),
  ChapterData(number: 29, name: 'आओ आयु बताना सीखें', nameEn: ''),
  ChapterData(number: 30, name: 'ताले की कुंजी', nameEn: ''),
  ChapterData(number: 31, name: 'हम ऐसे बने', nameEn: ''),
  ChapterData(number: 32, name: 'हमसे नाम बनाओ', nameEn: ''),
  ChapterData(number: 33, name: 'विशेषता हमारी', nameEn: ''),
  ChapterData(number: 34, name: 'कार्य हमारा', nameEn: ''),
  ChapterData(number: 35, name: 'गुनगुनाते चलो', nameEn: ''),
  ChapterData(number: 36, name: 'अद्भुत वीरांगना', nameEn: ''),
  ChapterData(number: 37, name: 'साइकिल', nameEn: ''),
  ChapterData(number: 38, name: 'महाराष्ट्र दिवस', nameEn: ''),
  ChapterData(number: 39, name: 'खज्जियार-भारत का स्विट्जरलैंड', nameEn: ''),
  ChapterData(number: 40, name: 'स्काउट-गाइड', nameEn: ''),
  ChapterData(number: 41, name: 'पुनरावर्तन-3', nameEn: ''),
  ChapterData(number: 42, name: 'पुनरावर्तन-4', nameEn: ''),
  ChapterData(number: 43, name: 'चित्रकथा', nameEn: ''),
  ChapterData(number: 44, name: 'शब्दार्थ', nameEn: ''),
  ChapterData(number: 45, name: 'मुहावरे-कहावतें उत्तर', nameEn: ''),
];

// ---------------------------------------------------------------------------
// My English Book — 7 chapters
// Source: textbooks/class 5/Hindi/My English Book/chapters.csv
// ---------------------------------------------------------------------------
const List<ChapterData> _myEnglishChaptersHindi = [
  ChapterData(number: 1, name: 'Unit One - Revision', nameEn: 'Unit One - Revision'),
  ChapterData(number: 2, name: 'Unit Two', nameEn: 'Unit Two'),
  ChapterData(number: 3, name: 'Unit Three', nameEn: 'Unit Three'),
  ChapterData(number: 4, name: 'Unit Four', nameEn: 'Unit Four'),
  ChapterData(number: 5, name: 'Unit Five', nameEn: 'Unit Five'),
  ChapterData(number: 6, name: 'Unit Six', nameEn: 'Unit Six'),
  ChapterData(number: 7, name: 'NOW I KNOW', nameEn: 'NOW I KNOW'),
];

// ---------------------------------------------------------------------------
// परिसर अध्ययन भाग-१ (EVS Part 1) — 25 chapters
// Source: textbooks/class 5/Hindi/परिसर अध्ययन भाग-१/chapters.csv
// ---------------------------------------------------------------------------
const List<ChapterData> _evsPart1ChaptersHindi = [
  ChapterData(number: 1, name: 'हमारी पृथ्वी-हमारा सौरमंडल', nameEn: ''),
  ChapterData(number: 2, name: 'पृथ्वी का घूमना', nameEn: ''),
  ChapterData(number: 3, name: 'पृथ्वी और सजीव सृष्टि', nameEn: ''),
  ChapterData(number: 4, name: 'पर्यावरण का संतुलन', nameEn: ''),
  ChapterData(number: 5, name: 'पारिवारिक मूल्य', nameEn: ''),
  ChapterData(number: 6, name: 'नियम सबके लिए', nameEn: ''),
  ChapterData(number: 7, name: 'हम ही हल करें अपनी समस्याएँ', nameEn: ''),
  ChapterData(number: 8, name: 'सार्वजनिक सुविधाएँ और हमारा विद्यालय', nameEn: ''),
  ChapterData(number: 9, name: 'मानचित्र हमारा साथी', nameEn: ''),
  ChapterData(number: 10, name: 'भारत की पहचान', nameEn: ''),
  ChapterData(number: 11, name: 'हमारा घर तथा पर्यावरण', nameEn: ''),
  ChapterData(number: 12, name: 'सबके लिए भोजन', nameEn: ''),
  ChapterData(number: 13, name: 'खाद्यपदार्थों को सुरक्षित रखने की विधियाँ', nameEn: ''),
  ChapterData(number: 14, name: 'परिवहन', nameEn: ''),
  ChapterData(number: 15, name: 'संचार तथा प्रसार माध्यम', nameEn: ''),
  ChapterData(number: 16, name: 'पानी', nameEn: ''),
  ChapterData(number: 17, name: 'वस्त्र - हमारी आवश्यकता', nameEn: ''),
  ChapterData(number: 18, name: 'पर्यावरण और हम', nameEn: ''),
  ChapterData(number: 19, name: 'भोजन के घटक', nameEn: ''),
  ChapterData(number: 20, name: 'हमारा भावनात्मक जगत', nameEn: ''),
  ChapterData(number: 21, name: 'कामों में व्यस्त हमारे आंतरिक अंग', nameEn: ''),
  ChapterData(number: 22, name: 'वृद्धि और व्यक्तित्व का विकास', nameEn: ''),
  ChapterData(number: 23, name: 'संक्रामक रोग और रोग प्रतिबंधन', nameEn: ''),
  ChapterData(number: 24, name: 'पदार्थ वस्तु और ऊर्जा', nameEn: ''),
  ChapterData(number: 25, name: 'सामुदायिक स्वास्थ्य', nameEn: ''),
];

// ---------------------------------------------------------------------------
// परिसर अध्ययन भाग-२ (EVS Part 2) — 10 chapters
// Source: textbooks/class 5/Hindi/परिसर अध्ययन भाग-२/chapters.csv
// ---------------------------------------------------------------------------
const List<ChapterData> _evsPart2ChaptersHindi = [
  ChapterData(number: 1, name: 'इतिहास किसे कहते हैं', nameEn: ''),
  ChapterData(number: 2, name: 'इतिहास और कालखंड की संकल्पना', nameEn: ''),
  ChapterData(number: 3, name: 'पृथ्वी पर सजीव', nameEn: ''),
  ChapterData(number: 4, name: 'विकासवाद', nameEn: ''),
  ChapterData(number: 5, name: 'मानव की उन्नति', nameEn: ''),
  ChapterData(number: 6, name: 'अश्मयुग - पत्थर के हथियार', nameEn: ''),
  ChapterData(number: 7, name: 'आवास से लेकर गाँव - बस्ती तक', nameEn: ''),
  ChapterData(number: 8, name: 'स्थायी जीवन का प्रारंभ', nameEn: ''),
  ChapterData(number: 9, name: 'स्थायी जीवन और नगरीय संस्कृति', nameEn: ''),
  ChapterData(number: 10, name: 'ऐतिहासिक कालखंड', nameEn: ''),
];

// ---------------------------------------------------------------------------
// खेलें करें सीखें (Play, Do, Learn) — 17 chapters
// Source: textbooks/class 5/Hindi/खेलें करें सीखें/chapters.csv
// ---------------------------------------------------------------------------
const List<ChapterData> _khelenKarenSikhenChapters = [
  ChapterData(number: 1, name: 'स्वास्थ्य', nameEn: ''),
  ChapterData(number: 2, name: 'विभिन्न गतिविधियाँ', nameEn: ''),
  ChapterData(number: 3, name: 'कौशलों पर आधारित उपक्रम', nameEn: ''),
  ChapterData(number: 4, name: 'विभिन्न खेल', nameEn: ''),
  ChapterData(number: 5, name: 'व्यायाम', nameEn: ''),
  ChapterData(number: 6, name: 'अनिवार्य उपक्रम - आवश्यकता पर आधारित उपक्रम', nameEn: ''),
  ChapterData(number: 7, name: 'अभिरुचिपूरक उपक्रम', nameEn: ''),
  ChapterData(number: 8, name: 'ऐच्छिक उपक्रम - उत्पादक क्षेत्र', nameEn: ''),
  ChapterData(number: 9, name: 'ऐच्छिक उपक्रम - अन्य क्षेत्र', nameEn: ''),
  ChapterData(number: 10, name: 'प्रौद्योगिकी क्षेत्र यातायात सुरक्षा', nameEn: ''),
  ChapterData(number: 11, name: 'चित्र', nameEn: ''),
  ChapterData(number: 12, name: 'शिल्प', nameEn: ''),
  ChapterData(number: 13, name: 'गायन', nameEn: ''),
  ChapterData(number: 14, name: 'वादन', nameEn: ''),
  ChapterData(number: 15, name: 'नृत्य', nameEn: ''),
  ChapterData(number: 16, name: 'नाट्य', nameEn: ''),
  ChapterData(number: 17, name: 'अतिरिक्त सामग्री', nameEn: ''),
];
