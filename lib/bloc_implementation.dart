// BLoC Implementation
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_optimization_01/todo_entity.dart';
import 'dart:developer' as developer;

class TodoEvent {}

class ToggleTodo extends TodoEvent {
  final String id;
  ToggleTodo(this.id);
}

class TodoState {
  final List<TodoEntity> todos;
  TodoState(this.todos);
}

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc()
      : super(TodoState(List.generate(
            1000, (index) => TodoEntity(id: '$index', title: 'Todo $index')))) {
    on<ToggleTodo>((event, emit) {
      final stopwatch = Stopwatch()..start();
      final newTodos = state.todos.map((todo) {
        if (todo.id == event.id) {
          return TodoEntity(
              id: todo.id, title: todo.title, isCompleted: !todo.isCompleted);
        }
        return todo;
      }).toList();
      emit(TodoState(newTodos));
      developer.log('BLoC toggle time: ${stopwatch.elapsedMicroseconds}µs');
    });
  }
}

class BlocScreen extends StatelessWidget {
  const BlocScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TodoBloc(),
      child: Scaffold(
        appBar: AppBar(title: const Text('BLoC Demo')),
        body: BlocBuilder<TodoBloc, TodoState>(
          builder: (context, state) {
            return ListView.builder(
              itemCount: state.todos.length,
              itemBuilder: (context, index) {
                final todo = state.todos[index];
                return ListTile(
                  title: Text(todo.title),
                  trailing: Checkbox(
                    value: todo.isCompleted,
                    onChanged: (_) =>
                        context.read<TodoBloc>().add(ToggleTodo(todo.id)),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
