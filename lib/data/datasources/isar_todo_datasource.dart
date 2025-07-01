import 'package:isar/isar.dart';
import 'package:initiation_task/domain/entities/todo.dart';
import 'package:initiation_task/domain/repositories/todo.dart'; // Import the interface

class IsarTodoDataSource implements TodoDataSource {
  final Isar isar;

  IsarTodoDataSource(this.isar);

  @override
  Future<void> addTodo(Todo todo) async {
    await isar.writeTxn(() async {
      await isar.todos.put(todo);
    });
  }

  @override
  Future<Todo?> getTodoById(int id) async {
    return await isar.todos.get(id);
  }

  @override
  Future<List<Todo>> getTodos() async {
    return await isar.todos.where().findAll();
  }

  @override
  Future<void> updateTodo(Todo todo) async {
    // For Isar, put handles both create and update.
    // Ensure the todo object has the correct id.
    await isar.writeTxn(() async {
      await isar.todos.put(todo);
    });
  }

  @override
  Future<void> deleteTodo(int id) async {
    await isar.writeTxn(() async {
      await isar.todos.delete(id);
    });
  }

  @override
  Future<void> clearAll() async {
    await isar.writeTxn(() async {
      await isar.todos.clear();
    });
  }
}
