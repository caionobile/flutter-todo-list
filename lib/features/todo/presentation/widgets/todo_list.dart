import 'package:flutter/material.dart';
import 'package:flutter_todo_list/features/todo/domain/entities/todo_entity.dart';
import 'package:provider/provider.dart';

import '../providers/todo_provider.dart';
import 'todo_item.dart';

enum TodoFilter { all, pending, done }

class TodoList extends StatelessWidget {
  final TodoFilter filter;

  const TodoList({super.key, required this.filter});

  List<TodoEntity> _getFilteredTodos(
    List<TodoEntity> todos,
    TodoFilter filter,
  ) {
    switch (filter) {
      case TodoFilter.pending:
        return todos.where((todo) => !todo.completed).toList();
      case TodoFilter.done:
        return todos.where((todo) => todo.completed).toList();
      case TodoFilter.all:
        return todos;
    }
  }

  String _getEmptyMessage(TodoFilter filter) {
    switch (filter) {
      case TodoFilter.all:
        return 'Add a task to get started';
      case TodoFilter.pending:
        return 'No pending tasks';
      case TodoFilter.done:
        return 'No completed tasks';
    }
  }

  String _getEmptySubtitle(TodoFilter filter) {
    switch (filter) {
      case TodoFilter.all:
        return 'Tap the + button to create your first task';
      case TodoFilter.pending:
        return 'All tasks are completed or add new tasks';
      case TodoFilter.done:
        return 'Complete some tasks to see them here';
    }
  }

  IconData _getEmptyIcon(TodoFilter filter) {
    switch (filter) {
      case TodoFilter.all:
        return Icons.task_outlined;
      case TodoFilter.pending:
        return Icons.check_circle_outline;
      case TodoFilter.done:
        return Icons.celebration_outlined;
    }
  }

  Color _getEmptyIconColor(TodoFilter filter, BuildContext context) {
    switch (filter) {
      case TodoFilter.all:
        return Colors.blue;
      case TodoFilter.pending:
        return Colors.orange;
      case TodoFilter.done:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodoProvider>(context);

    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final filteredTodos = _getFilteredTodos(provider.todos, filter);

    if (filteredTodos.isEmpty) {
      return _buildEmptyState(context, filter);
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.only(bottom: 80),
      child: ListView.builder(
        itemCount: filteredTodos.length,
        itemBuilder: (context, index) {
          final todo = filteredTodos[index];
          return TodoItem(todo: todo);
        },
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, TodoFilter filter) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            _getEmptyIcon(filter),
            size: 80,
            color: _getEmptyIconColor(filter, context),
          ),
          const SizedBox(height: 24),
          Text(
            _getEmptyMessage(filter),
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.grey[600],
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            _getEmptySubtitle(filter),
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey[500]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
