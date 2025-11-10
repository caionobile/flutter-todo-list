import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/todo_entity.dart';
import '../providers/todo_provider.dart';
import 'delete_todo_modal.dart';

class TodoItem extends StatefulWidget {
  final TodoEntity todo;

  const TodoItem({super.key, required this.todo});

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _showDeleteModal() {
    showDialog(
      context: context,
      builder: (context) => DeleteTodoModal(todo: widget.todo),
    );
  }

  void _toggleTodo() {
    Provider.of<TodoProvider>(
      context,
      listen: false,
    ).toggleTodo(widget.todo.id);
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: ListTile(
          leading: Checkbox(
            value: widget.todo.completed,
            onChanged: (value) => _toggleTodo(),
          ),
          title: Text(
            widget.todo.title,
            style: TextStyle(
              fontSize: 16,
              color: widget.todo.completed ? Colors.grey : Colors.black,
              decoration: widget.todo.completed
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
            ),
          ),
          onTap: _toggleTodo,
          onLongPress: _showDeleteModal,
        ),
      ),
    );
  }
}
