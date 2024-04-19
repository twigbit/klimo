import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klimo/components/challenges/filter/cubit/filtered_challenges_cubit.dart';
import 'package:klimo/config/analytics.dart';
import 'package:klimo/config/labels.dart';
import 'package:klimo/utils/localisation.dart';

import '../../../common/layout/custom_filter_chip.dart';

class CategoryFilterRow extends StatelessWidget {
  const CategoryFilterRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: BlocBuilder<FilteredChallengesCubit, FilteredChallengesState>(
        builder: (context, state) {
          if (state is FiltersLoaded) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 4.0,
                vertical: 8.0,
              ),
              child: Row(
                  children: state.categories.map((category) {
                final bool isActive = state.filters.contains(category);
                return CustomFilterChip(
                  label: category.tr(context),
                  icon: getSectionIcon(category),
                  isSelected: isActive,
                  onSelect: ((bool value) => context
                      .read<FilteredChallengesCubit>()
                      .toggleFilter(category)).logInteraction(
                    params: {
                      AnalyticsParameters.action:
                          AnalyticsValues.useChallengeFilter,
                      AnalyticsParameters.scope:
                          AnalyticsValues.challengesScope,
                      AnalyticsParameters.category: category,
                    },
                  ),
                );
              }).toList()),
            );
          }
          return Container();
        },
      ),
    );
  }
}
