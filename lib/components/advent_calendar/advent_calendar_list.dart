import 'package:flutter/material.dart';
import 'package:klimo/components/advent_calendar/cards/advent_calendar_closed_card.dart';
import 'package:klimo/components/advent_calendar/cards/advent_calendar_opened_card.dart';
import 'package:klimo/components/advent_calendar/common/flip_card.dart';
import 'package:klimo/components/advent_calendar/cubit/advent_calendar_cubit.dart';
import 'package:klimo_datamodels/advent_calendar.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class AdventCalendarList extends StatefulWidget {
  final List<AdventCalendarModel> items;
  final int initialIndex;
  const AdventCalendarList({
    super.key,
    required this.initialIndex,
    required this.items,
  });

  @override
  State<AdventCalendarList> createState() => _AdventCalendarListState();
}

class _AdventCalendarListState extends State<AdventCalendarList> {
  final itemController = ItemScrollController();

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => scrollToItem());
  }

  Future scrollToItem() async =>
      itemController.jumpTo(index: widget.initialIndex);

  @override
  Widget build(BuildContext context) {
    return ScrollablePositionedList.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemScrollController: itemController,
      itemCount: widget.items.length,
      itemBuilder: ((context, index) {
        final AdventCalendarModel contentItem = widget.items[index];
        final DateTime cardDate = contentItem.date;
        final int cardNumber = index + 1;

        return Container(
          constraints: const BoxConstraints(maxWidth: 280),
          child: Builder(builder: (context) {
            if (cardDate.isAfter(DateTime.now())) {
              return AdventCalendarClosedCard(
                imageUrl: contentItem.imageUrl,
                isAvailable: false,
              );
            }
            if (contentItem.isOpen) {
              return AdventCalendarOpenedCard(
                contentItem: contentItem,
                batchNumber: cardNumber.toString(),
              );
            } else {
              return FlipCard(
                cardId: contentItem.date.id,
                front: AdventCalendarClosedCard(
                  imageUrl: contentItem.imageUrl,
                ),
                back: AdventCalendarOpenedCard(
                  contentItem: contentItem,
                  batchNumber: cardNumber.toString(),
                ),
              );
            }
          }),
        );
      }),
    );
  }
}
