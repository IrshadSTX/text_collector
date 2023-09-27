import 'dart:developer';

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
      'date': date, // Convert DateTime to a string for storage
    };
  }

  factory AppModel.fromMap(Map<String, dynamic> map) {
    log(map.toString());
    return AppModel(
        id: map['id'],
        title: map['title'],
        imagePath: map['imagePath'],
        date:
            map['date'] ?? DateTime.now() // Provide a default DateTime if null
        );
  }
}
