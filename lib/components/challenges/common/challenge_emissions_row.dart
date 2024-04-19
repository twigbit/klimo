import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:klimo/utils/theme.dart';

// unify with challenge coins and count row
class ChallengeEmissionsRow extends StatelessWidget {
  final num? value;
  final bool isOnCard;

  const ChallengeEmissionsRow({
    Key? key,
    required this.value,
    this.isOnCard = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SvgPicture.asset(
          'assets/icons/co2.svg',
          color: Palette.primary,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          // TODO take care of dynamic unit ?
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                ((value ?? 0) / 52).toStringAsFixed(1),
                style: isOnCard
                    ? context.textTheme().headlineMedium
                    : context.textTheme().displaySmall,
              ),
              Text(
                "kg",
                style: (isOnCard
                        ? context.textTheme().headlineMedium
                        : context.textTheme().displaySmall)!
                    .copyWith(fontSize: 10),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
