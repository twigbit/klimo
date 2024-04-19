import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klimo/components/advent_calendar/advent_calendar_list.dart';
import 'package:klimo_datamodels/advent_calendar.dart';

import '../advent_calendar/cubit/advent_calendar_cubit.dart';

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}

class AdventCalendar extends StatelessWidget {
  const AdventCalendar({Key? key}) : super(key: key);

  int getAdventCalendarIndex(List<AdventCalendarModel> items) {
    final AdventCalendarModel currentItem;
    final now = DateTime.now();

    if (items.first.date.isAfter(now)) {
      // scroll initially to first item if 1.12. is in future still
      currentItem = items.first;
    } else if (items.last.date.isBefore(now)) {
      // scroll initially to last item if 24.12. has passed
      currentItem = items.last;
    } else {
      // scroll initially to current date in between, i.e. when advent time is running
      currentItem = items.firstWhere((item) => item.date.isSameDate(now));
    }
    return items.indexOf(currentItem);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdventCalendarCubit, AdventCalendarState>(
      builder: (context, state) {
        if (state.isLoaded) {
          final List<AdventCalendarModel> items = state.value?.toList() ?? [];
          // sort list items according to their date property
          items.sort((a, b) => a.date.compareTo(b.date));

          return AdventCalendarList(
            items: items,
            initialIndex: getAdventCalendarIndex(items),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
