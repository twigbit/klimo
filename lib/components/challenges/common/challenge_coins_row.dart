import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:klimo/utils/theme.dart';

class ChallengeCoinsRow extends StatelessWidget {
  final num? value;
  final bool isOnCard;
  final Color? iconColor;

  const ChallengeCoinsRow({
    Key? key,
    required this.value,
    this.isOnCard = false,
    this.iconColor,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/icons/coins.svg',
          color: iconColor ?? Palette.yellow,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            value?.toStringAsFixed(0) ?? "",
            style: isOnCard
                ? context.textTheme().headlineMedium
                : context.textTheme().displaySmall,
          ),
        ),
      ],
    );
  }
}
