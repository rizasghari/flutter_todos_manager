import 'package:flutter/material.dart';
import 'package:flutter_todos_manager/core/constants/colors.dart';

import 'circle_checkbox.dart';

class TaskTile extends StatelessWidget {
  final String todo;
  final DateTime date;
  final bool completed;
  final ValueChanged<bool> onToggle;

  const TaskTile({
    super.key,
    required this.todo,
    required this.date,
    required this.completed,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 90,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 15,
              height: 80,
              decoration: BoxDecoration(
                color: completed ? Colors.greenAccent : Colors.redAccent,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  color: lightDarkBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            todo,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          SizedBox(height: 5),
                          Row(children: [
                            Icon(
                              Icons.calendar_today_outlined,
                              size: 16,
                              color: Colors.white.withValues(alpha: 0.8),
                            ),
                            SizedBox(width: 5),
                            Text(
                              "${date.day}/${date.month}/${date.year}",
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.8),
                                fontSize: 16,
                              ),
                            ),
                            Spacer(),
                          ])
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child:
                          CircleCheckbox(value: completed, onChanged: onToggle),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
