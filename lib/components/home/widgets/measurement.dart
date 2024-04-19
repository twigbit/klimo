import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:klimo/utils/theme.dart';

class Measurement extends StatelessWidget {
  final String? iconPath;
  final String? value;
  final String? subtitle;
  final Color? color;
  final bool? isSelected;

  const Measurement({
    Key? key,
    this.iconPath,
    this.value,
    this.subtitle,
    this.color,
    this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (iconPath != null) SvgPicture.asset(iconPath!, color: color),
            if (value != null)
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  value!,
                  style: context.textTheme().displayLarge?.copyWith(
                        color: isSelected != null && isSelected!
                            ? color
                            : Palette.black,
                      ),
                ),
              ),
          ],
        ),
        if (subtitle != null)
          Text(
            subtitle!,
            style: context.textTheme().headlineSmall?.copyWith(
                color: isSelected != null && isSelected!
                    ? color
                    : Palette.greySecondary),
            textAlign: TextAlign.center,
          ),
      ],
    );
  }
}
