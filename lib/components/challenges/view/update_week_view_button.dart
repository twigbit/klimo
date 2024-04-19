import 'package:flutter/material.dart';

class UpdateWeekViewButton extends StatelessWidget {
  final IconData icon;
  final Function() onPressed;

  const UpdateWeekViewButton({
    Key? key,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        constraints: const BoxConstraints(),
        icon: Icon(
          icon,
          size: 24,
        ),
        onPressed: onPressed);
  }
}
