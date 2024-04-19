import 'package:flutter/material.dart';
import 'package:klimo/utils/theme.dart';

class ChallengeCardHeader extends StatelessWidget {
  final String challengeCategory;
  final Widget icon;
  final Widget? trailing;
  final Color? textColor;
  const ChallengeCardHeader({
    Key? key,
    required this.challengeCategory,
    required this.icon,
    this.trailing,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                challengeCategory,
                style: context
                    .textTheme()
                    .headlineMedium
                    ?.copyWith(color: textColor ?? Palette.primary),
              ),
            ),
          ],
        ),
        if (trailing != null) trailing!,
      ],
    );
  }
}
