import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:klimo/components/calculator/cubit/calculator_cubit.dart';
import 'package:klimo/utils/localisation.dart';
import 'package:klimo/utils/theme.dart';

import 'calculator_dashboard_section.dart';

class CalculatorDashboard extends StatelessWidget {
  const CalculatorDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CalculatorState calculatorState =
        context.select((CalculatorCubit c) => c.state);
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: 0,
        title: BlocSelector<CalculatorCubit, CalculatorState, double>(
          selector: (state) => state is CalculatorReady
              ? state.calculationResults.totalResult
              : .0,
          builder: (context, totalResult) {
            return Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    context.localisation().dashboard_footprint_headline,
                    style: context.textTheme().displayMedium,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/co2.svg',
                        height: 16,
                        color: Palette.red,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text("${totalResult.toStringAsFixed(2)} t",
                            style: context.textTheme().displayMedium),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
      body: calculatorState is CalculatorReady
          ? SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 16.0,
                  bottom: 32.0,
                ),
                child: Column(
                  children: calculatorState.inputModel.sections
                      .map((section) =>
                          CalculatorDashboardSection(sectionModel: section))
                      .toList(),
                ),
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
