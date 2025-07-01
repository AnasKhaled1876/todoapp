import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/todo.dart';
import '../../providers/todo.dart';

class AddTodoDialog extends StatefulWidget {
  const AddTodoDialog({super.key});

  @override
  State<AddTodoDialog> createState() => _AddTodoDialogState();
}

class _AddTodoDialogState extends State<AddTodoDialog> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Todo'),
      content: TextField(
        controller: _controller,
        decoration: const InputDecoration(hintText: 'Todo title'),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        Consumer(
          builder: (context, ref, child) {
            final notifier = ref.read(todosProvider.notifier);
            return TextButton(
              onPressed: () {
                notifier.addTodo(Todo(title: _controller.text));
                notifier.loadTodos();
                Navigator.pop(context);
              },
              child: const Text('Add'),
            );
          },
        ),
      ],
    );
  }
}
