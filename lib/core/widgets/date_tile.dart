import 'package:flutter/material.dart';
import 'package:flutter_todos_manager/core/constants/colors.dart';
import 'package:intl/intl.dart';

class DateTile extends StatelessWidget {
  final DateTime date;
  final bool isSelected;
  final bool isDisabled;
  final ValueChanged<DateTime> onDateSelected;

  const DateTile({
    super.key,
    required this.date,
    required this.onDateSelected,
    required this.isSelected,
    required this.isDisabled,
  });

  void _onDateSelected() {
    onDateSelected(date);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onDateSelected(),
      child: Container(
        height: 75,
        width: 50,
        decoration: isSelected
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: purpleColor,
                  width: 2,
                ),
              )
            : null,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DateFormat('EEE').format(date),
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: isDisabled
                    ? Colors.white.withValues(alpha: 0.3)
                    : isSelected
                        ? purpleColor
                        : Colors.white.withValues(alpha: 0.6),
              ),
            ),
            Text(
              DateFormat('d').format(date).padLeft(2, '0'),
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: isDisabled
                    ? Colors.white.withValues(alpha: 0.3)
                    : isSelected
                        ? purpleColor
                        : Colors.white.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
