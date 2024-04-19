import 'package:flutter/material.dart';
import 'package:klimo/utils/theme.dart';

class SettingsRow extends StatelessWidget {
  final String text;

  final void Function()? onTap;
  final String? description;
  final Color? color;
  final IconData? icon;
  final Widget? trailing;

  const SettingsRow({
    Key? key,
    required this.text,
    this.onTap,
    this.description,
    this.color,
    this.icon,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: description != null
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.center,
              children: [
                if (icon != null)
                  Icon(
                    icon,
                    color: color ?? Palette.black,
                  ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 24.0, right: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          text,
                          style: context.textTheme().titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: color ?? Palette.black),
                        ),
                        if (description != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(
                              description!,
                              style: context.textTheme().bodySmall,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                if (trailing != null) trailing!,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
