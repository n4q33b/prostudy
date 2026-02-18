import '../models/chapter_data.dart';
import 'chapters_common.dart';

// ---------------------------------------------------------------------------
// Telugu medium – Class 5 chapter data
// ---------------------------------------------------------------------------

const Map<String, List<ChapterData>> teluguChapters = {
  'గణితశాస్త్రం': _mathChaptersTelugu,
  'తెలుగు బాలభారతి': _teluguBalbharatiChapters,
  'हिंदी सुलभभारती': hindiSulabhbharatiChapters,
  'हिंदी सुगमभारती': hindiSugambharatiChapters,
  'मराठी सुलभभारती': marathiSulabhbharatiChapters,
  'मराठी सुगमभारती': marathiSugambharatiChapters,
  'My English Book': _myEnglishChaptersTelugu,
  'పరిసరాల అధ్యయనం భాగం-౧': _evsPart1ChaptersTelugu,
  'పరిసరాల అధ్యయనం భాగం-౨': _evsPart2ChaptersTelugu,
  'ఆడుదాం చేద్దాం నేర్చుకొందాం': _adudamChaptersTelugu,
};

// -- గణితశాస్త్రం (Math) – 16 chapters ----------------------------------------
const List<ChapterData> _mathChaptersTelugu = [
  ChapterData(number: 1, name: 'రోమన్ సంఖ్యా చిహ్నాలు', nameEn: ''),
  ChapterData(number: 2, name: 'సంఖ్యా జ్ఞానం', nameEn: ''),
  ChapterData(number: 3, name: 'కూడిక మరియు తీసివేత', nameEn: ''),
  ChapterData(number: 4, name: 'గుణకారం మరియు భాగహారం', nameEn: ''),
  ChapterData(number: 5, name: 'భిన్నాలు', nameEn: ''),
  ChapterData(number: 6, name: 'కోణం', nameEn: ''),
  ChapterData(number: 7, name: 'వృత్తం', nameEn: ''),
  ChapterData(number: 8, name: 'భాజ్యం మరియు భాజకం', nameEn: ''),
  ChapterData(number: 9, name: 'దశాంశభిన్నాలు', nameEn: ''),
  ChapterData(number: 10, name: 'కాలమానం', nameEn: ''),
  ChapterData(number: 11, name: 'కొంతలపై ఉదాహరణలు', nameEn: ''),
  ChapterData(number: 12, name: 'చుట్టు కొలత మరియు వైశాల్యం', nameEn: ''),
  ChapterData(number: 13, name: 'త్రిమితీయ వస్తువులు మరియు తేహాకృతులు', nameEn: ''),
  ChapterData(number: 14, name: 'ఏత్రలేపి', nameEn: ''),
  ChapterData(number: 15, name: 'చెడ్డాకృతులు', nameEn: ''),
  ChapterData(number: 16, name: 'బీజ గణితానికి పూర్వసంసిద్దత', nameEn: ''),
];

