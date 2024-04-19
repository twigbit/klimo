import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klimo/components/community/cubit/user_community_cubit.dart';
import 'package:klimo/utils/localisation.dart';
import 'package:klimo/utils/theme.dart';

class CustomSliverAppBar extends StatelessWidget {
  final double expandedHeight;
  final Widget backgroundWidget;
  final Widget? actionWidget;

  const CustomSliverAppBar({
    Key? key,
    required this.expandedHeight,
    required this.backgroundWidget,
    this.actionWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      elevation: 0,
      floating: true,
      pinned: true,
      automaticallyImplyLeading: false,
      expandedHeight: expandedHeight,
      flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final String? userCommunity = context
              .read<UserCommunityCubit>()
              .state
              ?.value
              ?.data()
              ?.community
              .name
              .tr(context);
          return FlexibleSpaceBar(
            titlePadding: const EdgeInsets.only(
              left: 12.0,
              right: 48.0,
              bottom: 12.0,
            ),
            title: constraints.biggest.height < 110
                ? SafeArea(
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        userCommunity ?? "",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme().displayMedium,
                      ),
                    ),
                  )
                : null,
            background: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 12.0,
                  right: 12.0,
                  top: 12.0,
                ),
                child: backgroundWidget,
              ),
            ),
          );
        },
      ),
      actions: [if (actionWidget != null) actionWidget!],
    );
  }
}
