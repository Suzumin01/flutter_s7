class GameGenre {
  final String title;
  final String description;

  GameGenre({
    required this.title,
    required this.description,
  });

  factory GameGenre.fromMap(Map<String, dynamic> map) {
    return GameGenre(
      title: map['title'] ?? '',
      description: map['description'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
    };
  }
}