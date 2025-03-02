import 'package:flutter/material.dart';
import 'package:flutter_todos_manager/core/constants/colors.dart';
import 'package:intl/intl.dart';

class DateTile extends StatefulWidget {
  final DateTime date;
  final ValueChanged<DateTime> onDateSelected;

  const DateTile({
    super.key,
    required this.date,
    required this.onDateSelected,
  });

  @override
  State<DateTile> createState() => _DateTileState();
}

class _DateTileState extends State<DateTile> {
  late bool isSelected;
  late bool isDisabled;

  @override
  void initState() {
    isSelected = false;
    isDisabled = false;
    super.initState();
  }

  void _onDateSelected() {
    setState(() {
      isSelected = !isSelected;
    });
    widget.onDateSelected(widget.date);
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
              DateFormat('EEE').format(widget.date),
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: isDisabled
                    ? Colors.grey
                    : isSelected
                        ? purpleColor
                        : Colors.white.withValues(alpha: 0.6),
              ),
            ),
            Text(
              DateFormat('d').format(widget.date).padLeft(2, '0'),
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: isDisabled
                    ? Colors.grey
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
