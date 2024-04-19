import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klimo/components/calculator/cubit/calculator_value_scope_cubit.dart';
import 'package:klimo/components/calculator/inputs/answer_selection_row.dart';
import 'package:klimo/utils/localisation.dart';
import 'package:klimo/utils/theme.dart';
import 'package:klimo_datamodels/calculation_engine.dart';
import 'package:klimo_datamodels/input_model.dart';

import 'input_controller.dart';
import 'input_layout.dart';

class CheckboxGroupInput extends StatelessWidget {
  final NestedEntityInput input;
  final bool isContextOnboarding;

  const CheckboxGroupInput({
    Key? key,
    required this.input,
    this.isContextOnboarding = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fullKey =
        context.select((CalculatorValueScopeCubit c) => c.getFullKey(input));
    final title =
        ((isContextOnboarding ? input.onboardingTitle : null) ?? input.title)
            .tr(context);
    final description = input.description?.tr(context) ?? "";

    return InputLayout(
      fullKey,
      title: title,
      description: description,
      child: InputController(
          input: input,
          builder: (context, value, setValue) {
            final items = _currentValue(value).toBuiltList();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: input.entityTypes.map((entity) {
                var isSelected = isEntitySelected(items, entity);
                return AnswerSelectionRow(
                    onTap: () => toggleItem(context, items, entity),
                    isSelected: isSelected,
                    text: entity.title.tr(context),
                    selectionWidget: Checkbox(
                      value: isSelected,
                      activeColor: Palette.primary,
                      onChanged: (_) => toggleItem(context, items, entity),
                    ));
              }).toList(),
            );
          }),
    );
  }

  bool isEntitySelected(BuiltList<NestedValues> state, NestedEntity entity) {
    return state.any((a) => a.entity == entity.key);
  }

  void toggleItem(BuildContext context, BuiltList<NestedValues> state,
      NestedEntity entity) {
    final scope = context.read<CalculatorValueScopeCubit>();

    if (isEntitySelected(state, entity)) {
      scope.setUserInput(input,
          state.rebuild((c) => c.removeWhere((a) => a.entity == entity.key)));
    } else {
      scope.setUserInput(
          input, state.rebuild((c) => c.add(NestedValues.empty(entity.key))));
    }
  }

  Iterable<NestedValues> _currentValue(Object? value) {
    return (value as BuiltList<Object>? ?? BuiltList()).cast<NestedValues>();
  }
}
