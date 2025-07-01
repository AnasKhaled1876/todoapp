import 'package:hive/hive.dart';
import 'package:initiation_task/domain/entities/todo.dart';

class HiveTodoDataSource {
  final Box<Todo> todoBox;

  HiveTodoDataSource(this.todoBox);

  // Add a new todo
  Future<void> addTodo(Todo todo) async {
    await todoBox.add(todo);
  }

  // Toggle todo completion status
  Future<void> toggleTodo(int key) async {
    final updatedTodo = todoBox.get(key)!;
    await updateTodo(key, updatedTodo);
  }

  // Delete a todo
  Future<void> deleteTodo(int key) async {
    if (todoBox.get(key)!.key != null) {
      await todoBox.get(key)!.delete();
    }
  }

  // Get all todos
  Future<List<Todo>> getTodos() async {
    return todoBox.values.toList();
  }

  // Update a todo
  Future<void> updateTodo(int key, Todo todo) async {
    if (todoBox.get(key)!.key != null) {
      await todoBox.get(key)!.save();
    }
  }

  // Optional: Clear all todos (useful for testing)
  Future<void> clearAll() async {
    await todoBox.clear();
  }
}