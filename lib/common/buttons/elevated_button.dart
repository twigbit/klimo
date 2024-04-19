import 'package:flutter/material.dart';

extension WithCustomVariants on ElevatedButton {
  ElevatedButton expanded() {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(320, 40),
      ),
      child: child,
    );
  }
}
