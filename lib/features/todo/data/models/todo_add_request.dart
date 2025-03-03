class TodoAddRequest {
  final String todo;
  final bool completed;
  final int userId;

  TodoAddRequest({
    required this.todo,
    required this.completed,
    required this.userId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['todo'] = todo;
    data['completed'] = completed;
    data['userId'] = userId;
    return data;
  }
}
