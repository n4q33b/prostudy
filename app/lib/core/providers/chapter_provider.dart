import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/chapter_data.dart';
import '../data/chapters_marathi.dart';
import '../data/chapters_hindi.dart';
import '../data/chapters_english.dart';
import '../data/chapters_gujarati.dart';
import '../data/chapters_kannada.dart';
import '../data/chapters_telugu.dart';
import '../data/chapters_urdu.dart';

/// Provider that returns chapters for a given medium + subject.
/// Key format: 'medium|subjectName' (e.g., 'marathi|गणित')
final chapterListProvider =
    Provider.family<List<ChapterData>, String>((ref, key) {
  final pipeIndex = key.indexOf('|');
  if (pipeIndex < 0) return [];
  final medium = key.substring(0, pipeIndex).toLowerCase();
  final subject = key.substring(pipeIndex + 1);
  return _getChapters(medium, subject);
});

List<ChapterData> _getChapters(String medium, String subject) {
  final Map<String, List<ChapterData>>? mediumData;
  switch (medium) {
    case 'marathi':
      mediumData = marathiChapters;
    case 'hindi':
      mediumData = hindiChapters;
    case 'english':
      mediumData = englishChapters;
    case 'gujarati':
      mediumData = gujaratiChapters;
    case 'kannada':
      mediumData = kannadaChapters;
    case 'telugu':
      mediumData = teluguChapters;
    case 'urdu':
      mediumData = urduChapters;
    default:
      mediumData = null;
  }
  return mediumData?[subject] ?? [];
}
