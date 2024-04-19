import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:klimo/components/calculator/cubit/calculator_value_scope_cubit.dart';
import 'package:klimo/components/calculator/util.dart';
import 'package:klimo/utils/localisation.dart';
import 'package:klimo/utils/theme.dart';
import 'package:klimo_datamodels/calculation_engine.dart';
import 'package:klimo_datamodels/input_model.dart';

import 'input_layout.dart';

class TextFieldInput extends StatefulWidget {
  final NumberInput input;

  const TextFieldInput({Key? key, required this.input}) : super(key: key);

  @override
  TextFieldInputState createState() => TextFieldInputState();
}

class TextFieldInputState extends State<TextFieldInput> {
  final TextEditingController _textController = TextEditingController();

  num? safeParse(String input) {
    try {
      return NumberFormat().parse(input);
    } on FormatException {
      return null;
    }
  }

  String stringValue(num val) {
    return NumberFormat("###.##").format(val);
  }

  @override
  Widget build(BuildContext context) {
    final fullKey = context
        .select((CalculatorValueScopeCubit c) => c.getFullKey(widget.input));
    final title = widget.input.title.tr(context);
    final description = widget.input.description?.tr(context) ?? "";
    final String? unitTranslation = widget.input.unit.nullIfEmpty();
    final unit = unitTranslation?.tr(context) ?? "";

    return BlocListener<CalculatorValueScopeCubit, ValueScope>(
      listener: (context, state) {
        final val = context
            .read<CalculatorValueScopeCubit>()
            .getInputValue(widget.input);

        if (val != null && val is String && val != _textController.text) {
          _textController.text = val;
        }
        if (val != null && val is num) {
          var text = val.stringValue();
          if (text != _textController.text) {
            _textController.text = text;
          }
        }
      },
      child: InputLayout(
        fullKey,
        title: title,
        description: description,
        child: TextFormField(
          style: context.textTheme().bodyMedium,
          textAlign: TextAlign.left,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
            TextInputFormatter.withFunction(
              (oldValue, newValue) {
                final value = newValue.text.replaceAll(',', '.');
                return newValue.copyWith(text: value);
              },
            ),
          ],
          controller: _textController,
          decoration: InputDecoration(
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(unit),
            ),
            suffixIconConstraints:
                const BoxConstraints(minWidth: 0, minHeight: 0),
          ),
          autocorrect: false,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
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
    if (initialValue != null &&
        initialValue is String &&
        initialValue != _textController.text) {
      _textController.text = initialValue;
    } else if (initialValue != null && initialValue is num) {
      _textController.text = initialValue.stringValue();
    } else {
      _textController.text = "";
    }

    super.initState();
  }
}
