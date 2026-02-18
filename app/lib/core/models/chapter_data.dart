/// Data model for a single chapter within a subject.
class ChapterData {
  const ChapterData({
    required this.number,
    required this.name,
    required this.nameEn,
    this.hasSimulation = false,
  });

  /// Chapter number (1-based)
  final int number;

  /// Chapter name in the medium's native script
  final String name;

  /// Chapter name in English (translated, may be empty)
  final String nameEn;

  /// Whether a simulation HTML file exists for this chapter
  final bool hasSimulation;
}
