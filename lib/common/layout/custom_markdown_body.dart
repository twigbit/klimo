import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:klimo/utils/theme.dart';

import '../../utils/launch_url.dart';

class CustomMarkdownBody extends StatelessWidget {
  final String content;
  final EdgeInsets? blockquotePadding;
  final Decoration? blockquoteDecoration;
  final Color? textColor;
  final double? paragraphTextSize;
  final double? letterSpacing;
  final double? textLineHeight;

  const CustomMarkdownBody({
    super.key,
    required this.content,
    this.blockquotePadding,
    this.blockquoteDecoration,
    this.textColor,
    this.paragraphTextSize,
    this.letterSpacing,
    this.textLineHeight,
  });

  factory CustomMarkdownBody.withBlockquoteStyling({
    required BuildContext context,
    required String content,
    double? textLineHeight,
  }) =>
      CustomMarkdownBody(
        content: content,
        textLineHeight: textLineHeight,
        blockquotePadding: const EdgeInsets.all(12.0),
        blockquoteDecoration: BoxDecoration(
          border: Border.all(color: context.colorScheme().onSurface),
          color: context.colorScheme().primaryContainer.withOpacity(0.7),
          borderRadius: BorderRadius.circular(12.0),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return MarkdownBody(
      data: content,
      styleSheet: MarkdownStyleSheet.fromTheme(context.theme()).copyWith(
        blockquotePadding: blockquotePadding,
        blockquoteDecoration: blockquoteDecoration,
        listBullet: context.textTheme().titleMedium?.copyWith(color: textColor),
        a: TextStyle(
          color: context.colorScheme().primary,
          decoration: TextDecoration.underline,
          decorationColor: context.colorScheme().primary,
        ),
        h1: context.textTheme().headlineLarge?.copyWith(color: textColor),
        h2: context.textTheme().headlineMedium?.copyWith(color: textColor),
        h3: context.textTheme().headlineSmall?.copyWith(color: textColor),
        p: context.textTheme().bodyMedium?.copyWith(
              height: textLineHeight,
              fontSize: paragraphTextSize,
              color: textColor,
              letterSpacing: letterSpacing,
            ),
      ),
      onTapLink: (_, href, __) {
        if (href != null) openUrl(href);
      },
    );
  }
}
