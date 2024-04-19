import 'package:flutter/material.dart';

class AnswerSelectionRow extends StatelessWidget {
  final Function()? onTap;
  final bool isSelected;
  final String text;
  final Widget selectionWidget;

  const AnswerSelectionRow({
    Key? key,
    this.onTap,
    this.isSelected = false,
    required this.text,
    required this.selectionWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 2.0,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 2.0,
        ),
        decoration: BoxDecoration(
            color: isSelected ? Colors.grey[200] : null,
            borderRadius: const BorderRadius.all(Radius.circular(8.0))),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Text(text)),
            ),
            SizedBox(
              width: 20,
              child: Transform.scale(
                scale: 0.8,
                child: selectionWidget,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
