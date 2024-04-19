import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:klimo/config/constants.dart';
import 'package:klimo/utils/theme.dart';

Color getCalculatorChartColor(String category) {
  switch (category) {
    case Sections.living:
      return Palette.lightBlue;
    case Sections.mobility:
      return Palette.darkBlue;
    case Sections.nutrition:
      return Palette.lightGreen;
    case Sections.consumption:
      return Palette.darkGreen;
    case Sections.public:
      return Palette.crayola;
    case Sections.compensation:
      return Palette.pink;
    default:
      return Palette.primary;
  }
}

IconData getSectionIcon(String? category) {
  switch (category) {
    case Sections.living:
      return FontAwesomeIcons.houseUser;
    case Sections.mobility:
      return FontAwesomeIcons.train;
    case Sections.nutrition:
      return FontAwesomeIcons.seedling;
    case Sections.consumption:
      return FontAwesomeIcons.shoppingCart;
    case Sections.shopping:
      return FontAwesomeIcons.shoppingCart;
    case Sections.public:
      return FontAwesomeIcons.landmark;
    case Sections.digital:
      return FontAwesomeIcons.wifi;
    case Sections.hobbies:
      return FontAwesomeIcons.tableTennis;
    case Sections.business:
      return FontAwesomeIcons.briefcase;
    case Sections.vacation:
      return FontAwesomeIcons.suitcaseRolling;
    case Sections.compensation:
      return FontAwesomeIcons.leaf;
    default:
      return FontAwesomeIcons.star;
  }
}

String getComparisonGroupEmoji(String comparisonGroup) {
  switch (comparisonGroup) {
    case "footprint_comparison_user":
      return "🙂";
    case "footprint_comparison_kassel":
      return "🌱";
    case "footprint_comparison_german":
      return "🇩🇪";
    default:
      return "🙂";
  }
}
