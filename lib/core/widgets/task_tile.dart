import 'package:flutter/material.dart';
import 'package:flutter_todos_manager/core/constants/colors.dart';

class TaskTile extends StatelessWidget {
  final String todo;
  final DateTime date;
  final bool completed;

  const TaskTile({
    super.key,
    required this.todo,
    required this.date,
    required this.completed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          color: lightDarkBackgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    todo,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
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
              child: Checkbox(
                value: completed,
                onChanged: (value) {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
