import 'package:flutter/material.dart';

import 'dialogs/add.dart';

class EmptyListWidget extends StatelessWidget {
  const EmptyListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.check_circle_outline,
            size: 100,
            color: Theme.of(context).primaryColor.withValues(alpha: 0.2),
          ),
          const SizedBox(height: 24),
          // Title
          Text(
            'No Tasks Yet',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
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
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            ),
          ),
        ],
      ),
    );
  }
}
