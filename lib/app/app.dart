import 'package:flutter/material.dart';

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To do list',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const SizedBox(),
    );
  }
}
