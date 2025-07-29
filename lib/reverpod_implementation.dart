// Riverpod Implementation
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_optimization_01/todo_entity.dart';

import 'dart:developer' as developer;

final todoProvider =
    StateNotifierProvider<TodoNotifier, List<TodoEntity>>((ref) {
  return TodoNotifier();
});

class TodoNotifier extends StateNotifier<List<TodoEntity>> {
  TodoNotifier()
      : super(List.generate(
            1000, (index) => TodoEntity(id: '$index', title: 'Todo $index')));

  void toggleTodo(String id) {
    final stopwatch = Stopwatch()..start();
    state = [
      for (final todo in state)
        if (todo.id == id)
          TodoEntity(
              id: todo.id, title: todo.title, isCompleted: !todo.isCompleted)
        else
          todo
    ];
    developer.log('Riverpod toggle time: ${stopwatch.elapsedMicroseconds}µs');
  }
}

class ReverpodProviderScope extends StatelessWidget {
  const ReverpodProviderScope({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProviderScope(child: RiverpodScreen());
  }
}

class RiverpodScreen extends ConsumerWidget {
  const RiverpodScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Riverpod Demo')),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          final todo = todos[index];
          return ListTile(
            title: Text(todo.title),
            trailing: Checkbox(
              value: todo.isCompleted,
              onChanged: (_) =>
                  ref.read(todoProvider.notifier).toggleTodo(todo.id),
            ),
          );
        },
      ),
    );
  }
}
