import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klimo/utils/localisation.dart';
import 'package:klimo/utils/strings.dart';
import 'package:klimo/components/user/cubit/user_cubit.dart';
import 'package:klimo/utils/theme.dart';

import 'widgets/challenges_measurement.dart';

class ChallengesSummary extends StatefulWidget {
  const ChallengesSummary({Key? key}) : super(key: key);

  @override
  ChallengesSummaryState createState() => ChallengesSummaryState();
}

class ChallengesSummaryState extends State<ChallengesSummary> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, userState) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ChallengesMeasurement(
              iconPath: 'assets/icons/coins.svg',
              value:
                  userState?.value?.data()?.stats.coins.toFixedLengthString(),
              subtitle: context.localisation().challenges_points,
              color: Palette.yellow,
            ),
            ChallengesMeasurement(
              iconPath: 'assets/icons/co2.svg',
              value:
                  ((userState?.value?.data()?.stats.emissionSavings ?? 0) / 52)
                      .toFixedLengthString(),
              subtitle: "kg CO\u2082",
              color: Palette.primary,
            ),
            ChallengesMeasurement(
              iconPath: 'assets/icons/trophy.svg',
              value: (userState?.value?.data()?.stats.challenges ?? 0)
                  .toFixedLengthString(),
              subtitle: 'Challenges',
              color: Palette.secondary,
            ),
          ],
        );
      },
    );
  }
}

///Challenge Sample Data
List<ChallengeDataModel> challengePointsSampleData = [
  const ChallengeDataModel(
    xValue: '17',
    yValue: 120.0,
    colorValue: Palette.yellow,
  ),
  const ChallengeDataModel(
    xValue: '18',
    yValue: 200.0,
    colorValue: Palette.yellow,
  ),
  const ChallengeDataModel(
    xValue: '19',
    yValue: 110.0,
    colorValue: Palette.yellow,
  ),
  const ChallengeDataModel(
    xValue: '20',
    yValue: 270.0,
    colorValue: Palette.yellow,
  ),
  const ChallengeDataModel(
    xValue: '21',
    yValue: 180.0,
    colorValue: Palette.yellow,
  ),
  const ChallengeDataModel(
    xValue: '22',
    yValue: 200.0,
    colorValue: Palette.yellow,
  ),
  const ChallengeDataModel(
    xValue: '23',
    yValue: 50.0,
    colorValue: Palette.yellow,
  ),
];

List<ChallengeDataModel> challengeSavingsSampleData = [
  const ChallengeDataModel(
    xValue: '17',
    yValue: 12.0,
    colorValue: Palette.primary,
  ),
  const ChallengeDataModel(
    xValue: '18',
    yValue: 20.0,
    colorValue: Palette.primary,
  ),
  const ChallengeDataModel(
    xValue: '19',
    yValue: 45.0,
    colorValue: Palette.primary,
  ),
  const ChallengeDataModel(
    xValue: '20',
    yValue: 55.0,
    colorValue: Palette.primary,
  ),
  const ChallengeDataModel(
    xValue: '21',
    yValue: 18.0,
    colorValue: Palette.primary,
  ),
  const ChallengeDataModel(
    xValue: '22',
    yValue: 35.0,
    colorValue: Palette.primary,
  ),
  const ChallengeDataModel(
    xValue: '23',
    yValue: 27.0,
    colorValue: Palette.primary,
  ),
];

List<ChallengeDataModel> challengeSuccessSampleData = [
  const ChallengeDataModel(
    xValue: '17',
    yValue: 1.2,
    colorValue: Palette.secondary,
  ),
  const ChallengeDataModel(
    xValue: '18',
    yValue: 2.0,
    colorValue: Palette.secondary,
  ),
  const ChallengeDataModel(
    xValue: '19',
    yValue: 1.1,
    colorValue: Palette.secondary,
  ),
  const ChallengeDataModel(
    xValue: '20',
    yValue: 2.7,
    colorValue: Palette.secondary,
  ),
  const ChallengeDataModel(
    xValue: '21',
    yValue: 1.8,
    colorValue: Palette.secondary,
  ),
  const ChallengeDataModel(
    xValue: '22',
    yValue: 0.2,
    colorValue: Palette.secondary,
  ),
  const ChallengeDataModel(
    xValue: '23',
    yValue: 0.8,
    colorValue: Palette.secondary,
  ),
];

///Challenge Data Model
class ChallengeDataModel {
  final String xValue;
  final num yValue;
  final Color colorValue;

  const ChallengeDataModel({
    required this.xValue,
    required this.yValue,
    required this.colorValue,
  });
}
