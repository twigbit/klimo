import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:klimo/common/cubit/document_query_cubit.dart';
import 'package:klimo/utils/localisation.dart';
import 'package:klimo/utils/theme.dart';
import 'package:klimo_datamodels/rewards.dart';

class NotificationButton extends StatelessWidget {
  const NotificationButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var rewards =
        context.watch<DocumentQueryCubit<UserRewardModel>>().state?.value;

    if (rewards == null) return Container();

    Size dimens = MediaQuery.of(context).size;
    return Stack(
      children: [
        Center(
          child: PopupMenuButton<String>(
              position: PopupMenuPosition.under,
              elevation: 32,
              splashRadius: 24,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              constraints: BoxConstraints.loose(
                  Size(dimens.shortestSide - 16, dimens.shortestSide)),
              icon: const Icon(FontAwesomeIcons.gift),
              itemBuilder: (context) {
                return (context
                        .read<DocumentQueryCubit<UserRewardModel>>()
                        .state!
                        .value!
                        .docs
                      ..sort((a, b) =>
                          b.data().timestamp.millisecondsSinceEpoch -
                          a.data().timestamp.millisecondsSinceEpoch))
                    .map((e) => PopupMenuItem<String>(
                        child: RewardNotificationCard(
                            rewardModel: e.data().reward)))
                    .toList();
              }),
        ),
        if (rewards.docs.isNotEmpty)
          Positioned(
              top: 8,
              right: 8,
              child: Container(
                decoration: BoxDecoration(
                    color: context.colorScheme().primaryContainer,
                    borderRadius: BorderRadius.circular(32)),
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: Text(rewards.docs.length.toString()),
                ),
              )),
      ],
    );
  }
}

class RewardNotificationCard extends StatelessWidget {
  final VirtualRewardModel rewardModel;
  const RewardNotificationCard({Key? key, required this.rewardModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CachedNetworkImage(
            height: 64, width: 64, imageUrl: rewardModel.assetUrl),
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.localisation().reward_assigned,
                style: context.textTheme().titleSmall,
              ),
              Text(
                rewardModel.title ?? "",
                style: context
                    .textTheme()
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
