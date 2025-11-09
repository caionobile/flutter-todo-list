import 'package:equatable/equatable.dart';

class TodoEntity extends Equatable {
  final String id;
  final String title;
  final bool completed;
  final DateTime createdAt;

  const TodoEntity({
    required this.id,
    required this.title,
    required this.completed,
    required this.createdAt,
  });

  TodoEntity copyWith({
    String? id,
    String? title,
    bool? completed,
    DateTime? createdAt,
  }) {
    return TodoEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      completed: completed ?? this.completed,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [id, title, completed, createdAt];
}
