import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klimo/common/layout/util.dart';
import 'package:klimo/components/community/common/select_group_card.dart';
import 'package:klimo/components/community/cubit/join_community_cubit.dart';
import 'package:klimo/utils/theme.dart';
import 'package:klimo/utils/localisation.dart';
import 'package:klimo_datamodels/community.dart';

class CommunityFragment extends StatelessWidget {
  final String? title;
  const CommunityFragment({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JoinCommunityCubit, JoinCommunityState>(
      builder: (context, state) {
        if (state is CommunitiesLoaded) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  children: [
                    if (title != null)
                      Text(
                        title!,
                        style: context.textTheme().displayLarge,
                        textAlign: TextAlign.center,
                      ),
                    ListView.builder(
                      clipBehavior: Clip.hardEdge,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(bottom: 96),
                      itemCount: state.communities.length,
                      itemBuilder: (context, index) {
                        CommunityRef communityModel = state.communities[index];
                        return SelectGroupCard(
                          logoUrl: communityModel.logoUrl,
                          name: communityModel.name.tr(context),
                          onTap: () {
                            context
                                .read<JoinCommunityCubit>()
                                .selectCommunity(index);
                          },
                          isSelected: index == state.selectedCommunityIndex,
                        );
                      },
                    ),
                  ].padded(
                      const EdgeInsets.only(bottom: 16, left: 8, right: 8)),
                ),
              ]);
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
