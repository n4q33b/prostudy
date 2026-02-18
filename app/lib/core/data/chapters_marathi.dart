import '../models/chapter_data.dart';
import 'chapters_common.dart';

// =============================================================================
// Marathi Medium — Class 5 chapter data (9 subjects)
// =============================================================================

const Map<String, List<ChapterData>> marathiChapters = {
  'गणित': _mathChapters,
  'बालभारती': _balbharatiChapters,
  'सुलभभारती': hindiSulabhbharatiChapters,
  'सुगमभारती': hindiSugambharatiChapters,
  'माय इंग्लिश': _myEnglishChapters,
  'सिंधुभारती': _sindhubharatiChapters,
  'परिसर अभ्यास भाग-१': _evsPart1Chapters,
  'परिसर अभ्यास भाग-२': _evsPart2Chapters,
  'खेळू, करू, शिकू': _kheluKaruShikuChapters,
};

// ---------------------------------------------------------------------------
// गणित (Mathematics) — 16 chapters
// Source: textbooks/class 5/Marathi/गणित/chapters.csv
// ---------------------------------------------------------------------------
const List<ChapterData> _mathChapters = [
  ChapterData(number: 1, name: 'रोमन संख्याचिन्हे', nameEn: 'Roman Numerals'),
  ChapterData(number: 2, name: 'संख्याज्ञान', nameEn: 'Number Work'),
  ChapterData(number: 3, name: 'बेरीज व वजाबाकी', nameEn: 'Addition and Subtraction'),
  ChapterData(number: 4, name: 'गुणाकार व भागाकार', nameEn: 'Multiplication and Division'),
  ChapterData(number: 5, name: 'अपूर्णांक', nameEn: 'Fractions'),
  ChapterData(number: 6, name: 'कोन', nameEn: 'Angles'),
  ChapterData(number: 7, name: 'वर्तुळ', nameEn: 'Circles'),
  ChapterData(number: 8, name: 'विभाज्य आणि विभाजक', nameEn: 'Divisibility and Factors'),
  ChapterData(number: 9, name: 'दशांश अपूर्णांक', nameEn: 'Decimal Fractions'),
  ChapterData(number: 10, name: 'कालमापन', nameEn: 'Measuring Time'),
  ChapterData(number: 11, name: 'मापनावरील उदाहरणे', nameEn: 'Problems on Measurement'),
  ChapterData(number: 12, name: 'परिमिती व क्षेत्रफळ', nameEn: 'Perimeter and Area'),
  ChapterData(number: 13, name: 'त्रिमितीय वस्तू व घडणी', nameEn: '3D Objects and Nets'),
  ChapterData(number: 14, name: 'चित्रालेख', nameEn: 'Bar Graphs'),
  ChapterData(number: 15, name: 'आकृतिबंध', nameEn: 'Patterns'),
  ChapterData(number: 16, name: 'बीजगणिताची पूर्वतयारी', nameEn: 'Introduction to Algebra'),
];

// ---------------------------------------------------------------------------
// बालभारती — 28 chapters
// Source: textbooks/class 5/Marathi/बालभारती/chapters.csv
// ---------------------------------------------------------------------------
const List<ChapterData> _balbharatiChapters = [
  ChapterData(number: 1, name: 'माय मराठी', nameEn: ''),
  ChapterData(number: 2, name: 'बंडूची इजार', nameEn: ''),
  ChapterData(number: 3, name: 'वल्हवा रं वल्हवा', nameEn: ''),
  ChapterData(number: 4, name: 'सावरपाडा एक्स्प्रेस', nameEn: ''),
  ChapterData(number: 5, name: 'मुंग्यांच्या जगात', nameEn: ''),
  ChapterData(number: 6, name: 'माहेर', nameEn: ''),
  ChapterData(number: 7, name: 'अरण्यलिपी', nameEn: ''),
  ChapterData(number: 8, name: 'प्रिय बाई', nameEn: ''),
  ChapterData(number: 9, name: 'जनाई', nameEn: ''),
  ChapterData(number: 10, name: 'रंग जादूचे पेटीमधले', nameEn: ''),
  ChapterData(number: 11, name: 'कठीण समय येता', nameEn: ''),
  ChapterData(number: 12, name: 'माळीण गाव - एक घटना', nameEn: ''),
  ChapterData(number: 13, name: 'सण एक दिन', nameEn: ''),
  ChapterData(number: 14, name: 'राष्ट्रसंत तुकडोजीमहाराज', nameEn: ''),
  ChapterData(number: 15, name: 'आपल्या समस्या आपले उपाय', nameEn: ''),
  ChapterData(number: 16, name: 'स्वच्छतेचा प्रकाश', nameEn: ''),
  ChapterData(number: 17, name: 'पुस्तके', nameEn: ''),
  ChapterData(number: 18, name: 'कारागिरी', nameEn: ''),
  ChapterData(number: 19, name: 'वासरू', nameEn: ''),
  ChapterData(number: 20, name: 'माझं शाळेचं नक्की झालं', nameEn: ''),
  ChapterData(number: 21, name: 'वाचूया समजून घेऊया', nameEn: ''),
  ChapterData(number: 22, name: 'प्रश्न विचारा पुन्हा पुन्हा', nameEn: ''),
  ChapterData(number: 23, name: 'अति तिथं माती', nameEn: ''),
  ChapterData(number: 24, name: 'छत्रपती राजर्षी शाहूमहाराज', nameEn: ''),
  ChapterData(number: 25, name: 'कापणी', nameEn: ''),
  ChapterData(number: 26, name: 'ढोल', nameEn: ''),
  ChapterData(number: 27, name: 'पाण्याची गोष्ट', nameEn: ''),
  ChapterData(number: 28, name: 'अभंग', nameEn: ''),
];

