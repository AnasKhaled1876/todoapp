import 'package:initiation_task/domain/repositories/todo.dart';
import 'package:initiation_task/domain/entities/todo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../locator.dart';

class TodoNotifier extends StateNotifier<List<Todo>> {
  final TodoRepository _todoRepository;

  TodoNotifier(this._todoRepository) : super([]) {
    if (state.isEmpty) {
      loadTodos();
    }
  }

  void loadTodos() {
    _todoRepository.getTodos().then((todos) {
      state = todos;
    });
  }

  void addTodo(Todo todo) {
    state = [...state, todo];
    _todoRepository.addTodo(todo);
  }

  void removeTodo(Todo todo) {
    state = state.where((element) => element.key != todo.key).toList();
    _todoRepository.deleteTodo(todo.key);
  }

  void toggleTodo({required int key, required Todo todo}) {
    final selectedTodo = state.firstWhere((element) => element.key == key);
    selectedTodo.isDone = todo.isDone;
    state = state
        .map((element) => element.key == key ? selectedTodo : element)
        .toList();
    _todoRepository.toggleTodo(key);
  }

  void updateTodo({required int key, required Todo todo}) {
    final selectedTodo = state.firstWhere((element) => element.key == key);
    selectedTodo.title = todo.title;
    state = state
        .map((element) => element.key == key ? selectedTodo : element)
        .toList();
    _todoRepository.updateTodo(key, selectedTodo);
  }
}

final todosProvider = StateNotifierProvider<TodoNotifier, List<Todo>>(
  (ref) => TodoNotifier(locator<TodoRepository>()),
);
