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

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodoProvider>(context);

    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final filteredTodos = _getFilteredTodos(provider.todos, filter);

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
}
