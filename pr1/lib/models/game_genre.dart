class GameGenreModel {
  final int? id;
  final String title;
  final String description;
  final String imagePath;

  GameGenreModel({
    this.id,
    required this.title,
    required this.description,
    required this.imagePath,
  });

  factory GameGenreModel.fromMap(Map<String, dynamic> map) {
    return GameGenreModel(
      id: map['id'] as int?,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      imagePath: map['imagePath'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'title': title,
      'description': description,
      'imagePath': imagePath,
    };
  }
}
