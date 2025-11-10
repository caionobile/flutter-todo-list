import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo_list/features/todo/domain/entities/todo_entity.dart';
import 'package:flutter_todo_list/features/todo/domain/repositories/todo_repository.dart';
import 'package:flutter_todo_list/features/todo/domain/usecases/update_todo_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockTodoRepository extends Mock implements TodoRepository {}

void main() {
  late UpdateTodoUseCase updateTodoUseCase;
  late MockTodoRepository mockRepository;

  setUp(() {
    mockRepository = MockTodoRepository();
    updateTodoUseCase = UpdateTodoUseCase(repository: mockRepository);
  });

  group('UpdateTodoUseCase', () {
    test('should update todo through repository', () async {
      final todo = TodoEntity(
        id: '1',
        title: 'Updated Todo',
        completed: true,
        createdAt: DateTime.now(),
      );

      when(() => mockRepository.updateTodo(todo)).thenAnswer((_) async => {});

      await updateTodoUseCase(todo);

      verify(() => mockRepository.updateTodo(todo)).called(1);
    });

    test('should update todo title only', () async {
      final originalDate = DateTime(2023, 1, 1);
      final todo = TodoEntity(
        id: '1',
        title: 'Only title updated',
        completed: false,
        createdAt: originalDate,
      );

      when(() => mockRepository.updateTodo(todo)).thenAnswer((_) async => {});

      await updateTodoUseCase(todo);

      verify(() => mockRepository.updateTodo(todo)).called(1);
    });

    test('should update todo completion status only', () async {
      final todo = TodoEntity(
        id: '1',
        title: 'Same Title',
        completed: true, 
        createdAt: DateTime.now(),
      );

      when(() => mockRepository.updateTodo(todo)).thenAnswer((_) async => {});

      await updateTodoUseCase(todo);

      verify(() => mockRepository.updateTodo(todo)).called(1);
    });
  });
}
