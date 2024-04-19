import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:klimo/common/layout/text_with_info.dart';
import 'package:klimo/components/calculator/cubit/calculator_cubit.dart';
import 'package:klimo/config/labels.dart';
import 'package:klimo/utils/localisation.dart';
import 'package:klimo/utils/theme.dart';
import 'package:klimo_datamodels/input_model.dart';
import '../../../common/layout/klimo_bottom_sheet.dart';

class CalculatorSectionHeadline extends StatelessWidget {
  final Section calculatorSection;

  const CalculatorSectionHeadline({
    Key? key,
    required this.calculatorSection,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            right: 12.0,
            bottom: 4.0,
          ),
          child: Icon(
            getSectionIcon(calculatorSection.key),
            size: 18,
            color: calculatorSection.key == "compensation"
                ? Palette.pink
                : Palette.primary,
          ),
        ),
        Text(
          calculatorSection.title.tr(context),
          style: context.textTheme().displaySmall?.copyWith(
                color: calculatorSection.key == "compensation"
                    ? Palette.pink
                    : Palette.primary,
              ),
        ),
      ],
    );
  }
}

class CalculatorSectionAppBar extends StatelessWidget {
  final Section calculatorSection;

  const CalculatorSectionAppBar({
    Key? key,
    required this.calculatorSection,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextWithInfo(
      onClick:
          calculatorSection.info != null && calculatorSection.info!.isNotEmpty
              ? () => showKlimoModalBottomSheet(
                    context: context,
                    builder: (ctx) => KlimoBottomSheet(
                      header: KlimoBottomSheetHeader(
                        title: calculatorSection.title.tr(context),
                      ),
                      body: Text(calculatorSection.info!.tr(context)),
                    ),
                  )
              : null,
      text: calculatorSection.title.tr(context),
      style: context.textTheme().displaySmall,
    );
  }
}

class CalculatorSectionEmissionResult extends StatelessWidget {
  final String calculatorSectionKey;
  final bool isEstimatedValue;

  const CalculatorSectionEmissionResult({
    Key? key,
    required this.calculatorSectionKey,
    this.isEstimatedValue = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CalculatorCubit, CalculatorState, double>(
      selector: (state) => state is CalculatorReady
          ? state.calculationResults.sectionResults[calculatorSectionKey] ?? .0
          : .0,
      builder: (context, value) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/co2.svg',
                  height: 16,
                  color: Palette.red,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text("${value.toStringAsFixed(2)} t",
                      style: context.textTheme().displaySmall),
                ),
              ],
            ),
            if (isEstimatedValue &&
                calculatorSectionKey != "public" &&
                calculatorSectionKey != "compensation")
              Text(
                context.localisation().estimated_calculator_section,
                style: context
                    .textTheme()
                    .bodySmall!
                    .copyWith(color: Palette.grey),
              ),
          ],
        );
      },
    );
  }
}
