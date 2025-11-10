import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo_list/features/todo/domain/entities/todo_entity.dart';
import 'package:flutter_todo_list/features/todo/domain/repositories/todo_repository.dart';
import 'package:flutter_todo_list/features/todo/domain/usecases/add_todo_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockTodoRepository extends Mock implements TodoRepository {}

void main() {
  late AddTodoUseCase addTodoUseCase;
  late MockTodoRepository mockRepository;

  setUp(() {
    mockRepository = MockTodoRepository();
    addTodoUseCase = AddTodoUseCase(repository: mockRepository);
  });

  group('AddTodoUseCase', () {
    test('should add todo through repository', () async {
      final todo = TodoEntity(
        id: '1',
        title: 'Test Todo',
        completed: false,
        createdAt: DateTime.now(),
      );

      when(() => mockRepository.addTodo(todo)).thenAnswer((_) async => {});

      await addTodoUseCase(todo);

      verify(() => mockRepository.addTodo(todo)).called(1);
    });

    test('should add todo with completed status true', () async {
      final todo = TodoEntity(
        id: '2',
        title: 'Completed Todo',
        completed: true,
        createdAt: DateTime.now(),
      );

      when(() => mockRepository.addTodo(todo)).thenAnswer((_) async => {});

      await addTodoUseCase(todo);

      verify(() => mockRepository.addTodo(todo)).called(1);
    });
  });
}
