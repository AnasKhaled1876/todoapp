import 'package:initiation_task/presentation/providers/todo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/todo.dart';
import 'package:flutter/material.dart';

class DeleteDialog extends ConsumerWidget {
  const DeleteDialog({super.key, required this.todo});

  final Todo todo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(todosProvider.notifier);
    return AlertDialog(
      title: const Text('Delete Todo'),
      content: const Text('Are you sure you want to delete this todo?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            notifier.removeTodo(todo);
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Todo deleted'),
                action: SnackBarAction(
                  label: 'UNDO',
                  onPressed: () {
                    notifier.addTodo(todo);
                  },
                ),
              ),
            );
          },
          style: TextButton.styleFrom(foregroundColor: Colors.red),
          child: const Text('Delete'),
        ),
      ],
    );
  }
}
