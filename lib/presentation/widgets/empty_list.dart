import 'package:easy_localization/easy_localization.dart';
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
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Text(
              'No Tasks Yet'.tr(),
              key: Key(context.locale.languageCode),
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Subtitle
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48.0),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Text(
                'empty_list_description'.tr(),
                key: Key(context.locale.languageCode),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[500], fontSize: 16),
              ),
            ),
          ),
          const SizedBox(height: 32),
          // Add Button
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: FilledButton.icon(
              key: Key(context.locale.languageCode),
              onPressed: () {
                // Reuse your existing add todo dialog
                showDialog(
                  context: context,
                  builder: (context) => const AddTodoDialog(),
                );
              },
              icon: const Icon(Icons.add),
              label: Text('Add Your First Task'.tr()),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
