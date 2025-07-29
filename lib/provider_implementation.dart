// Provider Implementation
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_optimization_01/todo_entity.dart';

import 'dart:developer' as developer;

class TodoProvider with ChangeNotifier {
  List<TodoEntity> todos = List.generate(
      1000, (index) => TodoEntity(id: '$index', title: 'Todo $index'));

  void toggleTodo(String id) {
    final stopwatch = Stopwatch()..start();
    final todo = todos.firstWhere((t) => t.id == id);
    todo.isCompleted = !todo.isCompleted;
    notifyListeners();
    developer.log('Provider toggle time: ${stopwatch.elapsedMicroseconds}µs');
  }
}

class ProviderScreen extends StatelessWidget {
  const ProviderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Provider Demo')),
      body: Consumer<TodoProvider>(
        builder: (context, provider, child) => ListView.builder(
          itemCount: provider.todos.length,
          itemBuilder: (context, index) {
            final todo = provider.todos[index];
            return ListTile(
              title: Text(todo.title),
              trailing: Checkbox(
                value: todo.isCompleted,
                onChanged: (_) => provider.toggleTodo(todo.id),
              ),
            );
          },
        ),
      ),
    );
  }
}
