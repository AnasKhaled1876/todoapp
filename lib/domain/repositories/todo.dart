import 'package:initiation_task/domain/entities/todo.dart';

  /// Abstraction for the data source of todos.
  ///
  /// This abstraction should be implemented by a data source, such as a database
  /// or a network request. The methods of this class should be implemented to
  /// write to the data source.
  ///
  /// The methods of this class correspond to the following operations:
  ///
  /// - [addTodo] adds a todo to the data source.
  /// - [toggleTodo] toggles the done state of a todo in the data source.
  /// - [deleteTodo] removes a todo from the data source.
  /// - [getTodos] retrieves all todos from the data source.
  /// - [updateTodo] updates a todo in the data source.
abstract class TodoRepository {

  Future<void> addTodo(Todo todo);

  Future<void> toggleTodo(int key);

  Future<void> deleteTodo(int key);

  Future<List<Todo>> getTodos();

  Future<void> updateTodo(int key, Todo todo);
}
