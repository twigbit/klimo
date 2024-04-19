import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klimo/components/calculator/cubit/calculator_value_scope_cubit.dart';
import 'package:klimo/utils/localisation.dart';
import 'package:klimo/utils/theme.dart';
import 'package:klimo_datamodels/input_model.dart' as model;

import 'input_controller.dart';
import 'input_layout.dart';

class DropdownInput extends StatelessWidget {
  final model.RadioInput input;

  const DropdownInput({Key? key, required this.input}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fullKey =
        context.select((CalculatorValueScopeCubit c) => c.getFullKey(input));
    final String? titleTranslation = input.title.nullIfEmpty();
    final title = titleTranslation?.tr(context) ?? "";
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
          unit: unit,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (description.isNotEmpty)
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 24.0),
                    child: Text(description,
                        style: context.textTheme().bodyMedium),
                  ),
                ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: DropdownButton(
                      isExpanded: true,
                      menuMaxHeight: 300,
                      borderRadius: BorderRadius.circular(8.0),
                      items: answerOptions.map<DropdownMenuItem<String>>(
                          (String dropdownValue) {
                        return DropdownMenuItem<String>(
                          value: dropdownValue,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              dropdownValue.tr(context),
                            ),
                          ),
                        );
                      }).toList(),
                      value: value?.toString(),
                      onChanged: (String? newValue) {
                        setValue(newValue!);
                      }),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
