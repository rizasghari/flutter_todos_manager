import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_todos_manager/core/constants/colors.dart';

class TimePicker extends StatefulWidget {
  final String label;
  final ValueChanged<TimeOfDay> onTimeChanged;

  const TimePicker({
    super.key,
    required this.label,
    required this.onTimeChanged,
  });

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  TimeOfDay _selectedTime = TimeOfDay.now();

  void _showTimePicker(BuildContext context) async {
    Future<TimeOfDay?> selectedTime = showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
    );
    TimeOfDay? time = await selectedTime;
    if (time != null) {
      widget.onTimeChanged(time);
      setState(() {
        _selectedTime = time;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showTimePicker(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white.withValues(alpha: 0.8),
            ),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            decoration: BoxDecoration(
              color: lightDarkBackgroundColor,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icons/time.svg',
                  width: 24,
                  height: 24,
                ),
                SizedBox(width: 15),
                Text(
                  _selectedTime.format(context),
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withValues(alpha: 0.8),
                    letterSpacing: 2.5,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
