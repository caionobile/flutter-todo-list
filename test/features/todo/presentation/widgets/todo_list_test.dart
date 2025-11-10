import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo_list/features/todo/domain/entities/todo_entity.dart';
import 'package:flutter_todo_list/features/todo/presentation/providers/todo_provider.dart';
import 'package:flutter_todo_list/features/todo/presentation/widgets/todo_list.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

class MockTodoProvider extends Mock implements TodoProvider {}

void main() {
  late MockTodoProvider mockProvider;

  setUp(() {
    mockProvider = MockTodoProvider();
  });

  Widget createWidgetUnderTest({TodoFilter filter = TodoFilter.all}) {
    return MaterialApp(
      home: ChangeNotifierProvider<TodoProvider>.value(
        value: mockProvider,
        child: TodoList(filter: filter),
      ),
    );
  }

  testWidgets('should show loading indicator when isLoading is true', (
    tester,
  ) async {
    when(() => mockProvider.isLoading).thenReturn(true);
    when(() => mockProvider.todos).thenReturn([]);

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('should show todos when not loading', (tester) async {
    when(() => mockProvider.isLoading).thenReturn(false);
    when(() => mockProvider.todos).thenReturn([
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
        createdAt: DateTime.now(),
      ),
    ]);

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text('Test Todo 1'), findsOneWidget);
    expect(find.text('Test Todo 2'), findsOneWidget);
  });

  testWidgets('should filter pending todos', (tester) async {
    when(() => mockProvider.isLoading).thenReturn(false);
    when(() => mockProvider.todos).thenReturn([
      TodoEntity(
        id: '1',
        title: 'Pending Todo',
        completed: false,
        createdAt: DateTime.now(),
      ),
      TodoEntity(
        id: '2',
        title: 'Completed Todo',
        completed: true,
        createdAt: DateTime.now(),
      ),
    ]);

    await tester.pumpWidget(createWidgetUnderTest(filter: TodoFilter.pending));

    expect(find.text('Pending Todo'), findsOneWidget);
    expect(find.text('Completed Todo'), findsNothing);
  });

  testWidgets('should filter completed todos', (tester) async {
    when(() => mockProvider.isLoading).thenReturn(false);
    when(() => mockProvider.todos).thenReturn([
      TodoEntity(
        id: '1',
        title: 'Pending Todo',
        completed: false,
        createdAt: DateTime.now(),
      ),
      TodoEntity(
        id: '2',
        title: 'Completed Todo',
        completed: true,
        createdAt: DateTime.now(),
      ),
    ]);

    await tester.pumpWidget(createWidgetUnderTest(filter: TodoFilter.done));

    expect(find.text('Pending Todo'), findsNothing);
    expect(find.text('Completed Todo'), findsOneWidget);
  });
}
