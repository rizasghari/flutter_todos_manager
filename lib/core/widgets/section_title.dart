import 'package:flutter/material.dart';

import '../constants/colors.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final VoidCallback onSeeAllPressed;

  const SectionTitle(
      {super.key, required this.title, required this.onSeeAllPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          TextButton(
            onPressed: onSeeAllPressed,
            child: Text(
              'See All',
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: 16,
                color: purpleColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ]);
  }
}
