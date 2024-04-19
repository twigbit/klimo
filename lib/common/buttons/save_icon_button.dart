import 'package:flutter/material.dart';
import 'package:klimo/utils/theme.dart';

class SaveIconButton extends StatelessWidget {
  final Function()? onClick;
  final String? hintText;
  const SaveIconButton({
    Key? key,
    required this.onClick,
    this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color: (onClick == null ? Palette.greyLight : Palette.greenBackground),
        shape: const CircleBorder(),
      ),
      child: IconButton(
        onPressed: onClick,
        icon: const Icon(Icons.done),
        color: Palette.primary,
        iconSize: 24,
        visualDensity: VisualDensity.compact,
        tooltip: hintText,
      ),
    );
  }
}
