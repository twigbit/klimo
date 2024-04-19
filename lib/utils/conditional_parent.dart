import 'package:flutter/material.dart';

class ConditionalParent extends StatelessWidget {
  final Widget child;
  final bool condition;
  final Widget Function(Widget child) conditionalBuilder;

  const ConditionalParent({
    Key? key,
    required this.condition,
    required this.child,
    required this.conditionalBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return condition ? conditionalBuilder(child) : child;
  }
}
