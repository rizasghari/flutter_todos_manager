import 'package:flutter/material.dart';
import 'package:flutter_todos_manager/features/todo/domain/entities/priority.dart';

import '../constants/colors.dart';

class PriorityTile extends StatelessWidget {
  final Color color;
  final Priority priority;
  final bool isSelected;
  final VoidCallback onTap;

  const PriorityTile({
    super.key,
    required this.color,
    required this.priority,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: lightDarkBackgroundColor,
          border: isSelected ? Border.all(color: color, width: 2) : null,
        ),
        child: Center(
          child: Text(
            priority.label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
