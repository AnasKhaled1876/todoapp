import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:initiation_task/domain/entities/todo.dart';
import 'package:initiation_task/presentation/providers/todo.dart';

class EditTodoScreen extends ConsumerStatefulWidget {
  final Todo todo;

  const EditTodoScreen({super.key, required this.todo});

  @override
  ConsumerState<EditTodoScreen> createState() => _EditTodoScreenState();
}

class _EditTodoScreenState extends ConsumerState<EditTodoScreen> {
  late final TextEditingController _titleController;
  late bool _isDone;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.todo.title);
    _isDone = widget.todo.isDone;
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _saveChanges() async {
    if (_titleController.text.trim().isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Title cannot be empty'.tr())));
      }
      return;
    }

    final updatedTodo = Todo(title: _titleController.text, isDone: _isDone);

    ref
        .read(todosProvider.notifier)
        .updateTodo(key: widget.todo.key!, todo: updatedTodo);

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Todo'.tr()),
        actions: [
          IconButton(icon: const Icon(Icons.save), onPressed: _saveChanges),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title'.tr(),
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
              autofocus: true,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _saveChanges(),
            ),
            const SizedBox(height: 20),
            Card(
              child: SwitchListTile(
                title: Text('Completed'.tr()),
                value: _isDone,
                activeTrackColor: Theme.of(context).primaryColor,
                inactiveTrackColor: Theme.of(
                  context,
                ).colorScheme.secondary.withValues(alpha: 0.2),
                onChanged: (value) {
                  setState(() {
                    _isDone = value;
                  });
                  ref
                      .read(todosProvider.notifier)
                      .toggleTodo(
                        key: widget.todo.key!,
                        todo: widget.todo.copyWith(isDone: value),
                      );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
