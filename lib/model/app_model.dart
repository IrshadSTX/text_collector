class AppModel {
  final int? id;
  final String title;
  final String imagePath;
  final DateTime? date;

  AppModel(
      {required this.title,
      required this.imagePath,
      required this.date,
      this.id});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'imagePath': imagePath,
      'date':
          date?.toIso8601String(), // Convert DateTime to a string for storage
    };
  }

  factory AppModel.fromMap(Map<String, dynamic> map) {
    return AppModel(
      id: map['id'],
      title: map['title'],
      imagePath: map['imagePath'],
      date: map['date'] != null
          ? DateTime.parse(map['date'])
          : null, // Convert the stored string back to DateTime
    );
  }
}
