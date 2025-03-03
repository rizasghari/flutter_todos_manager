import 'package:dio/dio.dart';
import 'package:flutter_todos_manager/features/todo/data/models/todo_add_request.dart';

import '../../domain/entities/todo.dart';
import '../models/todo_api_response.dart';

class ApiTodoDataSource {
  final Dio dio;

  ApiTodoDataSource({required this.dio});

  Future<List<Todo>> fetchTodos({int skip = 0, int limit = 30}) async {
    final response = await dio.get(
      '/todos',
      queryParameters: {
        'skip': skip,
        'limit': limit,
      },
    );

    if (response.statusCode == 200) {
      final apiResponse = TodoApiResponse.fromJson(response.data);
      return apiResponse.todos;
    } else {
      throw Exception('Failed to load todos');
    }
  }

  Future<Todo> addTodo(Todo todo) async {
    final todoRequest = TodoAddRequest(
      todo: todo.todo,
      completed: todo.completed,
      userId: todo.userId,
    );
    final response = await dio.post('/todos/add',
        data: todoRequest.toJson(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ));

    if (response.statusCode == 201) {
      final addedTodo = Todo.fromJson(response.data);
      return addedTodo;
    } else {
      throw Exception('Failed to add todo Error: ${response.data}');
    }
  }
}
