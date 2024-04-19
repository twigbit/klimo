import 'package:flutter/material.dart';
import 'package:klimo/utils/theme.dart';

class CustomFilterChip extends StatelessWidget {
  final String label;
  final IconData? icon;
  final String? emoji;
  final bool isWithBackground;
  final bool isSelected;
  final Function onSelect;

  const CustomFilterChip(
      {Key? key,
      required this.label,
      this.icon,
      this.emoji,
      this.isWithBackground = true,
      required this.isSelected,
      required this.onSelect,
      z})
      : super(key: key);

  _getAvatarContent() {
    if (icon != null) {
      return Icon(
        icon,
        size: 15,
        color: isSelected ? Palette.primary : Palette.grey,
      );
    } else if (emoji != null && emoji!.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 4.0),
        child: Text(emoji!),
      );
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: ChoiceChip(
        elevation: 0,
        labelPadding: const EdgeInsets.only(right: 8.0),
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        pressElevation: 0,
        avatar: _getAvatarContent(),
        label: Text(label),
        backgroundColor:
            isWithBackground ? Palette.greyLight : Colors.transparent,
        selectedColor: Palette.greenBackground,
        labelStyle: context.textTheme().headlineSmall?.copyWith(
              color: isSelected ? Palette.primary : Palette.grey,
            ),
        selected: isSelected,
        onSelected: (bool newValue) {
          onSelect(newValue);
        },
      ),
    );
  }
}
