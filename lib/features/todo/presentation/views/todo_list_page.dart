import 'dart:math';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import '../providers/todo_providers.dart';

class TodoListPage extends ConsumerWidget {
  const TodoListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoListState = ref.watch(todoListProvider);
    final todoListVM = ref.read(todoListProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: Text('My To-Do List')),
      body: todoListState.when(
        data: (todos) => ListView(
          children: [
            for (var todo in todos) ListTile(
              title: Text(todo.todo),
              leading: Checkbox(
                value: todo.completed,
                onChanged: (_) => todoListVM.toggleTodoStatus(todo.id),
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => todoListVM.deleteTodo(todo.id),
              ),
            )
          ],
        ),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (err, st) => Center(child: Text('Error: $err')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var random = Random();
          todoListVM.addTodo('New Task ${random.nextInt(1000)}');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
