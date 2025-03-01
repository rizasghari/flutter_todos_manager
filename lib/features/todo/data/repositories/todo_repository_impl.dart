import '../../domain/entities/todo.dart';
import '../../domain/repositories/todo_repository.dart';
import '../datasources/todo_api_datasource.dart';

class TodoRepositoryImpl implements TodoRepository {
  final ApiTodoDataSource apiTodoDataSource;

  TodoRepositoryImpl({required this.apiTodoDataSource});

  final List<Todo> _store = [];

  @override
  Future<List<Todo>> fetchTodos() async {
    var todos = await apiTodoDataSource.fetchTodos();
    _store.addAll(todos);
    return List.unmodifiable(_store);
  }

  @override
  Future<void> addTodo(Todo todo) async {
    _store.add(todo);
  }

  @override
  Future<void> updateTodo(Todo todo) async {
    final index = _store.indexWhere((t) => t.id == todo.id);
    if (index != -1) {
      _store[index] = todo;
    }
  }

  @override
  Future<void> deleteTodo(int id) async {
    _store.removeWhere((t) => t.id == id);
  }
}
