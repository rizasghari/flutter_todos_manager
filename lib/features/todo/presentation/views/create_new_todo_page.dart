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

class CreateNewTodoPage extends ConsumerStatefulWidget {
  CreateNewTodoPage({super.key});

  ConsumerState<CreateNewTodoPage> createState() => _CreateNewTodoPageState();
}

class _CreateNewTodoPageState extends ConsumerState<CreateNewTodoPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  TimeOfDay _startTime = TimeOfDay.now();
  TimeOfDay _endTime = TimeOfDay.now();
  Priority _priority = Priority.low;

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
              ],
            ),
          ),
        ),
        _stickyFooter(),
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
            child: TimePicker(
          label: "Start Time",
          onTimeChanged: (startTime) => _startTime = startTime,
        )),
        SizedBox(width: 15),
        Expanded(
            child: TimePicker(
          label: "End Time",
          onTimeChanged: (endTime) => _endTime = endTime,
        )),
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
          child: GradientButton(label: "Create Task", onPressed: () => {}),
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
    return DatePicker();
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
        TextField(
          controller: _titleController,
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
              )),
        ),
        SizedBox(height: 15),
        TextField(
          controller: _descriptionController,
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
              )),
        ),
      ],
    );
  }
}
