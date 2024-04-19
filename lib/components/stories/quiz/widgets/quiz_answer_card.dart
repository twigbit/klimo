import 'package:flutter/material.dart';

import '../../../../common/layout/klimo_card.dart';
import '../../../../utils/theme.dart';

class QuizAnswerCard extends StatelessWidget {
  const QuizAnswerCard({
    super.key,
    required this.position,
    required this.isSelected,
    required this.answerText,
    required this.onSelect,
  });

  final String position;
  final bool isSelected;
  final String answerText;
  final VoidCallback onSelect;

  @override
  Widget build(BuildContext context) {
    return KlimoCard(
      onTap: onSelect,
      padding: const EdgeInsets.all(12.0),
      color: isSelected ? Palette.secondary : null,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            position,
            style: context.textTheme().headlineMedium?.copyWith(
                  color: isSelected ? Colors.white : null,
                ),
          ),
          const SizedBox(width: 16),
          Flexible(
            child: Text(
              answerText,
              style: context.textTheme().bodyLarge?.copyWith(
                    color: isSelected ? Colors.white : null,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
