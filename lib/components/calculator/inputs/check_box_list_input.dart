import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klimo/components/calculator/cubit/calculator_value_scope_cubit.dart';
import 'package:klimo/components/calculator/inputs/answer_selection_row.dart';
import 'package:klimo/utils/localisation.dart';
import 'package:klimo/utils/theme.dart';
import 'package:klimo_datamodels/input_model.dart' as model;

import 'input_controller.dart';
import 'input_layout.dart';

class CheckBoxListInput extends StatelessWidget {
  final model.MultiSelectInput input;

  const CheckBoxListInput({Key? key, required this.input}) : super(key: key);

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
        final val = value != null
            ? (value as BuiltList).cast<String>().toBuiltList()
            : BuiltList<String>();

        return InputLayout(
          fullKey,
          title: title,
          description: description,
          unit: unit,
          child: Column(
            children: answerOptions.map((element) {
              bool isSelected = val.contains(element);
              return AnswerSelectionRow(
                onTap: () {
                  if (isSelected == true) {
                    setValue(val.rebuild((v) => v.remove(element)));
                  } else {
                    setValue(val.rebuild((v) => v.add(element)));
                  }
                },
                isSelected: isSelected,
                text: element.tr(context),
                selectionWidget: Checkbox(
                    activeColor: context.colorScheme().primary,
                    value: isSelected,
                    onChanged: (checkboxValue) {
                      if (checkboxValue == true) {
                        setValue(val.rebuild((v) => v.add(element)));
                      } else {
                        setValue(val.rebuild((v) => v.remove(element)));
                      }
                    }),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
