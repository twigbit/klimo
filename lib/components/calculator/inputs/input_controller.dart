import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klimo/components/calculator/cubit/calculator_value_scope_cubit.dart';
import 'package:klimo_datamodels/input_model.dart';

typedef InputSetValue = void Function(Object value);
typedef InputWidgetBuilder = Widget Function(
    BuildContext context, Object? value, InputSetValue setValue);

class InputController extends StatelessWidget {
  final Input input;
  final InputWidgetBuilder builder;

  const InputController({Key? key, required this.input, required this.builder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentValue =
        context.select((CalculatorValueScopeCubit c) => c.getInputValue(input));
    return builder(context, currentValue, (value) {
      context.read<CalculatorValueScopeCubit>().setUserInput(input, value);
    });
  }
}
