import '../entities/todo_entity.dart';
import '../repositories/todo_repository.dart';

class UpdateTodoUseCase {
  final TodoRepository repository;

  UpdateTodoUseCase({required this.repository});

  Future<void> call(TodoEntity todo) async {
    return await repository.updateTodo(todo);
  }
}
