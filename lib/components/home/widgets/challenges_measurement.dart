import 'package:flutter/material.dart';
import 'measurement.dart';

class ChallengesMeasurement extends StatelessWidget {
  final String? iconPath;
  final String? value;
  final String? subtitle;
  final Color? color;

  const ChallengesMeasurement({
    Key? key,
    this.iconPath,
    this.value,
    this.subtitle,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        6.0,
        4.0,
        6.0,
        12.0,
      ),
      child: Measurement(
        iconPath: iconPath,
        value: value,
        subtitle: subtitle,
        color: color,
        isSelected: true,
      ),
    );
  }
}
