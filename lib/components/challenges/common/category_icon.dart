import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:klimo/config/labels.dart';
import 'package:klimo/utils/theme.dart';

class CategoryIcon extends StatelessWidget {
  final String? category;
  final bool isAvailable;
  final bool isRecurring;
  const CategoryIcon({
    Key? key,
    required this.category,
    this.isAvailable = true,
    this.isRecurring = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: isAvailable ? Palette.greenBackground : Palette.greyLight,
            shape: BoxShape.circle,
          ),
          child: Icon(
            getSectionIcon(category!),
            size: 14,
            color: isAvailable ? Palette.primary : Palette.greyPrimary,
          ),
        ),
        if (isRecurring)
          Positioned(
            bottom: -4,
            right: -2,
            child: Container(
              height: 20,
              width: 20,
              decoration: const BoxDecoration(
                color: Palette.white,
                shape: BoxShape.circle,
              ),
              child: Icon(
                FontAwesomeIcons.sync,
                size: 10,
                color: isAvailable ? Palette.primary : Palette.greyPrimary,
              ),
            ),
          ),
      ],
    );
  }
}
