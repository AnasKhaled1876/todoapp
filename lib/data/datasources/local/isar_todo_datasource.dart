import 'package:initiation_task/domain/entities/todo.dart';
import 'package:isar/isar.dart';

class IsarTodoDataSource {
  final Isar isar;

  IsarTodoDataSource(this.isar);

  Future<void> addTodo(Todo todo) async {
    await isar.writeTxn(() async {
      await isar.todos.put(todo);
    });
  }

  Future<Todo?> getTodoById(int id) async {
    return await isar.todos.get(id);
  }

  Future<List<Todo>> getTodos() async {
    return await isar.todos.where().findAll();
  }

  Future<void> updateTodo(Todo todo) async {
    // For Isar, put handles both create and update.
    // Ensure the todo object has the correct id.
    await isar.writeTxn(() async {
      await isar.todos.put(todo);
    });
  }

  Future<void> deleteTodo(int id) async {
    await isar.writeTxn(() async {
      await isar.todos.delete(id);
    });
  }

  Future<void> clearAll() async {
    await isar.writeTxn(() async {
      await isar.todos.clear();
    });
  }

}
