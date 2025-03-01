import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CircleCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  final String checkedIcon = 'assets/icons/checked.svg';
  final String uncheckedIcon = 'assets/icons/unchecked.svg';

  const CircleCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => onChanged(!value),
      icon: SvgPicture.asset(
        width: 25,
        height: 25,
        value ? checkedIcon : uncheckedIcon,
      ),
    );
  }
}
