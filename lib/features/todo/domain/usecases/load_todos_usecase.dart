import '../entities/todo_entity.dart';
import '../repositories/todo_repository.dart';

class LoadTodosUseCase {
  final TodoRepository repository;

  LoadTodosUseCase({required this.repository});

  Future<List<TodoEntity>> call() async {
    return await repository.loadTodos();
  }
}
