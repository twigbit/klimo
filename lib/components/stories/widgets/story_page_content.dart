import 'package:flutter/material.dart';
import 'package:klimo/common/models/atoms.dart';
import 'package:klimo/utils/theme.dart';

import '../../../common/images/custom_network_image.dart';
import '../../../common/layout/custom_markdown_body.dart';
import '../models/story.dart';
import '../quiz/widgets/score_chip.dart';

class StoryPageContent extends StatelessWidget {
  final StoryPageModel page;
  final String storyId;
  const StoryPageContent({
    super.key,
    required this.page,
    required this.storyId,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              page.title.tr(context),
              style: context.textTheme().headlineMedium?.copyWith(
                    fontSize: 26,
                    color: Colors.white,
                    height: 1.3,
                  ),
            ),
            if (page.quiz != null)
              ScoreChip(storyId: storyId, quizId: page.quiz!.id),
          ],
        ),
        const SizedBox(height: 16),
        if (page.subtitle != null)
          CustomMarkdownBody(
            content: page.subtitle!.tr(context),
            textColor: Colors.white,
            paragraphTextSize: 18,
            letterSpacing: 0.5,
            textLineHeight: 1.5,
          ),
        if (page.illustration != null) ...[
          const SizedBox(height: 24),
          CustomNetworkImage.withPlaceholder(
            page.illustration!,
            context,
            fit: BoxFit.contain,
          ),
        ],
      ],
    );
  }
}
