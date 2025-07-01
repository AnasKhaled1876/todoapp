// Import the generic TodoDataSource interface instead of the specific Hive implementation
import 'package:initiation_task/domain/repositories/todo.dart';
import 'package:initiation_task/domain/entities/todo.dart';

class TodoRepositoryImpl implements TodoRepository {
  // Depend on the TodoDataSource abstraction
  final TodoDataSource _todoDataSource;

  TodoRepositoryImpl(this._todoDataSource);

  @override
  Future<void> addTodo(Todo todo) {
    return _todoDataSource.addTodo(todo);
  }

  @override
  Future<void> deleteTodo(int id) { // Changed from key to id
    return _todoDataSource.deleteTodo(id);
  }

  @override
  Future<List<Todo>> getTodos() {
    return _todoDataSource.getTodos();
  }

  @override
  Future<void> toggleTodo(int id) async { // Changed from key to id
    // The IsarDataSource doesn't have a direct toggleTodo.
    // We need to get the todo, toggle its state, and then update it.
    final todo = await _todoDataSource.getTodoById(id);
    if (todo != null) {
      final updatedTodo = todo.copyWith(isDone: !todo.isDone);
      await _todoDataSource.updateTodo(updatedTodo);
    }
  }

  @override
  Future<void> updateTodo(Todo todo) { // Changed signature
    return _todoDataSource.updateTodo(todo);
  }
}
