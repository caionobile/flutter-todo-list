import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

abstract class TodoLocalDataSource {
  Future<List<Map<String, dynamic>>> loadTodos();
  Future<void> saveTodos(List<Map<String, dynamic>> todos);
}

class TodoLocalDataSourceImpl implements TodoLocalDataSource {
  @override
  Future<List<Map<String, dynamic>>> loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final todosJson = prefs.getString('todos') ?? '[]';
    final List<dynamic> todosList = json.decode(todosJson);
    return todosList.cast<Map<String, dynamic>>();
  }

  @override
  Future<void> saveTodos(List<Map<String, dynamic>> todos) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('todos', json.encode(todos));
  }
}
