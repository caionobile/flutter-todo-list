import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo_list/features/todo/domain/entities/todo_entity.dart';
import 'package:flutter_todo_list/features/todo/domain/repositories/todo_repository.dart';
import 'package:flutter_todo_list/features/todo/domain/usecases/load_todos_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockTodoRepository extends Mock implements TodoRepository {}

void main() {
  late LoadTodosUseCase loadTodosUseCase;
  late MockTodoRepository mockRepository;

  final mockTodos = [
    TodoEntity(
      id: '1',
      title: 'Test Todo 1',
      completed: false,
      createdAt: DateTime.now(),
    ),
    TodoEntity(
      id: '2',
      title: 'Test Todo 2',
      completed: true,
      createdAt: DateTime.now().subtract(Duration(days: 1)),
    ),
  ];

  setUp(() {
    mockRepository = MockTodoRepository();
    loadTodosUseCase = LoadTodosUseCase(repository: mockRepository);
  });

  group('LoadTodosUseCase', () {
    test('should load todos from repository', () async {
      when(() => mockRepository.loadTodos()).thenAnswer((_) async => mockTodos);

      final result = await loadTodosUseCase();

      expect(result, mockTodos);
      expect(result.length, 2);
      expect(result[0].id, '1');
      expect(result[1].id, '2');
      verify(() => mockRepository.loadTodos()).called(1);
    });

    test('should return empty list when repository returns empty', () async {
      when(() => mockRepository.loadTodos()).thenAnswer((_) async => []);

      final result = await loadTodosUseCase();

      expect(result, isEmpty);
      verify(() => mockRepository.loadTodos()).called(1);
    });

    test('should maintain todo order from repository', () async {
      final orderedTodos = [
        TodoEntity(
          id: 'first',
          title: 'First Todo',
          completed: false,
          createdAt: DateTime(2023, 1, 1),
        ),
        TodoEntity(
          id: 'second',
          title: 'Second Todo',
          completed: false,
          createdAt: DateTime(2023, 1, 2),
        ),
      ];

      when(
        () => mockRepository.loadTodos(),
      ).thenAnswer((_) async => orderedTodos);

      final result = await loadTodosUseCase();

      expect(result[0].id, 'first');
      expect(result[1].id, 'second');
      verify(() => mockRepository.loadTodos()).called(1);
    });
  });
}
