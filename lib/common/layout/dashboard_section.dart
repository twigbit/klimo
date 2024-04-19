import 'package:flutter/material.dart';
import 'package:klimo/common/layout/text_with_info.dart';
import 'package:klimo/utils/theme.dart';

import 'klimo_bottom_sheet.dart';

class DashboardSection extends StatelessWidget {
  final String? title;
  final String? description;
  final Widget child;
  final Brightness brightness;
  final Widget? trailing;
  final bool isExpandable;
  final bool isWithInfo;
  final String? infoTitle;
  final String? infoMessage;

  const DashboardSection({
    Key? key,
    this.title,
    this.description,
    required this.child,
    this.brightness = Brightness.light,
    this.trailing,
    this.isExpandable = false,
    this.isWithInfo = false,
    this.infoTitle,
    this.infoMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null || trailing != null)
            Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 12.0, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (title != null)
                    isWithInfo
                        ? TextWithInfo(
                            onClick: isWithInfo
                                ? () => showKlimoModalBottomSheet(
                                      context: context,
                                      builder: (ctx) => KlimoBottomSheet(
                                        header: KlimoBottomSheetHeader(
                                          title: infoTitle ?? "",
                                        ),
                                        body: Text(infoMessage ?? ""),
                                      ),
                                    )
                                : null,
                            text: title!,
                            style: context.textTheme().headlineLarge?.copyWith(
                                color: brightness == Brightness.dark
                                    ? Palette.white
                                    : Palette.black),
                          )
                        : Text(
                            title!,
                            style: context.textTheme().headlineLarge?.copyWith(
                                color: brightness == Brightness.dark
                                    ? Palette.white
                                    : Palette.black),
                          ),
                  trailing ?? const SizedBox()
                ],
              ),
            ),
          if (description != null)
            Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                bottom: 6.0,
              ),
              child: Text(
                description!,
                style: context
                    .textTheme()
                    .headlineSmall
                    ?.copyWith(color: Palette.grey),
              ),
            ),
          child,
        ],
      ),
    );
  }
}

class SectionHeaderButton extends StatelessWidget {
  final IconData icon;
  final Function() onTap;
  const SectionHeaderButton({
    Key? key,
    this.icon = Icons.arrow_forward_ios,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      width: 32,
      child: IconButton(
        icon: Icon(icon),
        onPressed: onTap,
      ),
    );
  }
}
