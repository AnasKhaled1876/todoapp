import 'package:hive/hive.dart';

part 'todo.g.dart'; // This will be generated

/// Unique typeId for this model.
///
/// Hive uses this typeId to identify this model
/// when storing and retrieving it in the Hive database.
@HiveType(typeId: 0)
class Todo extends HiveObject {
  /// The number in the annotation is the index of the field
  /// in the database. This index must be unique for each
  /// field in the model.
  @HiveField(0)
  String title;

  @HiveField(1)
  bool isDone;

  Todo({required this.title, this.isDone = false});

  // Copy with method for immutability
  Todo copyWith({String? title, bool? isDone}) {
    return Todo(title: title ?? this.title, isDone: isDone ?? this.isDone);
  }

  // Convert to Map for JSON serialization
  Map<String, dynamic> toMap() {
    return {'title': title, 'isDone': isDone};
  }

  // Create Todo from Map
  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(title: map['title'] ?? '', isDone: map['isDone'] ?? false);
  }

  @override
  /// Whether this [Todo] is equal to [other].
  ///
  /// Two todos are equal if and only if they have the same [title] and [isDone] state.
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Todo && other.title == title && other.isDone == isDone;
  }

  @override
  int get hashCode => title.hashCode ^ isDone.hashCode;
}
