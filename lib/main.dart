import 'package:flutter/material.dart';
import 'package:flutter_todo_list/features/todo/data/datasources/todo_local_data_source.dart';
import 'package:flutter_todo_list/features/todo/data/repositories/todo_repository_impl.dart';
import 'package:flutter_todo_list/features/todo/domain/usecases/add_todo_usecase.dart';
import 'package:flutter_todo_list/features/todo/domain/usecases/delete_todo_usecase.dart';
import 'package:flutter_todo_list/features/todo/domain/usecases/load_todos_usecase.dart';
import 'package:flutter_todo_list/features/todo/domain/usecases/update_todo_usecase.dart';
import 'package:flutter_todo_list/features/todo/presentation/pages/home_page.dart';
import 'package:flutter_todo_list/features/todo/presentation/providers/todo_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => TodoLocalDataSourceImpl()),
        Provider(
          create: (context) => TodoRepositoryImpl(
            localDataSource: context.read<TodoLocalDataSourceImpl>(),
          ),
        ),
        Provider(
          create: (context) =>
              LoadTodosUseCase(repository: context.read<TodoRepositoryImpl>()),
        ),
        Provider(
          create: (context) =>
              AddTodoUseCase(repository: context.read<TodoRepositoryImpl>()),
        ),
        Provider(
          create: (context) =>
              UpdateTodoUseCase(repository: context.read<TodoRepositoryImpl>()),
        ),
        Provider(
          create: (context) =>
              DeleteTodoUseCase(repository: context.read<TodoRepositoryImpl>()),
        ),
        ChangeNotifierProvider(
          create: (context) => TodoProvider(
            loadTodosUseCase: context.read<LoadTodosUseCase>(),
            addTodoUseCase: context.read<AddTodoUseCase>(),
            updateTodoUseCase: context.read<UpdateTodoUseCase>(),
            deleteTodoUseCase: context.read<DeleteTodoUseCase>(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'To do list',
        theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
        home: const HomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
