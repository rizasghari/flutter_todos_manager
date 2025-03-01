import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/section_title.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: _appBar(),
      body: _body(),
    );
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
      child: SingleChildScrollView(
          child: Column(children: [
        _progressSection(),
      ])),
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
            "2/3 Tasks Completed",
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
              "66%",
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
                final width = constraints.maxWidth * 0.66;
                return Container(
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
      bottom: PreferredSize(
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
      ),
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
