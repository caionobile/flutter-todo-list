import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/todo_entity.dart';
import '../providers/todo_provider.dart';

class DeleteTodoModal extends StatelessWidget {
  final TodoEntity todo;

  const DeleteTodoModal({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    void deleteTodo() {
      Provider.of<TodoProvider>(context, listen: false).deleteTodo(todo.id);
      Navigator.of(context).pop();
    }

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Delete task',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            Text(
              'Are you sure you want to delete "${todo.title}"?',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: deleteTodo,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text('Delete'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
