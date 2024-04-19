import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klimo/components/calculator/cubit/calculator_cubit.dart';
import 'package:klimo/components/home/widgets/horizontal_image_info_card.dart';
import 'package:klimo/components/user/cubit/user_cubit.dart';
import 'package:klimo/navigation/routes.dart';
import 'package:klimo/utils/loading.dart';
import 'package:klimo/utils/localisation.dart';
import 'package:klimo_datamodels/calculation_engine.dart';

import '../../common/layout/custom_filter_chip.dart';
import '../../config/labels.dart';
import 'widgets/footprint_graph.dart';

const List<String> comparisonGroups = [
  "footprint_comparison_user",
  "footprint_comparison_kassel",
  "footprint_comparison_german",
];

const Map<String, double> germanAverageData = {
  "living": 2.74,
  "mobility": 2.09,
  "nutrition": 1.69,
  "consumption": 3.79,
  "public": 0.84,
};
const Map<String, double> kasselAverageData = {
  "living": 2.16,
  "mobility": 2.17,
  "nutrition": 1.78,
  "consumption": 3.2,
  "public": 0.74,
};

class FootprintSummary extends StatefulWidget {
  const FootprintSummary({
    Key? key,
  }) : super(key: key);

  @override
  State<FootprintSummary> createState() => _FootprintSummaryState();
}

class _FootprintSummaryState extends State<FootprintSummary> {
  String selectedView = comparisonGroups[0];
  List<MapEntry> footprintSectionData = [];
  double? totalResult;

  getFootprintData(CalculationResults calculationResults) {
    switch (selectedView) {
      case "footprint_comparison_user":
        footprintSectionData =
            calculationResults.sectionResults.entries.toList();
        totalResult = calculationResults.totalResult;
        break;
      case "footprint_comparison_kassel":
        footprintSectionData = kasselAverageData.entries.toList();
        totalResult = 10.05;
        break;
      case "footprint_comparison_german":
        footprintSectionData = germanAverageData.entries.toList();
        totalResult = 11.15;
        break;
      default:
        footprintSectionData =
            calculationResults.sectionResults.entries.toList();
        totalResult = calculationResults.totalResult;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalculatorCubit, CalculatorState>(
      builder: (context, state) {
        if (state is CalculatorReady) {
          getFootprintData(state.calculationResults);
          final legendData = footprintSectionData
              .map<FootprintSectionData>(
                (entry) => FootprintSectionData(
                  section: entry.key,
                  sectionValue: entry.value,
                  relativeValue: totalResult != null
                      ? entry.value / totalResult! * 100
                      : 0,
                  colorValue: getCalculatorChartColor(entry.key),
                ),
              )
              .toList();
          return Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                      children: comparisonGroups.map((group) {
                    return CustomFilterChip(
                      label: group == "footprint_comparison_user"
                          ? context
                                  .watch<UserCubit>()
                                  .state!
                                  .data()!
                                  .profile!
                                  .name ??
                              context.localisation().footprint_comparison_user
                          : group.tr(context),
                      emoji: getComparisonGroupEmoji(group),
                      isWithBackground: false,
                      isSelected: group == selectedView,
                      onSelect: (bool value) {
                        setState(() {
                          selectedView = group;
                        });
                      },
                    );
                  }).toList()),
                ),
              ),
              FootprintGraph(
                footprintData: legendData,
                totalResult: totalResult ?? 0,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton.icon(
                    icon: const Icon(Icons.sync),
                    label: Text(context.localisation().action_update),
                    onPressed: () => Router.of(context)
                        .routerDelegate
                        .setNewRoutePath(CalculatorRoute())),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: HorizontalImageInfoCard(
                  value: (totalResult! * 100).toStringAsFixed(0),
                  message: context.localisation().footprint_trees_message,
                  infoTitle: context.localisation().footprint_trees_info_title,
                  infoMessage:
                      context.localisation().footprint_trees_info_content,
                ),
              ),
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
