class AppModel {
  final String title;
  final String imagePath;
  final DateTime date; // Add DateTime property

  AppModel({required this.title, required this.imagePath, required this.date});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'imagePath': imagePath,
      'date':
          date.toIso8601String(), // Convert DateTime to a string for storage
    };
  }

  factory AppModel.fromMap(Map<String, dynamic> map) {
    return AppModel(
      title: map['title'],
      imagePath: map['imagePath'],
      date: map['date'] != null
          ? DateTime.parse(map['date'])
          : DateTime.now(), // Provide a default DateTime if null
    );
  }
}
