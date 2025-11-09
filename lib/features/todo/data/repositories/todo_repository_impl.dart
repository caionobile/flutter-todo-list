import '../../domain/entities/todo_entity.dart';
import '../../domain/repositories/todo_repository.dart';
import '../datasources/todo_local_data_source.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoLocalDataSource localDataSource;

  TodoRepositoryImpl({required this.localDataSource});

  @override
  Future<List<TodoEntity>> loadTodos() async {
    final todosData = await localDataSource.loadTodos();
    return todosData
        .map(
          (todoMap) => TodoEntity(
            id: todoMap['id'],
            title: todoMap['title'],
            completed: todoMap['completed'],
            createdAt: DateTime.parse(todoMap['createdAt']),
          ),
        )
        .toList();
  }

  @override
  Future<void> saveTodos(List<TodoEntity> todos) async {
    final todosData = todos
        .map(
          (todo) => {
            'id': todo.id,
            'title': todo.title,
            'completed': todo.completed,
            'createdAt': todo.createdAt.toIso8601String(),
          },
        )
        .toList();
    await localDataSource.saveTodos(todosData);
  }

  @override
  Future<void> addTodo(TodoEntity todo) async {
    final todos = await loadTodos();
    todos.add(todo);
    await saveTodos(todos);
  }

  @override
  Future<void> updateTodo(TodoEntity updatedTodo) async {
    final todos = await loadTodos();
    final index = todos.indexWhere((todo) => todo.id == updatedTodo.id);
    if (index != -1) {
      todos[index] = updatedTodo;
      await saveTodos(todos);
    }
  }

  @override
  Future<void> deleteTodo(String id) async {
    final todos = await loadTodos();
    todos.removeWhere((todo) => todo.id == id);
    await saveTodos(todos);
  }
}
