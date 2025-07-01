import 'package:flutter/material.dart';
import 'package:initiation_task/presentation/screens/edit_title.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/dialogs/delete.dart';
import '../widgets/dialogs/add.dart';
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
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Illustration
                    Icon(
                      Icons.check_circle_outline,
                      size: 100,
                      color: Theme.of(context).primaryColor.withOpacity(0.2),
                    ),
                    const SizedBox(height: 24),
                    // Title
                    Text(
                      'No Tasks Yet',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[600],
                          ),
                    ),
                    const SizedBox(height: 8),
                    // Subtitle
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 48.0),
                      child: Text(
                        'You don\'t have any tasks right now.\nTap the + button to add a new task!',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey[500], fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Add Button
                    FilledButton.icon(
                      onPressed: () {
                        // Reuse your existing add todo dialog
                        showDialog(
                          context: context,
                          builder: (context) => const AddTodoDialog(),
                        );
                      },
                      icon: const Icon(Icons.add),
                      label: const Text('Add Your First Task'),
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) => Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 4.0,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 2,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: InkWell(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            EditTodoScreen(todo: todos[index]),
                      ),
                    ),
                    child: Dismissible(
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment(0.9, 0),
                        child: const Icon(Icons.delete),
                      ),
                      key: Key(todos[index].key.toString()),

                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Checkbox.adaptive(
                              value: todos[index].isDone,
                              onChanged: (value) {
                                ref
                                    .read(todosProvider.notifier)
                                    .toggleTodo(
                                      key: todos[index].key,
                                      todo: todos[index].copyWith(
                                        isDone: value!,
                                      ),
                                    );
                              },
                            ),
                            Text(todos[index].title),

                            IconButton(
                              icon: const Icon(
                                Icons.delete_outline,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) =>
                                      DeleteDialog(todo: todos[index]),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      confirmDismiss: (direction) {
                        return showDialog<bool>(
                          context: context,
                          builder: (context) =>
                              DeleteDialog(todo: todos[index]),
                        );
                      },
                    ),
                  ),
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(context: context, builder: (context) => AddTodoDialog());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
