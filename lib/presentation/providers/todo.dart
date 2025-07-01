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
    state = state.where((element) => element.id != todo.id).toList();
    _todoRepository.deleteTodo(todo.id);
  }

  void toggleTodo({required int id, required Todo todo}) {
    final selectedTodo = state.firstWhere((element) => element.id == id);
    selectedTodo.isDone = todo.isDone;
    state = state
        .map((element) => element.id == id ? selectedTodo : element)
        .toList();
    _todoRepository.toggleTodo(id);
  }

  void updateTodo({required int id, required Todo todo}) {
    final selectedTodo = state.firstWhere((element) => element.id == id);
    selectedTodo.title = todo.title;
    state = state
        .map((element) => element.id == id ? selectedTodo : element)
        .toList();
    _todoRepository.updateTodo(selectedTodo);
  }
}

final todosProvider = StateNotifierProvider<TodoNotifier, List<Todo>>(
  (ref) => TodoNotifier(locator<TodoRepository>()),
);
