import 'package:flutter/material.dart';

class OverrideListPadding extends StatelessWidget {
  final Widget child;

  const OverrideListPadding({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

extension WithOverrideListPadding on Widget {
  Widget overridePadding() {
    return OverrideListPadding(child: this);
  }
}

extension WithPadding on List<Widget> {
  List<Widget> padded(EdgeInsets padding) {
    return map((item) => item is OverrideListPadding
        ? item
        : Padding(padding: padding, child: item)).toList();
  }
}
