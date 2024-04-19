import 'package:flutter/material.dart';
import 'package:klimo/utils/localisation.dart';
import 'package:klimo/utils/theme.dart';

class DashboardViewButton extends StatelessWidget {
  final String title;
  final bool isSelected;
  final Function() onSelect;
  const DashboardViewButton({
    Key? key,
    required this.title,
    required this.isSelected,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelect,
      child: Container(
        width: 110,
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          color: isSelected ? Palette.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(32.0),
        ),
        child: Text(
          title.tr(context),
          style: context.textTheme().headlineSmall!.copyWith(
                color: isSelected ? Palette.white : Palette.primary,
              ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
