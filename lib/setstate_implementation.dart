// setState Implementation
import 'package:flutter/material.dart';
import 'package:test_optimization_01/todo_entity.dart';

import 'dart:developer' as developer;

class SetStateScreen extends StatefulWidget {
  const SetStateScreen({super.key});

  @override
  _SetStateScreenState createState() => _SetStateScreenState();
}

class _SetStateScreenState extends State<SetStateScreen> {
  List<TodoEntity> todos = List.generate(
      1000, (index) => TodoEntity(id: '$index', title: 'Todo $index'));

  void toggleTodo(String id) {
    final stopwatch = Stopwatch()..start();
    setState(() {
      final todo = todos.firstWhere((t) => t.id == id);
      todo.isCompleted = !todo.isCompleted;
    });
    developer.log('setState toggle time: ${stopwatch.elapsedMicroseconds}µs');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('setState Demo')),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          final todo = todos[index];
          return ListTile(
            title: Text(todo.title),
            trailing: Checkbox(
              value: todo.isCompleted,
              onChanged: (_) => toggleTodo(todo.id),
            ),
          );
        },
      ),
    );
  }
}