// -- తెలుగు బాలభారతి – 29 chapters -------------------------------------------
const List<ChapterData> _teluguBalbharatiChapters = [
  ChapterData(number: 1, name: 'దేశమును ప్రేమించుమన్నా', nameEn: ''),
  ChapterData(number: 2, name: 'ఏకాగ్రత', nameEn: ''),
  ChapterData(number: 3, name: 'విలువిద్యలో మేటి', nameEn: ''),
  ChapterData(number: 4, name: 'అనకు కనకు వినకు', nameEn: ''),
  ChapterData(number: 5, name: 'కాకమ్మ సందేశం', nameEn: ''),
  ChapterData(number: 6, name: 'అక్బర్-బీర్బల్ కథలు', nameEn: ''),
  ChapterData(number: 7, name: 'మదర్ థెరీసా', nameEn: ''),
  ChapterData(number: 8, name: 'రైలు నియమాలను పాటిద్దాం', nameEn: ''),
  ChapterData(number: 9, name: 'ఈగ-సాలీడు', nameEn: ''),
  ChapterData(number: 10, name: 'జాబు', nameEn: ''),
  ChapterData(number: 11, name: 'జవాబు', nameEn: ''),
  ChapterData(number: 12, name: 'నీరు-పేరు', nameEn: ''),
  ChapterData(number: 13, name: 'ట్రింగ్-ట్రింగ్', nameEn: ''),
  ChapterData(number: 14, name: 'తపాలా కార్యాలయం', nameEn: ''),
  ChapterData(number: 15, name: 'భీమ-సంఘటనవి', nameEn: ''),
  ChapterData(number: 16, name: 'ఆటలు ప్రాముఖ్యత', nameEn: ''),
  ChapterData(number: 17, name: 'చీకటిని ఛేదించిన క్రీడాకారుడు', nameEn: ''),
  ChapterData(number: 18, name: 'ఆరోగ్యం-పరిశుభ్రత', nameEn: ''),
  ChapterData(number: 19, name: 'పస్తారోపణ', nameEn: ''),
  ChapterData(number: 20, name: 'శతకపద్యాలు', nameEn: ''),
  ChapterData(number: 21, name: 'స్ఫూర్తి', nameEn: ''),
  ChapterData(number: 22, name: 'సంతృప్తి', nameEn: ''),
  ChapterData(number: 23, name: 'ఉగాది', nameEn: ''),
  ChapterData(number: 24, name: 'ఆంధ్రకేసరి', nameEn: ''),
  ChapterData(number: 25, name: 'కూరగాయల సలాడ్ తయారు చేద్దామా', nameEn: ''),
  ChapterData(number: 26, name: 'ఐకమత్యమే మహాబలం', nameEn: ''),
  ChapterData(number: 27, name: 'చెప్పుకో చూద్దాం', nameEn: ''),
  ChapterData(number: 28, name: 'లఘు నిఘంటువు', nameEn: ''),
  ChapterData(number: 29, name: 'వ్యాకరణము', nameEn: ''),
];

// -- My English Book – 6 chapters ---------------------------------------------
const List<ChapterData> _myEnglishChaptersTelugu = [
  ChapterData(number: 1, name: 'Unit One Revision', nameEn: ''),
  ChapterData(number: 2, name: 'Unit Two', nameEn: ''),
  ChapterData(number: 3, name: 'Unit Three', nameEn: ''),
  ChapterData(number: 4, name: 'Unit Four', nameEn: ''),
  ChapterData(number: 5, name: 'Unit Five', nameEn: ''),
  ChapterData(number: 6, name: 'Unit Six', nameEn: ''),
];

// -- పరిసరాల అధ్యయనం భాగం-౧ (EVS Part 1) – 25 chapters ----------------------
const List<ChapterData> _evsPart1ChaptersTelugu = [
  ChapterData(number: 1, name: 'మన భూమి \u2013 మన సౌరకుటుంబం', nameEn: ''),
  ChapterData(number: 2, name: 'భూమి తిరుగుట', nameEn: ''),
  ChapterData(number: 3, name: 'భూమి మరియు జీవస్సృష్టి', nameEn: ''),
  ChapterData(number: 4, name: 'పర్యావరణ సమతుల్యం', nameEn: ''),
  ChapterData(number: 5, name: 'కుటుంబంలోని విలువలు', nameEn: ''),
  ChapterData(number: 6, name: 'నియమాలు అందరికోసం', nameEn: ''),
  ChapterData(number: 7, name: 'మన సమస్యలను మనమే పరిష్కరించుకుందాం', nameEn: ''),
  ChapterData(number: 8, name: 'సార్వజనిక సౌకర్యాలు మరియు నా పాఠశాల', nameEn: ''),
  ChapterData(number: 9, name: 'మాసచిత్రపటం మన మిత్రుడు', nameEn: ''),
  ChapterData(number: 10, name: 'భారతదేశ పరిచయం', nameEn: ''),
  ChapterData(number: 11, name: 'మన ఇల్లు మరియు పర్యావరణం', nameEn: ''),
  ChapterData(number: 12, name: 'అందరికోసం ఆహారం', nameEn: ''),
  ChapterData(number: 13, name: 'ఆహారం భద్రపరచు పద్దతులు', nameEn: ''),
  ChapterData(number: 14, name: 'రవాణా', nameEn: ''),
  ChapterData(number: 15, name: 'సమాచార ప్రసారం మరియు ప్రసార మాధ్యమాలు', nameEn: ''),
  ChapterData(number: 16, name: 'నీరు', nameEn: ''),
  ChapterData(number: 17, name: 'వస్తాలు-మన అవసరం', nameEn: ''),
  ChapterData(number: 18, name: 'పర్యావరణం మరియు మనం', nameEn: ''),
  ChapterData(number: 19, name: 'ఆహారంలోని పోషణాలు', nameEn: ''),
  ChapterData(number: 20, name: 'మన భావోద్వేగ ప్రపంచం', nameEn: ''),
  ChapterData(number: 21, name: 'పసుల్లో నిమగ్నమైన మన అంతర్యాగాలు', nameEn: ''),
  ChapterData(number: 22, name: 'పెరుగుదల మరియు వ్యక్తిత్వవికాసము', nameEn: ''),
  ChapterData(number: 23, name: 'అంటు వ్యాధులు మరియు వ్యాధినివారణ', nameEn: ''),
  ChapterData(number: 24, name: 'పదార్థాలు పస్తువులు మరియు శక్తి', nameEn: ''),
  ChapterData(number: 25, name: 'సామాజిక ఆరోగ్యం', nameEn: ''),
];

