import 'package:flutter/material.dart';
import 'package:klimo/common/layout/klimo_card.dart';
import 'package:klimo/utils/localisation.dart';
import 'package:klimo/utils/theme.dart';
import 'package:klimo_datamodels/input_model.dart';

import '../../../config/constants.dart';
import '../../../navigation/routes.dart';

class CalculatorDashboardSectionCard extends StatelessWidget {
  final Section sectionModel;
  final String? headline;
  final String? message;

  const CalculatorDashboardSectionCard({
    Key? key,
    required this.sectionModel,
    this.headline,
    this.message,
  }) : super(key: key);

  factory CalculatorDashboardSectionCard.info(BuildContext context,
          {required Section sectionModel}) =>
      CalculatorDashboardSectionCard(
        sectionModel: sectionModel,
        headline: context.localisation().info_calculator_section,
        message:
            "${context.localisation().info_calculator_section_message} ${sectionModel.key.tr(context)}",
      );

  factory CalculatorDashboardSectionCard.empty(BuildContext context,
          {required Section sectionModel}) =>
      CalculatorDashboardSectionCard(
        sectionModel: sectionModel,
        headline: context.localisation().calculate_calculator_section,
        message: sectionModel.key == Sections.compensation
            ? context.localisation().calculate_compensation_section_message
            : "${context.localisation().calculate_calculator_section_message} ${sectionModel.key.tr(context)}",
      );

  factory CalculatorDashboardSectionCard.update(BuildContext context,
          {required Section sectionModel}) =>
      CalculatorDashboardSectionCard(
        sectionModel: sectionModel,
        headline: context.localisation().update_calculator_section,
        message: sectionModel.key == Sections.compensation
            ? context.localisation().update_compensation_section_message
            : "${context.localisation().update_calculator_section_message} ${sectionModel.key.tr(context)}",
      );

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        KlimoCard(
          onTap: (() => Router.of(context).routerDelegate.setNewRoutePath(
                CalculatorSectionRoute(sectionModel),
              )),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (headline != null)
                      Text(
                        headline!,
                        style: context.textTheme().headlineMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Palette.grey,
                    ),
                  ],
                ),
                if (message != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      message!,
                      style: context.textTheme().bodyMedium!.copyWith(
                            color: Palette.grey,
                          ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
