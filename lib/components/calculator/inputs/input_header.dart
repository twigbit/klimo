import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klimo/components/calculator/cubit/calculator_value_scope_cubit.dart';
import 'package:klimo/utils/localisation.dart';
import 'package:klimo/utils/theme.dart';
import 'package:klimo_datamodels/input_model.dart';

import 'input_layout.dart';

class InputHeader extends StatelessWidget {
  final Header input;

  const InputHeader({Key? key, required this.input}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fullKey =
        context.select((CalculatorValueScopeCubit c) => c.getFullKey(input));
    final title = input.title.tr(context) ?? "";
    final description = input.description?.tr(context) ?? "";
    final defaultValue = input.defaultValue;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: InputLayout(
        fullKey,
        title: title,
        description: description,
        valueWidget: defaultValue != null
            ? Text(
                "$defaultValue t",
                style: context.textTheme().headlineMedium,
              )
            : null,
      ),
    );
  }
}
