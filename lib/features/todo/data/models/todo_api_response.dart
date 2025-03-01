import '../../domain/entities/todo.dart';

class TodoApiResponse {
  final List<Todo> todos;
  final int total;
  final int skip;
  final int limit;

  TodoApiResponse({
    required this.todos,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory TodoApiResponse.fromJson(Map<String, dynamic> json) {
    return TodoApiResponse(
      todos: (json['todos'] as List<dynamic>)
          .map((item) => Todo.fromJson(item as Map<String, dynamic>))
          .toList(),
      total: json['total'] as int,
      skip: json['skip'] as int,
      limit: json['limit'] as int,
    );
  }
}
