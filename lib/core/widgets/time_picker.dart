import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_todos_manager/core/constants/colors.dart';

class TimePicker extends StatelessWidget {
  final String label;

  const TimePicker({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white.withValues(alpha: 0.8),
          ),
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: lightDarkBackgroundColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/icons/time.svg',
                width: 24,
                height: 24,
              ),
              SizedBox(width: 10),
              Text(
                '00:00',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white.withValues(alpha: 0.8),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
