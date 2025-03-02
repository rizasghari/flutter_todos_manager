import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_todos_manager/core/constants/colors.dart';
import 'package:flutter_todos_manager/core/widgets/date_tile.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({super.key});

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  final startDate = DateTime.now();
  final endDate = DateTime.now().add(const Duration(days: 365));

  DateTime currentWeekStartDate = DateTime.now();
  DateTime currentWeekEndDate = DateTime.now().add(Duration(days: 7));

  final PageController _pageController = PageController(initialPage: 0);

  int _currentWeekIndex = 0;

  DateTime _selectedDate = DateTime.now();

  void _updateCurrentWeek(DateTime startDate) {
    currentWeekStartDate = startDate;
    currentWeekEndDate = startDate.add(Duration(days: 7));
  }

  int _calculateTotalWeeks(DateTime startDate, DateTime endDate) {
    int totalDays = endDate.difference(startDate).inDays;
    return (totalDays / 7).ceil();
  }

  void _updateSelectedDate(DateTime selectedDate) {
    setState(() {
      _selectedDate = selectedDate;
      debugPrint("Selected Date: $_selectedDate");
    });
  }

  @override
  Widget build(BuildContext context) {
    int totalWeeks = _calculateTotalWeeks(startDate, endDate);

    return Column(
      children: [
        _navigation(),
        SizedBox(
          height: 100,
          child: PageView.builder(
            controller: _pageController,
            physics: PageScrollPhysics(),
            onPageChanged: (index) {
              setState(() {
                _currentWeekIndex = index;
              });
            },
            itemCount: totalWeeks,
            itemBuilder: (context, pageIndex) {
              DateTime weekStart = startDate.add(Duration(days: pageIndex * 7));
              _updateCurrentWeek(weekStart);
              List<Widget> dayTiles = List.generate(
                7,
                (dayOffset) {
                  DateTime date = weekStart.add(Duration(days: dayOffset));
                  return DateTile(
                    date: date,
                    isSelected: date.day == _selectedDate.day &&
                        date.month == _selectedDate.month &&
                        date.year == _selectedDate.year,
                    isDisabled: date.isBefore(DateTime.now().add(Duration(days: -1))),
                    selectedDate: _selectedDate,
                    onDateSelected: _updateSelectedDate,
                  );
                },
              );
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: dayTiles,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _navigation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: SvgPicture.asset('assets/icons/left.svg'),
          onPressed: () {
            _pageController.previousPage(
              duration: Duration(milliseconds: 300),
              curve: Curves.ease,
            );
          },
        ),
        Text(
          _getCurrentWeekDateRange(),
          style: TextStyle(
            fontSize: 20,
            color: purpleColor,
          ),
        ),
        IconButton(
          icon: SvgPicture.asset('assets/icons/right.svg'),
          onPressed: () {
            _pageController.nextPage(
              duration: Duration(milliseconds: 300),
              curve: Curves.ease,
            );
          },
        ),
      ],
    );
  }

  String _getCurrentWeekDateRange() {
    debugPrint("Start: $currentWeekStartDate End: $currentWeekEndDate");
    var startDay =
        "${currentWeekStartDate.day.toString().padLeft(2, '0')} ${DateFormat('MMM').format(currentWeekStartDate)}";
    var endDay =
        "${currentWeekEndDate.day.toString().padLeft(2, '0')} ${DateFormat('MMM').format(currentWeekEndDate)}";
    return "$startDay - $endDay";
  }
}
