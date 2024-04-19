import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klimo/components/calculator/cubit/calculator_value_scope_cubit.dart';
import 'package:klimo/components/calculator/inputs/answer_selection_row.dart';
import 'package:klimo/utils/localisation.dart';
import 'package:klimo/utils/theme.dart';
import 'package:klimo_datamodels/input_model.dart' as model;

import 'input_controller.dart';
import 'input_layout.dart';

class RadioInput extends StatelessWidget {
  final model.RadioInput input;

  const RadioInput({Key? key, required this.input}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fullKey =
        context.select((CalculatorValueScopeCubit c) => c.getFullKey(input));
    final title = input.title.tr(context);
    final description = input.description?.tr(context) ?? "";
    final String? unitTranslation = input.unit.nullIfEmpty();
    final unit = unitTranslation?.tr(context) ?? "";

    final answerOptions = input.options.toList();

    return InputController(
      input: input,
      builder: (context, value, setValue) {
        return InputLayout(
          fullKey,
          title: title,
          description: description,
          unit: unit,
          child: Column(
            children: answerOptions
                .map(
                  (element) => AnswerSelectionRow(
                    onTap: () => setValue(element),
                    isSelected: element == value,
                    text: element.tr(context),
                    selectionWidget: Radio(
                        activeColor: context.colorScheme().primary,
                        value: answerOptions.indexOf(element),
                        groupValue: answerOptions.indexOf(value.toString()),
                        onChanged: (int? index) {
                          setValue(index == answerOptions.indexOf(element)
                              ? element
                              : "");
                        }),
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }
}
