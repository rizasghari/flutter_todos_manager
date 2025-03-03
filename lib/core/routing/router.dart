import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/todo/presentation/views/create_new_todo_page.dart';
import '../../features/todo/presentation/views/home_page.dart';

final router = GoRouter(routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => const HomePage(),
    routes: [
      GoRoute(
        path: 'create',
        pageBuilder: (BuildContext context, GoRouterState state) {
          return CustomTransitionPage<void>(
            key: state.pageKey,
            child: CreateNewTodoPage(),
            barrierDismissible: true,
            barrierColor: Colors.black38,
            opaque: false,
            transitionDuration: const Duration(milliseconds: 500),
            reverseTransitionDuration: const Duration(milliseconds: 200),
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          );
        },
      ),
    ],
  ),
]);
