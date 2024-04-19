import 'package:flutter/material.dart';
import 'package:klimo/common/layout/custom_markdown_body.dart';
import 'package:klimo/common/models/atoms.dart';
import 'package:klimo/components/stories/quiz/models/quiz.dart';
import 'package:klimo/utils/localisation.dart';
import 'package:klimo/utils/theme.dart';

import '../../../../common/layout/klimo_card.dart';

class QuizResultView extends StatelessWidget {
  final QuizModel quiz;
  final int selectedAnswer;
  final String storyId;

  const QuizResultView({
    super.key,
    required this.selectedAnswer,
    required this.storyId,
    required this.quiz,
  });

  @override
  Widget build(BuildContext context) {
    final answerIsCorrect = selectedAnswer == 0;
    return KlimoCard(
      borderColor: answerIsCorrect
          ? context.colorScheme().primary
          : context.colorScheme().error,
      padding: const EdgeInsets.all(12.0),
      child: Scrollbar(
        thickness: 4,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (answerIsCorrect)
                Text(
                  context.localisation().quiz_result_correct_answer,
                  style: context
                      .textTheme()
                      .headlineMedium
                      ?.copyWith(color: context.colorScheme().primary),
                )
              else
                Text(
                  context.localisation().quiz_result_wrong_answer,
                  style: context
                      .textTheme()
                      .headlineMedium
                      ?.copyWith(color: context.colorScheme().error),
                ),
              const SizedBox(height: 16.0),
              Text(quiz.question.tr(context),
                  style: context.textTheme().headlineMedium),
              const SizedBox(height: 16.0),
              Wrap(
                direction: Axis.horizontal,
                children: [
                  if (!answerIsCorrect)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.close, color: Palette.error),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            quiz.answers[selectedAnswer].tr(context),
                            style: context.textTheme().headlineMedium,
                          ),
                        ),
                      ],
                    ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.check, color: Palette.primary),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          quiz.answers.first.tr(context),
                          style: context.textTheme().headlineMedium,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              CustomMarkdownBody(
                content: quiz.information.tr(context),
                paragraphTextSize: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
