import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/date_picker.dart';
import '../../../../core/widgets/gradient_button.dart';
import '../../../../core/widgets/priority_tile.dart';
import '../../../../core/widgets/time_picker.dart';
import '../../domain/entities/priority.dart';
import '../providers/todo_providers.dart';
import '../viewmodels/todo_list_viewmodel.dart';

class CreateNewTodoPage extends ConsumerStatefulWidget {
  const CreateNewTodoPage({super.key});

  @override
  ConsumerState<CreateNewTodoPage> createState() => _CreateNewTodoPageState();
}

class _CreateNewTodoPageState extends ConsumerState<CreateNewTodoPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  TimeOfDay _startTime = TimeOfDay.now();
  TimeOfDay _endTime = TimeOfDay.now();
  Priority _priority = Priority.low;
  bool _getAlert = false;

  late final TodoListViewModel viewModel;

  @override
  void initState() {
    viewModel = ref.read(todoListProvider.notifier);
    super.initState();
  }

  void _addTask() async {
    var result = await viewModel.addTodo(
      _selectedDate,
      _titleController.text,
      _descriptionController.text,
      _startTime,
      _endTime,
      _priority,
      _getAlert,
    );
    if (result && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Task added successfully'),
        ),
      );
      context.pop();
      var _ = ref.refresh(todoListProvider);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to add task'),
        ),
      );
    }
  }

  void _onPrioritySelected(Priority priority) {
    setState(() {
      _priority = priority;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: _appBar(),
      body: _body(),
    );
  }

  Widget _body() {
    return Stack(
      fit: StackFit.expand,
      children: [
        SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 100),
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _calendar(),
                  SizedBox(height: 20),
                  _titleAndDescription(),
                  SizedBox(height: 20),
                  _timePicker(),
                  SizedBox(height: 20),
                  _prioritySelection(),
                  SizedBox(height: 30),
                  _setAlert(),
                ],
              ),
            ),
          ),
        ),
        _stickyFooter(),
      ],
    );
  }

  Widget _setAlert() {
    return Row(
      children: [
        Text(
          "Get alert for this task",
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.8),
            fontSize: 18,
          ),
        ),
        Spacer(),
        Switch(
          value: _getAlert,
          activeColor: Colors.white,
          activeTrackColor: Color(0XFFA378FF),
          onChanged: (value) {
            setState(() {
              _getAlert = value;
            });
          },
        ),
      ],
    );
  }

  Widget _prioritySelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Priority",
          style: TextStyle(
            fontSize: 18,
            color: Colors.white.withValues(alpha: 0.8),
          ),
        ),
        SizedBox(height: 15),
        Row(children: [
          Expanded(
            flex: 1,
            child: PriorityTile(
              priority: Priority.high,
              color: Color(0XFFFACBBA),
              isSelected: _priority == Priority.high,
              onTap: () => _onPrioritySelected(Priority.high),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            flex: 1,
            child: PriorityTile(
              priority: Priority.medium,
              color: Color(0XFFD7F0FF),
              isSelected: _priority == Priority.medium,
              onTap: () => _onPrioritySelected(Priority.medium),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            flex: 1,
            child: PriorityTile(
              priority: Priority.low,
              color: Color(0XFFFAD9FF),
              isSelected: _priority == Priority.low,
              onTap: () => _onPrioritySelected(Priority.low),
            ),
          ),
        ])
      ],
    );
  }

  Widget _timePicker() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: FormField<TimeOfDay>(
            initialValue: _startTime,
            validator: (value) {
              if (value == null ||
                  value.isAfter(_endTime) ||
                  value.isAtSameTimeAs(_endTime)) {
                return "Invalid start time";
              }
              return null;
            },
            builder: (state) {
              return TimePicker(
                label: "Start Time",
                onTimeChanged: (startTime) {
                  _startTime = startTime;
                  state.didChange(startTime);
                },
              );
            },
          ),
        ),
        SizedBox(width: 15),
        Expanded(
          child: FormField<TimeOfDay>(
            initialValue: _endTime,
            validator: (value) {
              if (value == null ||
                  value.isBefore(_startTime) ||
                  value.isAtSameTimeAs(_startTime)) {
                return "Invalid end time";
              }
              return null;
            },
            builder: (state) {
              return TimePicker(
                label: "End Time",
                onTimeChanged: (endTime) {
                  _endTime = endTime;
                  state.didChange(endTime);
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _stickyFooter() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        width: double.infinity,
        height: 50,
        color: backgroundColor,
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: GradientButton(
            label: "Create Task",
            onPressed: () => {
              if (_formKey.currentState!.validate())
                {
                  _addTask(),
                }
              else
                {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please fill all the fields'),
                    ),
                  )
                },
            },
          ),
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: backgroundColor,
      title: Text(
        'New Todo',
        style: TextStyle(color: Colors.white, fontSize: 25),
      ),
      centerTitle: true,
      leading: Builder(builder: (context) {
        return Padding(
          padding: EdgeInsets.all(5),
          child: IconButton(
            onPressed: context.pop,
            icon: SvgPicture.asset(
              'assets/icons/back.svg',
            ),
          ),
        );
      }),
    );
  }

  Widget _calendar() {
    return DatePicker(onDateSelected: (selectedDate) {
      setState(() {
        _selectedDate = selectedDate;
      });
    });
  }

  Widget _titleAndDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Schedule",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        SizedBox(height: 10),
        TextFormField(
          controller: _titleController,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: lightDarkBackgroundColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            hintText: "Name",
            hintStyle: TextStyle(
              color: Colors.white.withValues(alpha: 0.8),
              fontSize: 16,
            ),
          ),
          validator: (vale) {
            if (vale == null || vale.isEmpty) {
              return "Please enter a name";
            }
            return null;
          },
        ),
        SizedBox(height: 15),
        TextFormField(
          controller: _descriptionController,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
          maxLines: 4,
          minLines: 4,
          decoration: InputDecoration(
            filled: true,
            fillColor: lightDarkBackgroundColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            hintText: "Description",
            hintStyle: TextStyle(
              color: Colors.white.withValues(alpha: 0.8),
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
