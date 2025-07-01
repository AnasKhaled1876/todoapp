import 'package:initiation_task/data/datasources/todo.dart';
import 'package:initiation_task/domain/entities/todo.dart';
import 'package:initiation_task/domain/repositories/todo.dart';

class TodoRepositoryImpl implements TodoRepository {
  final HiveTodoDataSource _hiveTodoDataSource;

  TodoRepositoryImpl(this._hiveTodoDataSource);

  @override
  Future<void> addTodo(Todo todo) {
    return _hiveTodoDataSource.addTodo(todo);
  }

  @override
  Future<void> deleteTodo(int key) {
    return _hiveTodoDataSource.deleteTodo(key);
  }

  @override
  Future<List<Todo>> getTodos() {
    return _hiveTodoDataSource.getTodos();
  }

  @override
  Future<void> toggleTodo(int key) {
    return _hiveTodoDataSource.toggleTodo(key);
  }

  @override
  Future<void> updateTodo(int key, Todo todo) {
    return _hiveTodoDataSource.updateTodo(key, todo);
  }
}
