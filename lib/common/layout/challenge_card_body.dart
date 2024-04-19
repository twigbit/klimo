import 'package:flutter/material.dart';
import 'package:klimo/utils/theme.dart';

class ChallengeCardBody extends StatelessWidget {
  final String challengeTitle;
  final String challengeContent;
  final int titleMaxLines;
  final int contentMaxLines;
  final TextStyle? titleStyle;
  final TextStyle? contentStyle;

  const ChallengeCardBody({
    Key? key,
    required this.challengeTitle,
    required this.challengeContent,
    required this.titleMaxLines,
    required this.contentMaxLines,
    this.titleStyle,
    this.contentStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          challengeTitle,
          style: titleStyle ?? context.textTheme().headlineMedium,
          maxLines: titleMaxLines,
          overflow: TextOverflow.ellipsis,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            challengeContent,
            style: contentStyle ?? context.textTheme().bodyMedium,
            maxLines: contentMaxLines,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
