import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo_list/features/todo/data/datasources/todo_local_data_source.dart';
import 'package:flutter_todo_list/features/todo/data/repositories/todo_repository_impl.dart';
import 'package:flutter_todo_list/features/todo/domain/entities/todo_entity.dart';
import 'package:mocktail/mocktail.dart';

class MockTodoLocalDataSource extends Mock implements TodoLocalDataSource {}

void main() {
  late TodoRepositoryImpl repository;
  late MockTodoLocalDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockTodoLocalDataSource();
    repository = TodoRepositoryImpl(localDataSource: mockDataSource);
  });

  final mockTodoData = {
    'id': '1',
    'title': 'Test Todo',
    'completed': false,
    'createdAt': '2023-01-01T00:00:00.000Z',
  };

  final todoEntity = TodoEntity(
    id: '1',
    title: 'Test Todo',
    completed: false,
    createdAt: DateTime.parse('2023-01-01T00:00:00.000Z'),
  );

  group('loadTodos', () {
    test('should return list of todos when data source returns data', () async {
      when(
        () => mockDataSource.loadTodos(),
      ).thenAnswer((_) async => [mockTodoData]);

      final result = await repository.loadTodos();

      expect(result, isA<List<TodoEntity>>());
      expect(result.length, 1);
      expect(result[0].id, '1');
      expect(result[0].title, 'Test Todo');
      verify(() => mockDataSource.loadTodos()).called(1);
    });

    test('should return empty list when data source returns empty', () async {
      when(() => mockDataSource.loadTodos()).thenAnswer((_) async => []);

      final result = await repository.loadTodos();

      expect(result, isEmpty);
      verify(() => mockDataSource.loadTodos()).called(1);
    });
  });

  group('saveTodos', () {
    test('should call data source with correct data', () async {
      final todos = [todoEntity];
      when(() => mockDataSource.saveTodos(any())).thenAnswer((_) async => {});

      await repository.saveTodos(todos);

      verify(
        () => mockDataSource.saveTodos([
          {
            'id': '1',
            'title': 'Test Todo',
            'completed': false,
            'createdAt': '2023-01-01T00:00:00.000Z',
          },
        ]),
      ).called(1);
    });
  });

  group('addTodo', () {
    test('should add todo to existing list', () async {
      when(
        () => mockDataSource.loadTodos(),
      ).thenAnswer((_) async => [mockTodoData]);
      when(() => mockDataSource.saveTodos(any())).thenAnswer((_) async => {});

      final newTodo = TodoEntity(
        id: '2',
        title: 'New Todo',
        completed: true,
        createdAt: DateTime.now(),
      );

      await repository.addTodo(newTodo);

      verify(() => mockDataSource.saveTodos(any(that: hasLength(2)))).called(1);
    });
  });

  group('updateTodo', () {
    test('should update existing todo', () async {
      when(
        () => mockDataSource.loadTodos(),
      ).thenAnswer((_) async => [mockTodoData]);
      when(() => mockDataSource.saveTodos(any())).thenAnswer((_) async => {});

      final updatedTodo = todoEntity.copyWith(completed: true);
      await repository.updateTodo(updatedTodo);

      verify(() => mockDataSource.saveTodos(any())).called(1);
    });
  });

  group('deleteTodo', () {
    test('should delete todo by id', () async {
      when(
        () => mockDataSource.loadTodos(),
      ).thenAnswer((_) async => [mockTodoData]);
      when(() => mockDataSource.saveTodos(any())).thenAnswer((_) async => {});

      await repository.deleteTodo('1');

      verify(() => mockDataSource.saveTodos([])).called(1);
    });
  });
}
