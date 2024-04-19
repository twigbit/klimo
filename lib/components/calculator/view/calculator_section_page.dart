import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klimo/common/dialogs/confirmation_dialog.dart';
import 'package:klimo/common/dialogs/error_snackbar.dart';
import 'package:klimo/components/calculator/cubit/calculator_cubit.dart';
import 'package:klimo/components/calculator/cubit/calculator_value_scope_cubit.dart';
import 'package:klimo/components/calculator/inputs/calculator_input.dart';
import 'package:klimo/components/calculator/update_cubit/calculator_update_cubit.dart';
import 'package:klimo/utils/localisation.dart';
import 'package:klimo_datamodels/input_model.dart';

import 'calculator_section_components.dart';

class CalculatorSectionPage extends StatefulWidget {
  final Section sectionModel;

  const CalculatorSectionPage({
    Key? key,
    required this.sectionModel,
  }) : super(key: key);

  @override
  State<CalculatorSectionPage> createState() => _CalculatorSectionPageState();
}

class _CalculatorSectionPageState extends State<CalculatorSectionPage> {
  @override
  Widget build(BuildContext context) {
    CalculatorState calculatorState =
        context.select((CalculatorCubit c) => c.state);
    return WillPopScope(
      onWillPop: () async {
        bool hasUnsavedChanges =
            (calculatorState as CalculatorReady).hasUnsavedChanges;
        if (hasUnsavedChanges) {
          var result = await showDialog<bool>(
            context: context,
            builder: (innerContext) => ConfirmationDialog(
              title: context.localisation().leave_calculator_section_title,
              content: context.localisation().leave_calculator_section_content,
            ),
          );
          if (result ?? false) {
            if (!mounted) return false;
            context.read<CalculatorCubit>().resetScope();
            return true;
          } else {
            return false;
          }
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          titleSpacing: 0,
          title: Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CalculatorSectionAppBar(calculatorSection: widget.sectionModel),
                CalculatorSectionEmissionResult(
                  calculatorSectionKey: widget.sectionModel.key,
                  isEstimatedValue: calculatorState is CalculatorReady
                      ? calculatorState.isSectionEmpty(
                          widget.sectionModel.key,
                        )
                      : false,
                ),
              ],
            ),
          ),
        ),
        body: BlocListener<CalculatorUpdateCubit, CalculatorUpdateState>(
          bloc: context.read<CalculatorCubit>().updateCubit,
          listener: (context, updateState) {
            if (updateState is CalculatorUpdateError) {
              context.showErrorMessage(context.localisation().action_error);
            }
          },
          child: calculatorState is CalculatorReady
              ? BlocProvider<CalculatorValueScopeCubit>.value(
                  value: context.read<CalculatorCubit>().rootValueScope,
                  child: GestureDetector(
                    onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(
                        top: 8.0,
                        bottom: MediaQuery.of(context).viewInsets.bottom + 64.0,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: widget.sectionModel.normalInputs
                              .map<Widget>(
                                // Note: Don't add Padding to the CalculatorInputWidget,
                                // because this will add unwanted empty space for inputs
                                // that are not displayed because of their condition
                                // evaluating to false.
                                (input) => CalculatorInput(input: input),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton:
            BlocSelector<CalculatorCubit, CalculatorState, bool>(
          selector: (state) =>
              state is CalculatorReady ? state.hasUnsavedChanges : false,
          builder: (context, activated) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Visibility(
                visible: activated,
                child:
                    BlocBuilder<CalculatorUpdateCubit, CalculatorUpdateState>(
                  bloc: context.read<CalculatorCubit>().updateCubit,
                  builder: (builderContext, updateState) {
                    if (updateState is CalculatorUpdateLoading ||
                        updateState is CalculatorUpdateError) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return ElevatedButton(
                        onPressed: () async {
                          try {
                            await context
                                .read<CalculatorCubit>()
                                .updateUserValues(widget.sectionModel.key);

                            // close keyboard
                            FocusManager.instance.primaryFocus?.unfocus();
                          } catch (error) {
                            if (!context.mounted) return;
                            context.showErrorMessage(
                                context.localisation().action_error);
                          }
                        },
                        child: Text(context.localisation().action_save),
                      );
                    }
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
