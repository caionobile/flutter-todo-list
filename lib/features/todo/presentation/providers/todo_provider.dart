import 'package:flutter/material.dart';
import 'package:flutter_todo_list/features/todo/domain/entities/todo_entity.dart';
import 'package:flutter_todo_list/features/todo/domain/usecases/add_todo_usecase.dart';
import 'package:flutter_todo_list/features/todo/domain/usecases/delete_todo_usecase.dart';
import 'package:flutter_todo_list/features/todo/domain/usecases/load_todos_usecase.dart';
import 'package:flutter_todo_list/features/todo/domain/usecases/update_todo_usecase.dart';

class TodoProvider with ChangeNotifier {
  final LoadTodosUseCase loadTodosUseCase;
  final AddTodoUseCase addTodoUseCase;
  final UpdateTodoUseCase updateTodoUseCase;
  final DeleteTodoUseCase deleteTodoUseCase;

  TodoProvider({
    required this.loadTodosUseCase,
    required this.addTodoUseCase,
    required this.updateTodoUseCase,
    required this.deleteTodoUseCase,
  }) {
    loadTodos();
  }

  List<TodoEntity> _todos = [];
  List<TodoEntity> get todos => _todos;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> loadTodos() async {
    _isLoading = true;
    notifyListeners();

    try {
      _todos = await loadTodosUseCase();
    } catch (error) {
      _todos = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addTodo(String title) async {
    if (title.trim().isEmpty) return;

    final newTodo = TodoEntity(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title.trim(),
      completed: false,
      createdAt: DateTime.now(),
    );

    await addTodoUseCase(newTodo);
    await loadTodos();
  }

  Future<void> toggleTodo(String id) async {
    final todo = _todos.firstWhere((todo) => todo.id == id);
    final updatedTodo = todo.copyWith(completed: !todo.completed);
    await updateTodoUseCase(updatedTodo);
    await loadTodos();
  }

  Future<void> deleteTodo(String id) async {
    await deleteTodoUseCase(id);
    await loadTodos();
  }

  List<TodoEntity> get pendingTodos =>
      _todos.where((todo) => !todo.completed).toList();

  List<TodoEntity> get completedTodos =>
      _todos.where((todo) => todo.completed).toList();
}
