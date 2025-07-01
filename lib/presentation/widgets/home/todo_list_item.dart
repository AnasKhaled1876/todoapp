import 'package:animations/animations.dart';
import 'package:initiation_task/domain/entities/todo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../../screens/edit.dart';
import '../../providers/todo.dart';
import '../dialogs/delete.dart';

class TodoListItem extends ConsumerWidget {
  const TodoListItem({super.key, required this.todo});

  final Todo todo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: OpenContainer(
        closedColor: Colors.white,
        closedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: Colors.transparent, width: 0),
        ),
        closedBuilder: (context, action) => Dismissible(
          background: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.red,
            ),
            alignment: Alignment(0.9, 0),
          ),
          key: Key(todo.key.toString()),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Checkbox.adaptive(
                  value: todo.isDone,
                  activeColor: Theme.of(context).colorScheme.primary,
                  onChanged: (value) {
                    ref
                        .read(todosProvider.notifier)
                        .toggleTodo(
                          key: todo.key,
                          todo: todo.copyWith(isDone: value!),
                        );
                  },
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    todo.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => DeleteDialog(todo: todo),
                    );
                  },
                ),
              ],
            ),
          ),
          confirmDismiss: (direction) {
            return showDialog<bool>(
              context: context,
              builder: (context) => DeleteDialog(todo: todo),
            );
          },
        ),
        openBuilder:
            (
              BuildContext context,
              void Function({Object? returnValue}) action,
            ) => EditTodoScreen(todo: todo),
      ),
    );
  }
}
