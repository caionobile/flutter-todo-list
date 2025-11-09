import '../entities/todo_entity.dart';

abstract class TodoRepository {
  Future<List<TodoEntity>> loadTodos();
  Future<void> saveTodos(List<TodoEntity> todos);
  Future<void> addTodo(TodoEntity todo);
  Future<void> updateTodo(TodoEntity todo);
  Future<void> deleteTodo(String id);
}
