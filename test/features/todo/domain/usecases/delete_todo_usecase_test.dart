import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_todo_list/features/todo/domain/repositories/todo_repository.dart';
import 'package:flutter_todo_list/features/todo/domain/usecases/delete_todo_usecase.dart';

class MockTodoRepository extends Mock implements TodoRepository {}

void main() {
  late DeleteTodoUseCase deleteTodoUseCase;
  late MockTodoRepository mockRepository;

  setUp(() {
    mockRepository = MockTodoRepository();
    deleteTodoUseCase = DeleteTodoUseCase(repository: mockRepository);
  });

  group('DeleteTodoUseCase', () {
    test('should delete todo through repository', () async {
      const todoId = '1';

      when(() => mockRepository.deleteTodo(todoId)).thenAnswer((_) async => {});

      await deleteTodoUseCase(todoId);

      verify(() => mockRepository.deleteTodo(todoId)).called(1);
    });
  });
}