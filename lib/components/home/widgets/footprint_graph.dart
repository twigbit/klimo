import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:klimo/utils/localisation.dart';
import 'package:klimo/utils/theme.dart';
import '../../../config/constants.dart';
import '../../../config/labels.dart';
import 'measurement.dart';

class FootprintGraph extends StatelessWidget {
  final List<FootprintSectionData> footprintData;
  final double totalResult;
  const FootprintGraph({
    Key? key,
    required this.footprintData,
    required this.totalResult,
  }) : super(key: key);

  /// modify data to get
  /// i) all section values withhout compensation value
  /// ii) compemsation value in relation to the total result
  /// note: compensation data is only given with users' data, not with Kassel & German average values
  /// TODO: add challenges savings data
  /// TODO: what will happen wif compensations / savings exceed footprint value

  List<FootprintSectionData> get onlyFootprintData => List.from(footprintData)
    ..removeWhere((element) => element.section == Sections.compensation);

  FootprintSectionData? get compensationSection => footprintData
      .firstWhereOrNull((element) => element.section == Sections.compensation);

  List<FootprintSectionData> get compensationData => compensationSection != null
      ? [
          compensationSection!,
          FootprintSectionData(
            section: "",
            sectionValue: totalResult + compensationSection!.sectionValue!,
            colorValue: Colors.transparent,
            relativeValue: 1 - compensationSection!.relativeValue!,
          ),
        ]
      : [];

  bool get isWithCompensation => compensationData.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final compensationChartHeight = context.media.size.width * 0.45;
    final footprintChartHeight = compensationChartHeight - 20;

    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: SizedBox(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  if (isWithCompensation)
                    ChartComponent(
                      data: compensationData,
                      chartHeight: compensationChartHeight,
                    ),
                  ChartComponent(
                    data: onlyFootprintData,
                    chartHeight: footprintChartHeight,
                  ),
                  Measurement(
                    iconPath: 'assets/icons/co2.svg',
                    value: totalResult.toStringAsFixed(2),
                    subtitle: context.localisation().footprint_unit,
                    color: Palette.red,
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                LegendComponent(data: onlyFootprintData),
                if (isWithCompensation) const Divider(),
                if (isWithCompensation) LegendComponent(data: compensationData),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ChartComponent extends StatelessWidget {
  final List<FootprintSectionData> data;
  final double chartHeight;
  final bool isCompensation;

  const ChartComponent({
    super.key,
    required this.data,
    required this.chartHeight,
    this.isCompensation = false,
  });

  @override
  Widget build(BuildContext context) => SizedBox(
        height: chartHeight,
        child: PieChart(
          PieChartData(
            startDegreeOffset: 270,
            borderData: FlBorderData(show: false),
            sectionsSpace: 2,
            centerSpaceRadius: chartHeight / 2,
            sections: getSections(),
          ),
        ),
      );

  List<PieChartSectionData> getSections() => data
      .asMap()
      .map<int, PieChartSectionData>((index, data) {
        final value = PieChartSectionData(
          color: data.colorValue,
          value: data.sectionValue,
          showTitle: false,
          radius: 7,
        );
        return MapEntry(index, value);
      })
      .values
      .toList();
}

class LegendComponent extends StatelessWidget {
  const LegendComponent({
    super.key,
    required this.data,
  });

  final List<FootprintSectionData> data;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: data
            .where((element) => element.section.isNotEmpty)
            .map<Widget>((data) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Icon(
                          getSectionIcon(data.section),
                          color: data.colorValue,
                          size: 18,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Text(
                            '${data.sectionValue!.toStringAsFixed(2)} t',
                            style: context
                                .textTheme()
                                .bodySmall
                                ?.copyWith(fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          '(${data.relativeValue!.abs().toStringAsFixed(0)} %)',
                          style: context.textTheme().bodySmall!.copyWith(
                              color: Palette.grey, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ))
            .toList());
  }
}

class FootprintSectionData {
  final String section;
  final double? sectionValue;
  final double? relativeValue;
  final Color colorValue;

  FootprintSectionData({
    required this.section,
    this.sectionValue,
    this.relativeValue,
    this.colorValue = Palette.primary,
  });
}
