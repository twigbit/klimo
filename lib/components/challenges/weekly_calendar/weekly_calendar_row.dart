

// this widget can bes used as weekly calendar list (maybe later again)

/* import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klimo/components/challenges/new/weekly_calendar/calendar_week_services.dart';
import 'package:klimo/components/challenges/new/cubit/cubit/cubit/calendar_week_cubit.dart';
import 'package:klimo/components/challenges/new/weekly_calendar/update_week_view_button.dart';

import 'calendar_card.dart';

class WeeklyCalendarRow extends StatefulWidget {
  const WeeklyCalendarRow({Key? key}) : super(key: key);

  @override
  State<WeeklyCalendarRow> createState() => _WeeklyCalendarRowState();
}

//TODO check how to controll calendar behavior properly for inifinite list view
// for now everything is controlled with fixed length and updated calendar data by button click
class _WeeklyCalendarRowState extends State<WeeklyCalendarRow> {
  DateTime date = CalendarWeekServices(DateTime.now()).referenceDate;
  //  DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

/*   final ScrollController _controller = ScrollController();
  @override
  initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.position.atEdge &&
          _controller.position.userScrollDirection == ScrollDirection.forward) {
        setState(() {
          date = DateTime(date.year, date.month - 1);
        });
      }
    });
  }
  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  } */

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[50],
      height: 80,
      child: Stack(
        children: [
          Positioned.fill(
            child: Center(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: 4,
                  itemBuilder: (BuildContext context, int index) {
                    context
                        .read<CalendarWeekCubit>()
                        .getloadedWeeks(date, index);

                    return CalendarCard(index: index);
                  }),
            ),
          ),
          Positioned(
            left: 0,
            bottom: 16,
            child: UpdateWeekViewButton(
              icon: Icons.arrow_back_ios,
              onPressed: (weeks) =>
                  context.read<CalendarWeekCubit>().updateLoadedWeeks(
                        loadedWeeks: weeks,
                        isForward: false,
                      ),
            ),
          ),
          Positioned(
            right: 0,
            bottom: 16,
            child: UpdateWeekViewButton(
              icon: Icons.arrow_forward_ios,
              onPressed: (weeks) =>
                  context.read<CalendarWeekCubit>().updateLoadedWeeks(
                        loadedWeeks: weeks,
                        isForward: true,
                      ),
            ),
          ),
        ],
      ),
    );
  }
}
 */