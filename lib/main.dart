import 'package:flutter/material.dart';
import 'package:flutter_todos_manager/features/todo/presentation/views/home_page.dart';
import 'package:flutter_todos_manager/features/todo/presentation/views/todo_list_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(ProviderScope(
    child: const App(),
  ));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
      ),
      home: HomePage(),
    );
  }
}
