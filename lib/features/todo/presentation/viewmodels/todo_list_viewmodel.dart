import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_todos_manager/features/todo/domain/entities/priority.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../domain/entities/todo.dart';
import '../../domain/repositories/todo_repository.dart';

class TodoListViewModel extends StateNotifier<AsyncValue<List<Todo>>> {
  final TodoRepository _repository;

  TodoListViewModel(this._repository) : super(const AsyncValue.loading()) {
    _loadTodos();
  }

  Future<void> _loadTodos() async {
    try {
      final todos = await _repository.fetchTodos();
      state = AsyncValue.data(todos);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<bool> addTodo(
    DateTime date,
    String title,
    String description,
    TimeOfDay startTime,
    TimeOfDay endTime,
    Priority priority,
    bool hasAlert,
  ) async {
    state = const AsyncValue.loading();
    final newTodo = Todo(
      id: Random().nextInt(10000),
      todo: title,
      description: description,
      completed: false,
      userId: 1,
      date: date,
      startTime: startTime,
      endTime: endTime,
      priority: priority,
      hasAlert: hasAlert,
    );
    try {
      await _repository.addTodo(newTodo);
      return true;
    } catch (e, st) {
      return false;
    }
  }

  Future<void> toggleTodoStatus(int id) async {
    final currentList = state.value ?? [];
    final idx = currentList.indexWhere((t) => t.id == id);
    if (idx == -1) return;
    final todo = currentList[idx];
    final updated = Todo(
        id: todo.id,
        todo: todo.todo,
        completed: !todo.completed,
        userId: todo.userId,
        date: todo.date,
        startTime: todo.startTime,
        endTime: todo.endTime,
        priority: todo.priority,
        hasAlert: todo.hasAlert,
        description: todo.description
    );

    final newList = [...currentList];
    newList[idx] = updated;
    state = AsyncValue.data(newList);
    try {
      await _repository.updateTodo(updated);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteTodo(int id) async {
    final currentList = state.value ?? [];
    final newList = currentList.where((t) => t.id != id).toList();
    state = AsyncValue.data(newList);
    try {
      await _repository.deleteTodo(id);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
