import 'package:dio/dio.dart';

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
}
