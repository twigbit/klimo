import 'package:flutter/material.dart';
import 'package:klimo/common/dialogs/confirmation_dialog.dart';
import 'package:klimo/utils/localisation.dart';
import 'package:klimo/utils/theme.dart';
import 'package:klimo_datamodels/input_model.dart' as model;

import 'calculator_input.dart';
import 'input_controller.dart';

class GroupInput extends StatelessWidget {
  final model.GroupInput input;

  const GroupInput({Key? key, required this.input}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InputController(
        input: input,
        builder: (context, value, setValue) {
          final activated = value is bool ? value : false;

          return Padding(
            padding: const EdgeInsets.only(
              top: 8.0,
              bottom: 32.0,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        input.title.tr(context),
                        style: context.textTheme().titleMedium,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: GestureDetector(
                        onTap: () {
                          toggleActivated(context, activated, setValue);
                        },
                        child: Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            color: context.colorScheme().primary,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4)),
                          ),
                          child: Icon(
                            activated ? Icons.remove : Icons.add,
                            color: context.colorScheme().onPrimary,
                            size: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                if (activated)
                  Padding(
                    padding: const EdgeInsets.only(left: 16, top: 16),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: input.inputs
                            .map<Widget>(
                              // Note: Don't add Padding to the CalculatorInputWidget,
                              // because this will add unwanted empty space for inputs
                              // that are not displayed because of their condition
                              // evaluating to false.
                              (input) => CalculatorInput(input: input),
                            )
                            .toList()),
                  ),
              ],
            ),
          );
        });
  }

  void toggleActivated(
      BuildContext context, bool activated, InputSetValue setValue) {
    if (activated) {
      showDialog(
        context: context,
        builder: (innerContext) => ConfirmationDialog(
          title: context.localisation().remove_calculator_group_input_title,
          content: context.localisation().remove_calculator_group_input_content,
          onConfirm: () {
            setValue(false);
            Navigator.pop(context);
          },
        ),
      );
    } else {
      setValue(true);
    }
  }
}
