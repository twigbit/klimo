import 'package:flutter/material.dart';
import 'package:klimo/utils/theme.dart';

class TextWithInfo extends StatelessWidget {
  final VoidCallback? onClick;
  final String text;
  final TextStyle? style;
  const TextWithInfo({
    Key? key,
    required this.onClick,
    required this.text,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: text,
              style: style,
            ),
            if (onClick != null)
              const WidgetSpan(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 2.0,
                    bottom: 6.0,
                  ),
                  child: InfoIcon(size: 16),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class InfoIcon extends StatelessWidget {
  final double size;
  const InfoIcon({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.info_outline,
      color: Palette.primary,
      size: size,
    );
  }
}
