import 'package:easy_localization/easy_localization.dart';
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
      title: Text('Delete Todo'.tr()),
      content: Text('Are you sure you want to delete this todo?'.tr()),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel'.tr(), style: TextStyle(color: Colors.grey)),
        ),
        TextButton(
          onPressed: () {
            notifier.removeTodo(todo);
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Todo deleted'.tr()),
                action: SnackBarAction(
                  label: 'UNDO'.tr(),
                  onPressed: () {
                    notifier.addTodo(todo);
                  },
                ),
              ),
            );
          },
          style: TextButton.styleFrom(foregroundColor: Colors.red),
          child: Text('Delete'.tr()),
        ),
      ],
    );
  }
}
