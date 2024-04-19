import 'package:flutter/material.dart';
import 'package:klimo/utils/theme.dart';

class SettingsSectionHeader extends StatelessWidget {
  final String text;

  const SettingsSectionHeader({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
            child: Text(
              text,
              style: context.textTheme().labelSmall,
            ),
          ),
        ),
      ],
    );
  }
}
