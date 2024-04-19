import 'package:flutter/material.dart';
import 'package:klimo/common/layout/text_with_info.dart';
import 'package:klimo/utils/theme.dart';
import '../../../common/layout/klimo_bottom_sheet.dart';
import '../../../common/layout/klimo_card.dart';

class HorizontalImageInfoCard extends StatelessWidget {
  final String? value;
  final String? message;
  final String? infoTitle;
  final String? infoMessage;
  final Function()? onSelect;

  const HorizontalImageInfoCard({
    Key? key,
    this.value,
    this.message,
    this.infoTitle,
    this.infoMessage,
    this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KlimoCard(
      onTap: onSelect,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                  child: Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/trees.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: FractionalOffset.topCenter,
                          end: FractionalOffset.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0),
                            Colors.black.withOpacity(0.25),
                          ],
                        ),
                      ),
                      child: Center(
                        child: Text(
                          value ?? "",
                          style: context
                              .textTheme()
                              .headlineLarge
                              ?.copyWith(color: Palette.white),
                        ),
                      )),
                ],
              )),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 24.0,
                    bottom: 8.0,
                    top: 8.0,
                    right: 4.0,
                  ),
                  child: Text(
                    message ?? "",
                    style: context
                        .textTheme()
                        .bodySmall
                        ?.copyWith(color: Palette.grey),
                  ),
                ),
              ),
              if (infoTitle != null || infoMessage != null)
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      child: const InfoIcon(size: 18),
                      onTap: () => showKlimoModalBottomSheet(
                        context: context,
                        builder: (ctx) => KlimoBottomSheet(
                          header: KlimoBottomSheetHeader(
                            title: infoTitle ?? "",
                          ),
                          body: Center(
                            child: Text(
                              infoMessage ?? "",
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
