import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klimo/components/calculator/cubit/calculator_cubit.dart';
import 'package:klimo_datamodels/input_model.dart' as model;
import 'check_box_list_input.dart';
import 'checkbox_group_input.dart';
import 'drop_down_input.dart';
import 'group_input.dart';
import 'input_header.dart';
import 'nested_input.dart';
import 'radio_input.dart';
import 'slider_input.dart';
import 'text_field_input.dart';

class CalculatorInput extends StatelessWidget {
  final model.Input input;
  final bool ignoreCondition;

  /// If this flag is true, nested inputs are rendered as
  /// flat multi-select lists without the option to edit
  /// the nested entities (used in the onboarding).
  final bool isContextOnboarding;

  const CalculatorInput({
    Key? key,
    required this.input,
    this.ignoreCondition = false,
    this.isContextOnboarding = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // aliasing input to enable variable promotion (http://dart.dev/go/non-promo-property)
    final inp = input;

    if (!ignoreCondition && inp.condition != null) {
      // TODO: (emil) conditions currently only work in the root scope and not in nested entities.
      final cond = context.select((CalculatorCubit c) => c.checkCondition(inp));
      if (!cond) return Container();
    }

    if (inp is model.NumberInput) {
      return TextFieldInput(input: inp);
    } else if (inp is model.RangeInput) {
      return SliderInput(input: inp);
    } else if (inp is model.RadioInput) {
      if (inp.isRadioList) {
        return RadioInput(input: inp);
      } else {
        return DropdownInput(input: inp);
      }
    } else if (inp is model.MultiSelectInput) {
      return CheckBoxListInput(input: inp);
    } else if (inp is model.NestedEntityInput) {
      return isContextOnboarding
          ? CheckboxGroupInput(
              input: inp,
              isContextOnboarding: isContextOnboarding,
            )
          : NestedInput(input: inp);
    } else if (inp is model.GroupInput) {
      return GroupInput(input: inp);
    } else if (inp is model.Header) {
      return InputHeader(input: inp);
    } else {
      return Container();
    }
  }
}
