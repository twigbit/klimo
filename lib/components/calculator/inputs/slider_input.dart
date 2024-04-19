import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:klimo/components/calculator/cubit/calculator_value_scope_cubit.dart';
import 'package:klimo/components/calculator/util.dart';
import 'package:klimo/utils/localisation.dart';
import 'package:klimo/utils/theme.dart';
import 'package:klimo_datamodels/input_model.dart' as model;

import 'input_controller.dart';
import 'input_layout.dart';

class SliderInput extends StatefulWidget {
  final model.RangeInput input;

  const SliderInput({
    Key? key,
    required this.input,
  }) : super(key: key);

  @override
  State<SliderInput> createState() => _SliderInputState();
}

class _SliderInputState extends State<SliderInput> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final fullKey = context
        .select((CalculatorValueScopeCubit c) => c.getFullKey(widget.input));
    final title = widget.input.title.tr(context);
    final description = widget.input.description?.tr(context) ?? "";
    final String? unitTranslation = widget.input.unit.nullIfEmpty();
    final unit = unitTranslation?.tr(context) ?? "";

    final minValue = widget.input.min;
    final maxValue = widget.input.max;

    return InputController(
      input: widget.input,
      builder: (context, value, setValue) {
        final double currentSliderValue;
        if (value is double) {
          if (value < minValue) {
            currentSliderValue = minValue;
          } else if (value > maxValue) {
            currentSliderValue = maxValue;
          } else {
            currentSliderValue = value;
          }
        } else {
          currentSliderValue = minValue;
        }
        return InputLayout(
          fullKey,
          title: title,
          description: description,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 2.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 80,
                      child: TextFormField(
                        controller: _textController,
                        textAlign: TextAlign.center,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
                          TextInputFormatter.withFunction(
                            (oldValue, newValue) {
                              final value = newValue.text.replaceAll(',', '.');
                              return newValue.copyWith(text: value);
                            },
                          ),
                        ],
                        textInputAction: TextInputAction.done,
                        autocorrect: false,
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.zero),
                      ),
                    ),
                    if (unit.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          unit,
                          style: context.textTheme().headlineSmall,
                        ),
                      ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 24.0),
                    child: Slider(
                      min: minValue,
                      max: maxValue,
                      divisions: widget.input.divisions,
                      value: currentSliderValue,
                      label: currentSliderValue.round().toString(),
                      onChanged: ((val) {
                        // TODO check resulting value format, for now it's rounded ..
                        var value = val.roundToDouble();
                        FocusManager.instance.primaryFocus?.unfocus();
                        _textController.text = value.stringValue();
                        setValue(value);
                        _textController.selection = TextSelection.fromPosition(
                          TextPosition(
                            offset: _textController.text.length,
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  double? safeParse(String input) {
    try {
      return NumberFormat().parse(input).toDouble();
    } on FormatException {
      return null;
    }
  }

  String stringValue(double val) {
    return NumberFormat("###.##").format(val);
  }

  @override
  void initState() {
    _textController.addListener(() {
      if (_textController.text.isNotEmpty) {
        final val = _textController.text.safeParse();
        if (val != null) {
          context.read<CalculatorValueScopeCubit>().setUserInput(
                widget.input,
                val,
              );
        }
      } else {
        context.read<CalculatorValueScopeCubit>().setUserInput(
              widget.input,
              null,
            );
      }
    });
    final initialValue =
        context.read<CalculatorValueScopeCubit>().getInputValue(widget.input);
    if (initialValue is double) {
      _textController.text = initialValue.stringValue();
    } else {
      _textController.text = "";
    }
    super.initState();
  }
}
