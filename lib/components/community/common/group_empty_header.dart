import 'package:flutter/material.dart';
import 'package:klimo/utils/theme.dart';

class GroupEmptyHeader extends StatelessWidget {
  final String title;
  final Widget? primaryActionButton;
  final Widget? secondaryActionButton;
  final Widget? body;

  const GroupEmptyHeader({
    Key? key,
    required this.title,
    this.primaryActionButton,
    this.secondaryActionButton,
    this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "🙋‍♀️",
          style: TextStyle(
            fontSize: 40,
          ),
        ),
        Text(
          title,
          style: context.textTheme().displaySmall,
          textAlign: TextAlign.center,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (primaryActionButton != null) primaryActionButton!,
                if (secondaryActionButton != null) secondaryActionButton!,
                if (body != null) body!,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
