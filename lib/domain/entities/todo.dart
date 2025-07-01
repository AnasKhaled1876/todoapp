import 'package:hive/hive.dart';

part 'todo.g.dart'; // This will be generated

@HiveType(typeId: 0) // Unique typeId for this model
class Todo extends HiveObject {

  @HiveField(0)
  String title;

  @HiveField(1)
  bool isDone;

  Todo({
    required this.title,
    this.isDone = false,
  });

  // Copy with method for immutability
  Todo copyWith({
    String? title,
    bool? isDone,
  }) {
    return Todo(
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
    );
  }

  // Convert to Map for JSON serialization
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'isDone': isDone,
    };
  }

  // Create Todo from Map
  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      title: map['title'] ?? '',
      isDone: map['isDone'] ?? false,
    );
  }
  


  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Todo &&
      other.title == title &&
      other.isDone == isDone;
  }

  @override
  int get hashCode => title.hashCode ^ isDone.hashCode;
}
