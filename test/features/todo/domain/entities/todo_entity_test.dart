import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo_list/features/todo/domain/entities/todo_entity.dart';

void main() {
  group('TodoEntity', () {
    test('should create todo entity with correct properties', () {
      final createdAt = DateTime.now();
      final todo = TodoEntity(
        id: '1',
        title: 'Test Todo',
        completed: false,
        createdAt: createdAt,
      );

      expect(todo.id, '1');
      expect(todo.title, 'Test Todo');
      expect(todo.completed, false);
      expect(todo.createdAt, createdAt);
    });

    test('should be equal when properties are same', () {
      final createdAt = DateTime.now();
      final todo1 = TodoEntity(
        id: '1',
        title: 'Test Todo',
        completed: false,
        createdAt: createdAt,
      );
      final todo2 = TodoEntity(
        id: '1',
        title: 'Test Todo',
        completed: false,
        createdAt: createdAt,
      );

      expect(todo1, todo2);
      expect(todo1.hashCode, todo2.hashCode);
    });

    test('should not be equal when properties are different', () {
      final createdAt = DateTime.now();
      final todo1 = TodoEntity(
        id: '1',
        title: 'Test Todo',
        completed: false,
        createdAt: createdAt,
      );
      final todo2 = TodoEntity(
        id: '2',
        title: 'Different Todo',
        completed: true,
        createdAt: createdAt,
      );

      expect(todo1, isNot(todo2));
    });

    test('should copy with new properties', () {
      final original = TodoEntity(
        id: '1',
        title: 'Original',
        completed: false,
        createdAt: DateTime.now(),
      );

      final copied = original.copyWith(title: 'Updated', completed: true);

      expect(copied.id, '1');
      expect(copied.title, 'Updated');
      expect(copied.completed, true);
      expect(copied.createdAt, original.createdAt);
    });

    test('should return correct props', () {
      final createdAt = DateTime.now();
      final todo = TodoEntity(
        id: '1',
        title: 'Test',
        completed: false,
        createdAt: createdAt,
      );

      expect(todo.props, ['1', 'Test', false, createdAt]);
    });
  });
}
