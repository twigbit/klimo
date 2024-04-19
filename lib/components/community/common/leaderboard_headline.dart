import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:klimo/utils/theme.dart';

class LeaderboardHeadline extends SliverPersistentHeaderDelegate {
  const LeaderboardHeadline();

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox(
      height: kToolbarHeight,
      child: Material(
        color: context.colorScheme().surface,
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  "Leaderboard",
                  style: context
                      .textTheme()
                      .headlineMedium!
                      .copyWith(color: Palette.greySecondary),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/co2.svg',
                        color: context.colorScheme().primary,
                      ),
                      SvgPicture.asset('assets/icons/coins.svg',
                          color: Palette.yellow),
                      SvgPicture.asset(
                        'assets/icons/trophy.svg',
                        color: context.colorScheme().tertiary,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // kToolbarHeigt = 56 by default, i.e. height of a normal toolbar

  @override
  double get maxExtent => kToolbarHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => false;
}
