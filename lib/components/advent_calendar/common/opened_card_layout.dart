import 'package:flutter/material.dart';
import 'package:klimo/components/advent_calendar/data/advent_calendar_assets.dart';
import 'package:klimo/utils/theme.dart';

class OpenedCardLayout extends StatelessWidget {
  final Widget content;
  final String? batchNumber;

  const OpenedCardLayout({
    Key? key,
    required this.content,
    this.batchNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            right: 4.0,
            top: 12.0,
          ),
          child: content,
        ),
        Positioned(
          height: 50,
          width: 40,
          right: 4,
          top: -3,
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(AdventCalendarImages.batch),
                  fit: BoxFit.cover),
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Text(batchNumber ?? "",
                  textAlign: TextAlign.center,
                  style: context.textTheme().labelLarge),
            ),
          ),
        ),
      ],
    );
  }
}
