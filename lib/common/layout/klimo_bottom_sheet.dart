import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:klimo/utils/theme.dart';

Future<T?> showKlimoModalBottomSheet<T>({
  required BuildContext context,
  required Widget Function(BuildContext) builder,
}) =>
    showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      builder: builder,
    );

class KlimoBottomSheet extends StatefulWidget {
  const KlimoBottomSheet({
    Key? key,
    required this.body,
    this.header,
    this.backGroundColor,
  }) : super(key: key);

  final PreferredSizeWidget? header;
  final Widget? body;
  final Color? backGroundColor;

  @override
  KlimoBottomSheetState createState() => KlimoBottomSheetState();
}

class KlimoBottomSheetState extends State<KlimoBottomSheet> {
  final sheetKey = GlobalKey();
  final childKey = GlobalKey();
  Size? prevSize;

  double childSize = 0.9;

  @override
  Widget build(BuildContext context) {
    // measure the size of the child content after the first frame
    SchedulerBinding.instance.addPostFrameCallback(postFrameCallback);

    // child sizes for DraggableScrollableSheet:
    const minSize = 0.25;
    const maxSize = 0.9;
    // size: computed child size clipped to interval [minS, 0.9]
    final computedSize = max(minSize,
        min(maxSize, childSize + MediaQuery.of(context).viewInsets.vertical));

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => Navigator.pop(context),
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: DraggableScrollableSheet(
          key: sheetKey,
          minChildSize: minSize,
          maxChildSize: computedSize,
          initialChildSize: computedSize,
          snap: true,
          builder: (context, ScrollController scrollController) {
            return Container(
              decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(10)),
                color: widget.backGroundColor ?? Colors.white,
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 4.0)
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: SafeArea(
                child: Column(
                  children: [
                    if (widget.header != null) widget.header!,
                    if (widget.body != null)
                      Expanded(
                        child: SingleChildScrollView(
                          controller: scrollController,
                          child: Padding(
                            key: childKey,
                            padding: const EdgeInsets.symmetric(
                                    horizontal: 24.0, vertical: 16.0) +
                                EdgeInsets.only(
                                  bottom: 16.0 +
                                      MediaQuery.of(context).viewInsets.bottom,
                                ),
                            child: widget.body!,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void postFrameCallback(Duration _) {
    var context = childKey.currentContext;
    if (context == null) return;

    var nextSize = context.size;
    if (prevSize == nextSize) return;
    prevSize = nextSize;

    var sheetSize = sheetKey.currentContext?.size;

    if (sheetSize == null || nextSize == null) return;

    var contentHeight =
        (widget.header?.preferredSize.height ?? 0.0) + nextSize.height;
    var nextChildSize = contentHeight / sheetSize.height;

    if (nextChildSize != childSize) {
      setState(() {
        childSize = nextChildSize;
      });
    }
  }
}

class KlimoBottomSheetHeader extends StatelessWidget
    implements PreferredSizeWidget {
  const KlimoBottomSheetHeader({
    Key? key,
    this.title,
    this.action,
  }) : super(key: key);

  final String? title;
  final Widget? action;

  /// The header has different height depending on wether it has a title or an
  /// action or just contains the handle.
  ///
  /// Heights:
  /// - Handle: 30 (6 + 12 padding top and bottom)
  /// - Action: Usually an icon button like [SaveIconButton], 64 gives it enough space
  /// - Title: Same as with an action
  @override
  Size get preferredSize =>
      Size.fromHeight(title == null && action == null ? 30.0 : 64.0);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: preferredSize.height,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 60,
                height: 6,
                margin: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Palette.greyLight,
                  borderRadius: BorderRadius.circular(3.0),
                ),
              ),
              if (title != null)
                Text(
                  title!,
                  style: context.textTheme().displayMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
            ],
          ),
          if (action != null)
            Positioned(
              top: 20.0,
              right: 16.0,
              child: action!,
            )
        ],
      ),
    );
  }
}
