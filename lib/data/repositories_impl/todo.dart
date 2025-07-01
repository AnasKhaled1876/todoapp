// Import the generic TodoDataSource interface instead of the specific Hive implementation
import 'package:initiation_task/domain/repositories/todo.dart';
import 'package:initiation_task/domain/entities/todo.dart';

import '../datasources/local/isar_todo_datasource.dart';

class TodoRepositoryImpl implements TodoRepository {
  // Depend on the TodoDataSource abstraction
  final IsarTodoDataSource _todoDataSource;

  TodoRepositoryImpl(this._todoDataSource);

  @override
  Future<void> addTodo(Todo todo) {
    return _todoDataSource.addTodo(todo);
  }

  @override
  Future<void> deleteTodo(int id) {
    // Changed from key to id
    return _todoDataSource.deleteTodo(id);
  }

  @override
  Future<List<Todo>> getTodos() {
    return _todoDataSource.getTodos();
  }

  @override
  Future<void> updateTodo(Todo todo) {
    // Changed signature
    return _todoDataSource.updateTodo(todo);
  }

  @override
  Future<void> clearAll() {
    return _todoDataSource.clearAll();
  }

  @override
  Future<Todo?> getTodoById(int id) {
    return _todoDataSource.getTodoById(id);
  }
}
