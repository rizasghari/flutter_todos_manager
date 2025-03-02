import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/date_picker.dart';
import '../../../../core/widgets/gradient_button.dart';

class CreateNewTodoPage extends ConsumerWidget {
  const CreateNewTodoPage({super.key});

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
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                _calendar(),
                _schedule(),
              ],
            ),
          ),
        ),
        _stickyFooter(),
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

  Widget _schedule() {
    return Container();
  }
}
