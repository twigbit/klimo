/* import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klimo/common/layout/klimo_card.dart';
import 'package:klimo/components/challenges/new/cubit/cubit/cubit/calendar_week_cubit.dart';
import 'package:klimo/components/challenges/new/weekly_calendar/week_model.dart';
import 'package:klimo/util/theme.dart';
import '../../list/cubit/challenge_list_cubit.dart';

// this widget can be used for a list of week calendars (maybe later again)
class CalendarCard extends StatelessWidget {
  final int index;

  const CalendarCard({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarWeekCubit, CalendarWeekState>(
      builder: (context, calendarState) {
        if (calendarState is CalendarWeeksLoaded) {
          final week = calendarState.weeks[index];

          bool isWeekAvailable = week.weekType == WeekType.current ||
              week.weekType == WeekType.past;

          bool isSelected;
          DateTime? challengeWeekReferenceDate = (context
                  .watch<ChallengeListCubit>()
                  .state as ChallengeListUpdated)
              .challengeReferenceDate;
          if (challengeWeekReferenceDate != null) {
            isSelected =
                challengeWeekReferenceDate.isAtSameMomentAs(week.referenceDate);
          } else {
            isSelected = false;
          }

          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 2.0,
            ),
            child: KlimoCard(
              onTap: isWeekAvailable
                  ? () async {
                      await context
                          .read<ChallengeListCubit>()
                          .updateUsersWeeklyChallengesView(
                            updatedReferenceDate: week.referenceDate,
                            challengeWeekStart: week.startOfWeek,
                            challengeWeekEnd: week.endOfWeek,
                          );
                    }
                  : null,
              color: isWeekAvailable
                  ? isSelected
                      ? Palette.greenBackground
                      : Palette.white
                  : Palette.greyPrimary,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 4.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "W " + week.weekNumber.toString(),
                      style: context.textTheme().bodySmall?.copyWith(
                            color: isWeekAvailable
                                ? Palette.primary
                                : Palette.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      week.startOfWeek.day.toString() +
                          "." +
                          week.startOfWeek.month.toString() +
                          ". - " +
                          week.endOfWeek.day.toString() +
                          "." +
                          week.endOfWeek.month.toString() +
                          ".",
                      style: context.textTheme().bodySmall?.copyWith(
                            color: isWeekAvailable
                                ? Palette.primary
                                : Palette.white,
                          ),
                    ),
                    Text(
                      week.referenceDate.year.toString(),
                      style: context.textTheme().bodySmall?.copyWith(
                            color: isWeekAvailable
                                ? Palette.primary
                                : Palette.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
 */