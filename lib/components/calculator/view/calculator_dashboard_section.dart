import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klimo/common/layout/util.dart';
import 'package:klimo/components/calculator/cubit/calculator_cubit.dart';
import 'package:klimo/components/calculator/inputs/calculator_input.dart';
import 'package:klimo/config/constants.dart';
import 'package:klimo_datamodels/input_model.dart';

import 'calculator_section_components.dart';
import 'calculator_dashboard_section_card.dart';

class CalculatorDashboardSection extends StatelessWidget {
  final Section sectionModel;

  const CalculatorDashboardSection({Key? key, required this.sectionModel})
      : super(key: key);

  bool get isPublicSection => sectionModel.key == Sections.public;

  @override
  Widget build(BuildContext context) {
    bool isSectionEmpty = context.select((CalculatorCubit c) =>
        c.state is CalculatorReady
            ? (c.state as CalculatorReady).isSectionEmpty(sectionModel.key)
            : true);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (sectionModel.key == Sections.compensation) const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CalculatorSectionHeadline(calculatorSection: sectionModel),
            CalculatorSectionEmissionResult(
              calculatorSectionKey: sectionModel.key,
              isEstimatedValue: isSectionEmpty && !isPublicSection,
            ),
          ],
        ),
        if (sectionModel.normalInputs.isNotEmpty)
          if (isPublicSection)
            CalculatorDashboardSectionCard.info(context,
                sectionModel: sectionModel
                //TODO add update date when available on section level
                )
          else if (isSectionEmpty)
            CalculatorDashboardSectionCard.empty(context,
                sectionModel: sectionModel)
          else
            CalculatorDashboardSectionCard.update(context,
                sectionModel: sectionModel),
        sectionModel.nestedInputs.isNotEmpty
            ? BlocProvider.value(
                value: context.read<CalculatorCubit>().rootValueScope,
                child: Padding(
                  padding: const EdgeInsets.only(left: 2.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: sectionModel.nestedInputs
                        .map<Widget>((input) => CalculatorInput(input: input))
                        .toList(),
                  ),
                ),
              )
            : Container(),
      ].padded(const EdgeInsets.symmetric(vertical: 8, horizontal: 14)),
    );
  }
}
