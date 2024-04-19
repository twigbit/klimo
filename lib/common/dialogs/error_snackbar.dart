import 'package:flutter/material.dart';
import 'package:klimo/utils/theme.dart';

extension ErrorSnackBar on BuildContext {
  void showErrorMessage(String error) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(error),
          backgroundColor: Palette.error,
          dismissDirection: DismissDirection.startToEnd,
          behavior: SnackBarBehavior.fixed,
        ),
      );
  }
}
