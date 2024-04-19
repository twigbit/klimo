import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:klimo/config/analytics.dart';
import 'package:klimo/config/date.dart';
import 'package:klimo/utils/theme.dart';
import 'package:klimo/navigation/routes.dart';
import 'package:klimo/utils/localisation.dart';
import 'package:klimo_datamodels/articles.dart';

class NewsCard extends StatelessWidget {
  final NewsModel article;
  final String actionScope;
  final bool isAdventsNews;

  const NewsCard({
    Key? key,
    required this.article,
    required this.actionScope,
    this.isAdventsNews = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() => _navigateToArticle(context)).logInteraction(
        params: {
          AnalyticsParameters.action: AnalyticsValues.openArticle,
          AnalyticsParameters.scope: actionScope,
        },
      ),
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: Stack(
          children: [
            Positioned.fill(
              child: CachedNetworkImage(
                imageUrl: article.bannerImage.tr(context),
                fit: BoxFit.cover,
              ),
            ),
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
                  // delete publishedAt date for news for now since it is confusing with events
                  // TODO separate events or actions and add event date
                  if (article.type == ArticleType.guide && !isAdventsNews)
                    Text(
                      article.publishedAt.toReadableDate(),
                      style: context
                          .textTheme()
                          .labelSmall
                          ?.copyWith(color: Colors.white),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  Text(
                    article.title.tr(context),
                    style: context.textTheme().headlineMedium?.copyWith(
                        color: isAdventsNews
                            ? Palette.adventCalendarBeige
                            : Colors.white),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (article.subheader != null)
                    Text(
                      article.subheader!.tr(context),
                      style: context.textTheme().bodyMedium?.copyWith(
                          color: isAdventsNews
                              ? Palette.adventCalendarBeige
                              : Colors.white),
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

  _navigateToArticle(BuildContext context) {
    Router.of(context)
        .routerDelegate
        .setNewRoutePath(ArticleViewRoute(article: article));
  }
}
