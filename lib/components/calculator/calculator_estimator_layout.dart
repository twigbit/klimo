import 'package:flutter/material.dart';
import 'package:klimo/utils/localisation.dart';
import 'package:klimo/utils/theme.dart';

class CalculatorEstimatorLayout extends StatefulWidget {
  final String? section;
  final IconData? sectionIcon;
  final Widget content;
  final bool isKeyboardOpen;

  const CalculatorEstimatorLayout({
    Key? key,
    this.section,
    this.sectionIcon,
    required this.content,
    this.isKeyboardOpen = false,
  }) : super(key: key);

  @override
  State<CalculatorEstimatorLayout> createState() =>
      _CalculatorEstimatorLayoutState();
}

class _CalculatorEstimatorLayoutState extends State<CalculatorEstimatorLayout> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Row(
            children: [
              if (widget.sectionIcon != null)
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Icon(
                    widget.sectionIcon!,
                    color: Palette.primary,
                  ),
                ),
              if (widget.section != null)
                Text(
                  widget.section!.tr(context),
                  style: context
                      .textTheme()
                      .headlineMedium
                      ?.copyWith(color: Palette.primary),
                ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 32.0,
                left: 8.0,
              ),
              child: Scrollbar(
                thumbVisibility: true,
                controller: _scrollController,
                child: SingleChildScrollView(
                    controller: _scrollController,
                    physics: widget.isKeyboardOpen
                        ? const NeverScrollableScrollPhysics()
                        : null,
                    child: widget.content),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
