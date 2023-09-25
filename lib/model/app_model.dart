class AppModel {
  int? id;
  final String title;
  final String imagePath;

  AppModel({required this.title, required this.imagePath, required int id});
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'imagePath': imagePath // Store as 1 for true, 0 for false
    };
  }

  // Create a Task object from a Map
  factory AppModel.fromMap(Map<String, dynamic> map) {
    return AppModel(
      id: map['id'],
      title: map['title'],
      imagePath: map['imagePath'], // Convert back to bool
    );
  }
}
