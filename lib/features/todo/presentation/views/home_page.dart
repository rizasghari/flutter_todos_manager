import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/section_title.dart';
import '../../../../core/widgets/task_tile.dart';
import '../../domain/entities/todo.dart';
import '../providers/todo_providers.dart';
import '../viewmodels/todo_list_viewmodel.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late AsyncValue<List<Todo>> tasks;
  late TodoListViewModel viewModel;
  double progress = 0.0;

  void onTaskToggle(int id) {
    viewModel.toggleTodoStatus(id);
  }

  void _setProgress(double percentage) async {
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      progress = percentage;
    });
  }

  @override
  Widget build(BuildContext context) {
    tasks = ref.watch(todoListProvider);
    viewModel = ref.watch(todoListProvider.notifier);

    ref.listen<AsyncValue<List<Todo>>>(todoListProvider, (previous, next) {
      next.when(
        data: (todos) {
          var percentage = todos.where((t) => t.completed).length / todos.length;
          _setProgress(percentage);
        },
        loading: () {},
        error: (error, stack) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Error: $error')));
        },
      );
    });

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: _appBar(),
      body: _body(),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: [Color(0xFFDE83B0), Color(0xFFC59ADF)],
          ),
        ),
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.transparent,
          shape: CircleBorder(),
          child:
              const Icon(Icons.add, color: lightDarkBackgroundColor, size: 30),
        ),
      ),
    );
  }

  Widget _body() {
    return tasks.when(
      data: (data) => Padding(
        padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _progressSection(),
              SizedBox(height: 25),
              _tasksSection(DateTime.now()),
              SizedBox(height: 25),
              _tasksSection(DateTime.now().add(Duration(days: 1))),
            ],
          ),
        ),
      ),
      error: (err, stack) => Center(child: Text('Error: $err')),
      loading: () => Center(child: CircularProgressIndicator()),
    );
  }

  Widget _tasksSection(DateTime date) {
    return Column(children: [
      SectionTitle(
        title: date.day == DateTime.now().day
            ? "Today's Tasks"
            : "Tomorrow's Tasks",
        onSeeAllPressed: () {},
      ),
      SizedBox(height: 10),
      _todaysTasksList(addBottomPadding: date.day != DateTime.now().day),
    ]);
  }

  Widget _todaysTasksList({required bool addBottomPadding}) {
    return ListView.builder(
      shrinkWrap: true,
      // limits the height to its children
      physics: NeverScrollableScrollPhysics(),
      itemCount: tasks.value?.length ?? 0,
      padding: EdgeInsets.only(bottom: addBottomPadding ? 100 : 0),
      itemBuilder: (context, index) {
        return TaskTile(
          todo: tasks.value?[index].todo ?? "Task $index",
          completed: tasks.value?[index].completed ?? false,
          date: DateTime.now(),
          onToggle: (value) => onTaskToggle(tasks.value?[index].id ?? 0),
        );
      },
    );
  }

  Widget _progressSection() {
    return Column(
      children: [
        SectionTitle(
          title: "Progress",
          onSeeAllPressed: () {
            debugPrint("Progress");
          },
        ),
        _progressCard(),
      ],
    );
  }

  Widget _progressCard() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      height: 150,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: lightDarkBackgroundColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Daily Task",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          Text(
            "${tasks.value?.where((t) => t.completed).length}/${tasks.value?.length} Tasks Completed",
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.8),
              fontSize: 16,
            ),
          ),
          _progressBar(),
        ],
      ),
    );
  }

  Widget _progressBar() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "You are almost done go ahead",
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.8),
                fontSize: 14,
              ),
            ),
            Text(
              "${(progress * 100).round()}%",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Stack(
          children: [
            Container(
              width: double.infinity,
              height: 18,
              decoration: BoxDecoration(
                color: purpleColor.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth * progress;
                return AnimatedContainer(
                  duration: const Duration(seconds: 3),
                  curve: Curves.easeInCubic,
                  width: width,
                  height: 18,
                  decoration: BoxDecoration(
                    color: purpleColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: backgroundColor,
      toolbarHeight: 150,
      elevation: 0,
      flexibleSpace: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _appBarTitle(),
              _appBarProfile(),
            ],
          ),
        ),
      ),
      bottom: _searchBar(),
    );
  }

  PreferredSizeWidget _searchBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(50),
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
              decoration: InputDecoration(
                  filled: true,
                  fillColor: lightDarkBackgroundColor,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  hintText: 'Search tasks here...',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                  )))),
    );
  }

  Widget _appBarTitle() {
    return Text(
      'You have got 5 tasks\ntoday to complete!',
      style: TextStyle(
        color: Colors.white,
        fontSize: 25,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _appBarProfile() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        CircleAvatar(
          maxRadius: 35,
          minRadius: 35,
          child: Image.asset("assets/images/profile.png"),
        ),
        Positioned(
          right: 10,
          bottom: -5,
          child: Container(
            width: 15,
            height: 15,
            decoration: const BoxDecoration(
              color: orangeColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                "2",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