// -- పరిసరాల అధ్యయనం భాగం-౨ (EVS Part 2) – 10 chapters ----------------------
const List<ChapterData> _evsPart2ChaptersTelugu = [
  ChapterData(number: 1, name: 'చరిత్ర అనగా నేమి', nameEn: ''),
  ChapterData(number: 2, name: 'చరిత్ర\u2013కాల సంకల్పన', nameEn: ''),
  ChapterData(number: 3, name: 'భూమిపై సజీవులు', nameEn: ''),
  ChapterData(number: 4, name: 'పరిణామం', nameEn: ''),
  ChapterData(number: 5, name: 'మానవుని ప్రస్థానం', nameEn: ''),
  ChapterData(number: 6, name: 'రాతి యుగం రాతి ఆయుధాలు', nameEn: ''),
  ChapterData(number: 7, name: 'నివాసం నుంచి గ్రామ నివాసస్థలం', nameEn: ''),
  ChapterData(number: 8, name: 'స్థిరజీవన ప్రారంభం', nameEn: ''),
  ChapterData(number: 9, name: 'స్థిరజీవనం మరియు పట్టణ సంస్కృతి', nameEn: ''),
  ChapterData(number: 10, name: 'చారిత్రక కాలం', nameEn: ''),
];

// -- ఆడుదాం చేద్దాం నేర్చుకొందాం (Activity) – 16 chapters ---------------------
const List<ChapterData> _adudamChaptersTelugu = [
  ChapterData(number: 1, name: 'ఆరోగ్యం', nameEn: ''),
  ChapterData(number: 2, name: 'వివిధ కదలికలు', nameEn: ''),
  ChapterData(number: 3, name: 'కొశల్యపూర్వక ఉపక్రమాలు', nameEn: ''),
  ChapterData(number: 4, name: 'వివిధ ఆటలు', nameEn: ''),
  ChapterData(number: 5, name: 'వ్యాయామం', nameEn: ''),
  ChapterData(number: 6, name: 'అపనరాణుగర్భ ఉపక్రమాలు', nameEn: ''),
  ChapterData(number: 7, name: 'అధిరవి పూర్వక ఉపక్రమాలు', nameEn: ''),
  ChapterData(number: 8, name: 'కొశల్యపూగర్భ ఉపక్రమాలు', nameEn: ''),
  ChapterData(number: 9, name: 'ఉత్పాదక క్షేత్రం', nameEn: ''),
  ChapterData(number: 10, name: 'ఇతర క్షేత్రాలు', nameEn: ''),
  ChapterData(number: 11, name: 'చిత్రం', nameEn: ''),
  ChapterData(number: 12, name: 'శిల్పం', nameEn: ''),
  ChapterData(number: 13, name: 'గానం', nameEn: ''),
  ChapterData(number: 14, name: 'వాదనము', nameEn: ''),
  ChapterData(number: 15, name: 'నృత్యం', nameEn: ''),
  ChapterData(number: 16, name: 'నాట్యం', nameEn: ''),
];