// ---------------------------------------------------------------------------
// माय इंग्लिश (My English) — 7 chapters
// Source: textbooks/class 5/Marathi/माय इंग्लिश/chapters.csv
// ---------------------------------------------------------------------------
const List<ChapterData> _myEnglishChapters = [
  ChapterData(number: 1, name: 'Unit One - Revision', nameEn: 'Unit One - Revision'),
  ChapterData(number: 2, name: 'Unit Two', nameEn: 'Unit Two'),
  ChapterData(number: 3, name: 'Unit Three', nameEn: 'Unit Three'),
  ChapterData(number: 4, name: 'Unit Four', nameEn: 'Unit Four'),
  ChapterData(number: 5, name: 'Unit Five', nameEn: 'Unit Five'),
  ChapterData(number: 6, name: 'Unit Six', nameEn: 'Unit Six'),
  ChapterData(number: 7, name: 'NOW I KNOW', nameEn: 'NOW I KNOW'),
];

// ---------------------------------------------------------------------------
// सिंधुभारती — 20 chapters
// Source: textbooks/class 5/Marathi/सिंधुभारती/chapters.csv
// ---------------------------------------------------------------------------
const List<ChapterData> _sindhubharatiChapters = [
  ChapterData(number: 1, name: 'गीत', nameEn: ''),
  ChapterData(number: 2, name: 'हर्फ़', nameEn: ''),
  ChapterData(number: 3, name: 'आईवेटा', nameEn: ''),
  ChapterData(number: 4, name: '(अ) मात्रा', nameEn: ''),
  ChapterData(number: 5, name: '(आ) मात्रा', nameEn: ''),
  ChapterData(number: 6, name: '(इ) मात्रा', nameEn: ''),
  ChapterData(number: 7, name: '(ई) मात्रा', nameEn: ''),
  ChapterData(number: 8, name: '(उ) मात्रा', nameEn: ''),
  ChapterData(number: 9, name: 'मात्राऊं', nameEn: ''),
  ChapterData(number: 10, name: 'अंग', nameEn: ''),
  ChapterData(number: 11, name: 'प्रार्थना', nameEn: ''),
  ChapterData(number: 12, name: 'मूरतुनि मां आखाणी', nameEn: ''),
  ChapterData(number: 13, name: 'बागीचो', nameEn: ''),
  ChapterData(number: 14, name: 'कांउ एं कोइलि', nameEn: ''),
  ChapterData(number: 15, name: 'महिना एं ख़ासि डींहं', nameEn: ''),
  ChapterData(number: 16, name: 'डियारी', nameEn: ''),
  ChapterData(number: 17, name: 'वाह डे तारा', nameEn: ''),
  ChapterData(number: 18, name: 'हम्दर्दी', nameEn: ''),
  ChapterData(number: 19, name: 'ख़तु', nameEn: ''),
  ChapterData(number: 20, name: 'ब्रालु सिपाही', nameEn: ''),
];

