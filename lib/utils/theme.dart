import 'package:flutter/material.dart';

extension WithAccessors on BuildContext {
  TextTheme textTheme() => Theme.of(this).textTheme;
  ThemeData theme() => Theme.of(this);
  ColorScheme colorScheme() => Theme.of(this).colorScheme;
  MediaQueryData get media => MediaQuery.of(this);
}

class Palette {
  //Klimo Palette
  static const Color primary = Color(0xFF2FAD66);
  static const Color secondary = Color(0xFF0097E2);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color error = Color(0xFFE44D4D);
  static const Color black = Color(0xFF1D1D1D);
  static final Color greenBackground = Palette.primary.withOpacity(0.1);
  static const Color white = Color(0xFFFFFFFF);
  static const Color grey = Color(0xFFB7B7B7);
  static const Color greyPrimary = Color(0xFF565656);
  static const Color greyLight = Color(0xFFEEEEEE);
  static const Color greySecondary = Color(0xFFDADADA);
  static const Color greySecondaryLight = Color(0xFFFAFAFA);
  static const Color yellow = Color(0xFFFFBE21);
  static const Color red = Color(0xFFE44D4D);
  static const Color persianGreen = Color(0xFF00A19A);
  static const Color crayola = Color(0xFFC69475);
  static const Color kohle = Color(0xFF3B3B3B);
  static const Color darkBlue = Color(0xFF00299F);
  static const Color lightBlue = Color(0xFF00B3E3);
  static const Color darkGreen = Color(0xFF006633);
  static const Color lightGreen = Color(0xFF95C11F);
  static const Color adventCalendarBeige = Color(0xFFFEF6EA);
  static const Color adventCalendarRed = Color(0xFFDC5F55);
  static const Color pink = Color(0xFFEF9A9A);
}
