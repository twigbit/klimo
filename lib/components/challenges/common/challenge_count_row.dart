import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:klimo/utils/theme.dart';

// unify with challenge emission and coins row
class ChallengeCountRow extends StatelessWidget {
  final num? value;
  final bool isOnCard;

  const ChallengeCountRow({
    Key? key,
    required this.value,
    this.isOnCard = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SvgPicture.asset(
          'assets/icons/trophy.svg',
          color: Palette.secondary,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            "${value?.toStringAsFixed(0)}",
            style: isOnCard
                ? context.textTheme().headlineMedium
                : context.textTheme().displaySmall,
          ),
        ),
      ],
    );
  }
}
