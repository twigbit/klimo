import 'package:flutter/material.dart';
import 'package:klimo/common/models/atoms.dart';
import 'package:klimo/config/analytics.dart';
import 'package:klimo/config/firebase.dart';
import 'package:klimo/utils/theme.dart';
import '../../navigation/routes.dart';
import '../images/custom_network_image.dart';
import '../models/displayable.dart';

class StoryCard extends StatelessWidget {
  final Displayable item;

  const StoryCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Router.of(context)
            .routerDelegate
            .setNewRoutePath(StoryRoute(storyId: item.id));

        // analytics
        analytics.logAnalyticsEvent(
          eventName: AnalyticsEvents.openStoryCard,
          params: {
            AnalyticsParameters.storyId: item.id,
          },
        );
      },
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: Stack(
          children: [
            Positioned.fill(
                child: CustomNetworkImage(imageUrl: item.image!.url)),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                gradient: LinearGradient(
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.1),
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 8.0,
              left: 16.0,
              right: 16.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (item.overline != null)
                    Text(
                      item.overline!.tr(context),
                      style: context
                          .textTheme()
                          .bodySmall
                          ?.copyWith(color: Colors.white),
                    ),
                  Container(
                    height: 1,
                    width: 100,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.title.tr(context),
                    style: context
                        .textTheme()
                        .headlineMedium
                        ?.copyWith(color: Colors.white),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (item.subtitle != null)
                    Text(
                      item.subtitle!.tr(context),
                      style: context
                          .textTheme()
                          .bodyMedium
                          ?.copyWith(color: Colors.white),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
