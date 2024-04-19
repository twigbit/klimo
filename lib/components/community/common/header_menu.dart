import 'package:flutter/material.dart';
import 'package:klimo/common/layout/klimo_bottom_sheet.dart';
import 'package:klimo/utils/localisation.dart';
import 'package:klimo/utils/theme.dart';

class HeaderMenu extends StatelessWidget {
  final Function()? onLeave;
  final String? leaveText;
  const HeaderMenu({
    super.key,
    this.onLeave,
    this.leaveText,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: context.theme().copyWith(useMaterial3: false),
      child: PopupMenuButton<String>(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        onSelected: (value) {
          switch (value) {
            case "leave":
              if (onLeave != null) onLeave!();
              break;
            case "info":
              showKlimoModalBottomSheet(
                context: context,
                builder: (ctx) => KlimoBottomSheet(
                  header: KlimoBottomSheetHeader(
                      title: context.localisation().climate_points_info_title),
                  body: Column(
                    children: [
                      Text(
                          context.localisation().climate_points_info_message_1),
                      const SizedBox(height: 16.0),
                      Text(
                          context.localisation().climate_points_info_message_2),
                      const SizedBox(height: 16.0),
                      Text(
                          context.localisation().climate_points_info_message_3),
                      const SizedBox(height: 16.0),
                      Text(
                          context.localisation().climate_points_info_message_4),
                    ],
                  ),
                ),
              );
              break;
          }
        },
        itemBuilder: (context) => [
          if (onLeave != null)
            PopupMenuItem(
              value: 'leave',
              child: Row(
                children: [
                  const Icon(Icons.exit_to_app),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(leaveText ?? ""),
                  ),
                ],
              ),
            ),
          PopupMenuItem(
            value: 'info',
            child: Row(
              children: [
                const Icon(Icons.info_outline),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(context.localisation().climate_points_info_title),
                ),
              ],
            ),
          ),
        ],
        icon: const Icon(Icons.more_vert),
      ),
    );
  }
}
