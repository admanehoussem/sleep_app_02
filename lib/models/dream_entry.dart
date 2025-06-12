class DreamEntry {
  final String id;
  final String title;
  final String content;
  final DateTime date;
  final List<String> tags;
  final int moodRating; // 1-5 scale
  final String? imageUrl;

  DreamEntry({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    this.tags = const [],
    this.moodRating = 3,
    this.imageUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'date': date.toIso8601String(),
      'tags': tags,
      'moodRating': moodRating,
      'imageUrl': imageUrl,
    };
  }

  factory DreamEntry.fromJson(Map<String, dynamic> json) {
    return DreamEntry(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      date: DateTime.parse(json['date']),
      tags: List<String>.from(json['tags'] ?? []),
      moodRating: json['moodRating'] ?? 3,
      imageUrl: json['imageUrl'],
    );
  }
}