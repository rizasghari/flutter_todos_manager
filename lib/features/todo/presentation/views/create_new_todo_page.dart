import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/date_picker.dart';
import '../../../../core/widgets/gradient_button.dart';
import '../../../../core/widgets/time_picker.dart';

class CreateNewTodoPage extends ConsumerWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  CreateNewTodoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              ],
            ),
          ),
        ),
        _stickyFooter(),
      ],
    );
  }

  Widget _timePicker() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: TimePicker(label: "Start Time")),
        SizedBox(
          width: 15,
        ),
        Expanded(child: TimePicker(label: "End Time")),
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
        height: 100,
        color: backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
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
            fontSize: 22,
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
