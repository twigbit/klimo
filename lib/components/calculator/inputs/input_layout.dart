import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:klimo/common/layout/klimo_bottom_sheet.dart';
import 'package:klimo/common/layout/text_with_info.dart';
import 'package:klimo/components/calculator/information/calculator_information_cubit.dart';
import 'package:klimo/utils/theme.dart';

class InputLayout extends StatelessWidget {
  /// The full path of the associated input.
  /// It is used to load the associated detailed information.
  final String? inputFullKey;

  final Widget? child;
  final String title;
  final String description;
  final String unit;
  final Widget? valueWidget;

  const InputLayout(
    this.inputFullKey, {
    Key? key,
    required this.title,
    this.description = "",
    this.unit = "",
    this.valueWidget,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (title.isNotEmpty)
                Expanded(
                  child: BlocBuilder<CalculatorInformationCubit,
                      CalculatorInformationState>(
                    builder: (context, state) {
                      return TextWithInfo(
                        onClick: inputFullKey != null &&
                                (state is CalculatorInformationLoaded &&
                                    state.hasDetailedInformation(inputFullKey!))
                            ? () => _openDetailedInformation(context)
                            : null,
                        text: title,
                        style: context.textTheme().headlineMedium,
                      );
                    },
                  ),
                ),
              if (valueWidget != null)
                Align(
                  alignment: Alignment.centerRight,
                  child: valueWidget!,
                ),
            ],
          ),
        ),
        if (unit.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              unit,
              style: context.textTheme().bodySmall,
            ),
          ),
        if (description.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              description,
              style:
                  context.textTheme().bodyMedium!.copyWith(color: Palette.grey),
            ),
          ),
        if (child != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 32.0),
            child: child,
          ),
      ],
    );
  }

  void _openDetailedInformation(BuildContext context) {
    final informationCubit = context.read<CalculatorInformationCubit>();
    assert(informationCubit.state is CalculatorInformationLoaded,
        "Calculator information not loaded");

    // The non-null-assertion on detailedInfoKey can be made, because the button
    // is conditionally rendered only when detailedInfoKey is not null.
    final data = (informationCubit.state as CalculatorInformationLoaded)
        .getDetailedInformation(inputFullKey!);

    if (data != null) {
      showKlimoModalBottomSheet(
        context: context,
        builder: (ctx) => KlimoBottomSheet(
          header: const KlimoBottomSheetHeader(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  title,
                  style: context.textTheme().displayMedium,
                ),
              ),
              MarkdownBody(data: data.content),
            ],
          ),
        ),
      );
    }
  }
}
