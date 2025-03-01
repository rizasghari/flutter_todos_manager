import 'dart:math';
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

  Future<void> addTodo(String title) async {
    final newTodo = Todo(
        id: Random().nextInt(10000), todo: title, completed: false, userId: 1);
    state = AsyncValue.data([...?state.value, newTodo]);
    try {
      await _repository.addTodo(newTodo);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> toggleTodoStatus(int id) async {
    final currentList = state.value ?? [];
    final idx = currentList.indexWhere((t) => t.id == id);
    if (idx == -1) return;
    final todo = currentList[idx];
    final updated =
        Todo(id: todo.id, todo: todo.todo, completed: !todo.completed, userId: todo.userId);

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
    state = AsyncValue.data(currentList.where((t) => t.id != id).toList());
    try {
      await _repository.deleteTodo(id);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
