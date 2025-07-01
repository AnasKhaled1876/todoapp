import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/home/todo_list_item.dart';
import 'package:flutter/material.dart';
import '../widgets/dialogs/add.dart';
import '../widgets/empty_list.dart';
import '../providers/todo.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todosProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Todos')),
      body: SafeArea(
        child: todos.isEmpty
            ? EmptyListWidget()
            : ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) =>
                    TodoListItem(todo: todos[index]),
              ),
      ),
      floatingActionButton: todos.isEmpty
          ? null
          : FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AddTodoDialog(),
                );
              },
              child: const Icon(Icons.add),
            ),
    );
  }
}
