import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/todo.dart';
import 'package:flutter/material.dart';
import '../../providers/todo.dart';

class AddTodoDialog extends ConsumerStatefulWidget {
  const AddTodoDialog({super.key});

  @override
  ConsumerState<AddTodoDialog> createState() => _AddTodoDialogState();
}

class _AddTodoDialogState extends ConsumerState<AddTodoDialog> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(todosProvider.notifier);

    return AlertDialog(
      title: Text('Add Todo'.tr()),
      content: TextField(
        autofocus: true,
        onEditingComplete: () {
          if (_controller.text.trim().isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
               SnackBar(content: Text('Title cannot be empty'.tr())),
            );
            return;
          }
          notifier.addTodo(Todo(title: _controller.text));
          notifier.loadTodos();
          Navigator.pop(context);
        },
        controller: _controller,
        decoration: InputDecoration(hintText: 'Todo title'.tr()),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel'.tr(), style: TextStyle(color: Colors.grey)),
        ),
        TextButton(
          onPressed: () {
            if (_controller.text.trim().isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                 SnackBar(content: Text('Title cannot be empty'.tr())),
              );
              return;
            }

            notifier.addTodo(Todo(title: _controller.text));
            notifier.loadTodos();
            Navigator.pop(context);
          },
          child: Text('Add'.tr()),
        ),
      ],
    );
  }
}
