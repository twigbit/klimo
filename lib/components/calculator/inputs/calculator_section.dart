import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:klimo/components/calculator/cubit/calculator_cubit.dart';
import 'package:klimo/config/labels.dart';
import 'package:klimo/utils/localisation.dart';
import 'package:klimo/utils/theme.dart';
import 'package:klimo_datamodels/input_model.dart';

import 'calculator_input.dart';

class CalculatorSection extends StatelessWidget {
  final Section sectionModel;

  const CalculatorSection({Key? key, required this.sectionModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Icon(
                      getSectionIcon(sectionModel.key),
                      color: Palette.primary,
                    ),
                  ),
                  Text(
                    sectionModel.title.tr(context),
                    style: context
                        .textTheme()
                        .displayMedium
                        ?.copyWith(color: Palette.primary),
                  ),
                ],
              ),
              BlocSelector<CalculatorCubit, CalculatorState, double>(
                  selector: (state) => state is CalculatorReady
                      ? state.calculationResults
                              .sectionResults[sectionModel.key] ??
                          .0
                      : .0,
                  builder: (context, value) {
                    return Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/co2.svg',
                          height: 16,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text("${value.toStringAsFixed(2)} t",
                              style: context.textTheme().displayMedium),
                        ),
                      ],
                    );
                  }),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: Divider(),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: sectionModel.inputs
                .map<Widget>(
                  // Note: Don't add Padding to the CalculatorInputWidget,
                  // because this will add unwanted empty space for inputs
                  // that are not displayed because of their condition
                  // evaluating to false.
                  (input) => CalculatorInput(input: input),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
