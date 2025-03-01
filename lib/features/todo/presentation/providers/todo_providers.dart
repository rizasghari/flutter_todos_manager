import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/interceptors/logger_interceptor.dart';
import '../../data/datasources/todo_api_datasource.dart';
import '../../data/repositories/todo_repository_impl.dart';
import '../../domain/entities/todo.dart';
import '../../domain/repositories/todo_repository.dart';
import '../viewmodels/todo_list_viewmodel.dart';

final dioProvider = Provider<Dio>((ref) {
  var dio = Dio();
  dio.options.baseUrl = 'https://dummyjson.com';
  dio.options.connectTimeout = Duration(seconds: 5);
  dio.options.receiveTimeout = Duration(seconds: 3);
  dio.interceptors.add(LoggerInterceptor());
  return dio;
});

final todoAPIDatasourceProvider = Provider<ApiTodoDataSource>((ref) {
  final dio = ref.watch(dioProvider);
  return ApiTodoDataSource(dio: dio);
});

final todoRepositoryProvider = Provider<TodoRepository>((ref) {
  final datasource = ref.watch(todoAPIDatasourceProvider);
  return TodoRepositoryImpl(apiTodoDataSource: datasource);
});

final todoListProvider =
StateNotifierProvider<TodoListViewModel, AsyncValue<List<Todo>>>((ref) {
  final repo = ref.watch(todoRepositoryProvider);
  return TodoListViewModel(repo);
});