// ---------------------------------------------------------------------------
// परिसर अभ्यास भाग-१ (EVS Part 1) — 25 chapters
// Source: textbooks/class 5/Marathi/परिसर अभ्यास भाग-१/chapters.csv
// ---------------------------------------------------------------------------
const List<ChapterData> _evsPart1Chapters = [
  ChapterData(number: 1, name: 'आपली पृथ्वी - आपली सूर्यमाला', nameEn: ''),
  ChapterData(number: 2, name: 'पृथ्वीचे फिरणे', nameEn: ''),
  ChapterData(number: 3, name: 'पृथ्वी आणि जीवसृष्टी', nameEn: ''),
  ChapterData(number: 4, name: 'पर्यावरणाचे संतुलन', nameEn: ''),
  ChapterData(number: 5, name: 'कुटुंबातील मूल्ये', nameEn: ''),
  ChapterData(number: 6, name: 'नियम सर्वांसाठी', nameEn: ''),
  ChapterData(number: 7, name: 'आपणच सोडवू आपले प्रश्न', nameEn: ''),
  ChapterData(number: 8, name: 'सार्वजनिक सुविधा आणि माझी शाळा', nameEn: ''),
  ChapterData(number: 9, name: 'नकाशा - आपला सोबती', nameEn: ''),
  ChapterData(number: 10, name: 'ओळख भारताची', nameEn: ''),
  ChapterData(number: 11, name: 'आपले घर व पर्यावरण', nameEn: ''),
  ChapterData(number: 12, name: 'सर्वांसाठी अन्न', nameEn: ''),
  ChapterData(number: 13, name: 'अन्न टिकवण्याच्या पद्धती', nameEn: ''),
  ChapterData(number: 14, name: 'वाहतूक', nameEn: ''),
  ChapterData(number: 15, name: 'संदेशवहन व प्रसार माध्यमे', nameEn: ''),
  ChapterData(number: 16, name: 'पाणी', nameEn: ''),
  ChapterData(number: 17, name: 'वस्त्र - आपली गरज', nameEn: ''),
  ChapterData(number: 18, name: 'पर्यावरण आणि आपण', nameEn: ''),
  ChapterData(number: 19, name: 'अन्नघटक', nameEn: ''),
  ChapterData(number: 20, name: 'आपले भावनिक जग', nameEn: ''),
  ChapterData(number: 21, name: 'कामांत व्यस्त आपली आंतरेंद्रिये', nameEn: ''),
  ChapterData(number: 22, name: 'वाढ आणि व्यक्तिमत्त्व विकास', nameEn: ''),
  ChapterData(number: 23, name: 'संसर्गजन्य रोग आणि रोगप्रतिबंध', nameEn: ''),
  ChapterData(number: 24, name: 'पदार्थ वस्तू आणि ऊर्जा', nameEn: ''),
  ChapterData(number: 25, name: 'सामाजिक आरोग्य', nameEn: ''),
];

// ---------------------------------------------------------------------------
// परिसर अभ्यास भाग-२ (EVS Part 2) — 10 chapters
// Source: textbooks/class 5/Marathi/परिसर अभ्यास भाग-२/chapters.csv
// ---------------------------------------------------------------------------
const List<ChapterData> _evsPart2Chapters = [
  ChapterData(number: 1, name: 'इतिहास म्हणजे काय', nameEn: ''),
  ChapterData(number: 2, name: 'इतिहास आणि कालसंकल्पना', nameEn: ''),
  ChapterData(number: 3, name: 'पृथ्वीवरील सजीव', nameEn: ''),
  ChapterData(number: 4, name: 'उत्क्रांती', nameEn: ''),
  ChapterData(number: 5, name: 'मानवाची वाटचाल', nameEn: ''),
  ChapterData(number: 6, name: 'अश्मयुग - दगडाची हत्यारे', nameEn: ''),
  ChapterData(number: 7, name: 'निवारा ते गाव-वसाहती', nameEn: ''),
  ChapterData(number: 8, name: 'स्थिर जीवनाची सुरुवात', nameEn: ''),
  ChapterData(number: 9, name: 'स्थिर जीवन आणि नागरी संस्कृती', nameEn: ''),
  ChapterData(number: 10, name: 'ऐतिहासिक काळ', nameEn: ''),
];

// ---------------------------------------------------------------------------
// खेळू, करू, शिकू (Play, Do, Learn) — 17 chapters
// Source: textbooks/class 5/Marathi/खेळू, करू, शिकू/chapters/ (folder listing)
// ---------------------------------------------------------------------------
const List<ChapterData> _kheluKaruShikuChapters = [
  ChapterData(number: 1, name: 'आरोग्य', nameEn: ''),
  ChapterData(number: 2, name: 'विविध हालचाली व योग्य शारीरिक स्थिती', nameEn: ''),
  ChapterData(number: 3, name: 'कौशल्यात्मक उपक्रम', nameEn: ''),
  ChapterData(number: 4, name: 'विविध खेळ', nameEn: ''),
  ChapterData(number: 5, name: 'व्यायाम', nameEn: ''),
  ChapterData(number: 6, name: 'गरजाधिष्ठित उपक्रम', nameEn: ''),
  ChapterData(number: 7, name: 'अभिरुचिपूरक उपक्रम', nameEn: ''),
  ChapterData(number: 8, name: 'कौशल्याधिष्ठित उपक्रम', nameEn: ''),
  ChapterData(number: 9, name: 'उत्पादक क्षेत्र', nameEn: ''),
  ChapterData(number: 10, name: 'इतर क्षेत्रे', nameEn: ''),
  ChapterData(number: 11, name: 'तंत्रज्ञान क्षेत्र', nameEn: ''),
  ChapterData(number: 12, name: 'चित्र', nameEn: ''),
  ChapterData(number: 13, name: 'शिल्प', nameEn: ''),
  ChapterData(number: 14, name: 'गायन', nameEn: ''),
  ChapterData(number: 15, name: 'वादन', nameEn: ''),
  ChapterData(number: 16, name: 'नृत्य', nameEn: ''),
  ChapterData(number: 17, name: 'नाट्य', nameEn: ''),
];
