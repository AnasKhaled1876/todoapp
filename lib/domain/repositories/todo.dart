import 'package:initiation_task/domain/entities/todo.dart';

abstract class TodoRepository {

  Future<void> addTodo(Todo todo);

  Future<void> toggleTodo(int key);

  Future<void> deleteTodo(int key);

  Future<List<Todo>> getTodos();

  Future<void> updateTodo(int key, Todo todo);
}
