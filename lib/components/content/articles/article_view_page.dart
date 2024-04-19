import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:klimo/utils/launch_url.dart';
import 'package:klimo/components/analytics_consent/cubit/consent_cubit.dart';
import 'package:klimo/components/content/articles/cubit/article_cubit.dart';
import 'package:klimo/components/user/cubit/user_cubit.dart';
import 'package:klimo/utils/theme.dart';
import 'package:klimo/utils/localisation.dart';

class ArticleViewPage extends StatefulWidget {
  const ArticleViewPage({Key? key}) : super(key: key);

  @override
  State<ArticleViewPage> createState() => _ArticleViewPageState();
}

class _ArticleViewPageState extends State<ArticleViewPage> {
  double get maxHeight => 200 + MediaQuery.of(context).padding.top;
  double get minHeight => kToolbarHeight + MediaQuery.of(context).padding.top;

  void openMarkdownLinks({
    required String href,
    String? userToken,
    String? targetId,
  }) {
    final Uri url = Uri.parse(href);
    final Uri individualUrl = url.replace(queryParameters: {
      ...url.queryParameters,
      if (userToken != null) "ut": userToken,
      if (targetId != null) "tid": targetId,
    });
    openUrl(individualUrl.toString());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArticleCubit, ArticleState>(
      builder: (context, article) {
        return Scaffold(
          appBar: article?.value == null ? AppBar() : null,
          body: article?.value == null
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : CustomScrollView(
                  slivers: [
                    if (article?.value != null)
                      SliverAppBar(
                        pinned: true,
                        stretch: true,
                        automaticallyImplyLeading: true,
                        flexibleSpace: ArticleViewPageHeader(
                          minHeight: minHeight,
                          maxHeight: maxHeight,
                          title: article?.value?.title.tr(context),
                          imageUrl: article?.value?.bannerImage.tr(context),
                        ),
                        expandedHeight:
                            maxHeight - MediaQuery.of(context).padding.top,
                        foregroundColor: Colors.white,
                        systemOverlayStyle: SystemUiOverlayStyle.light,
                      ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: (article!.value!.contentFormat == "html")
                            ? Html(
                                // data coming from webflow
                                data: article.value!.content.tr(context),
                                onLinkTap: (
                                  href,
                                  _,
                                  __,
                                ) {
                                  if (href != null) openUrl(href);
                                },
                              )
                            : MarkdownBody(
                                // data coming from Airtable (news and guides)
                                data: article.value!.content.tr(context),
                                styleSheet: MarkdownStyleSheet.fromTheme(
                                        context.theme())
                                    .copyWith(
                                  listBullet: context.textTheme().titleMedium,
                                  a: const TextStyle(
                                    color: Palette.primary,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Palette.primary,
                                  ),
                                  h1: context.textTheme().displayLarge,
                                  h2: context.textTheme().displayMedium,
                                  h3: context.textTheme().displaySmall,
                                  p: context.textTheme().bodyLarge,
                                ),

                                onTapLink: (_, href, __) {
                                  if (href != null) {
                                    if (href.contains("limesurvey")) {
                                      openMarkdownLinks(
                                          href: href,
                                          userToken: context
                                              .read<UserCubit>()
                                              .state
                                              ?.value
                                              ?.data()
                                              ?.profile
                                              ?.testUser
                                              ?.token,
                                          targetId: context
                                              .read<ConsentCubit>()
                                              .state
                                              ?.value
                                              ?.targetId
                                              .toString());
                                    } else {
                                      openMarkdownLinks(href: href);
                                    }
                                  }
                                },
                              ),
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}

class ArticleViewPageHeader extends StatelessWidget {
  final double minHeight;
  final double maxHeight;
  final String? title;
  final String? imageUrl;

  const ArticleViewPageHeader({
    super.key,
    required this.minHeight,
    required this.maxHeight,
    this.title,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double expandRatio = _calculateExpandRatio(constraints);
        final Animation<double> animation = AlwaysStoppedAnimation(expandRatio);
        return Stack(
          fit: StackFit.expand,
          children: [
            HeaderBackgroundImage(imageUrl: imageUrl ?? ""),
            HeaderTitle(
              animation: animation,
              title: title ?? "",
            ),
          ],
        );
      },
    );
  }

  double _calculateExpandRatio(BoxConstraints constraints) {
    var expandRatio =
        (constraints.maxHeight - minHeight) / (maxHeight - minHeight);
    if (expandRatio > 1.0) expandRatio = 1.0;
    if (expandRatio < 0.0) expandRatio = 0.0;
    return expandRatio;
  }
}

class HeaderBackgroundImage extends StatelessWidget {
  final String? imageUrl;
  const HeaderBackgroundImage({super.key, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: CachedNetworkImage(
            imageUrl: imageUrl ?? '',
            fit: BoxFit.cover,
          ),
        ),
        Container(color: Colors.black.withOpacity(0.5)),
      ],
    );
  }
}

class HeaderTitle extends StatelessWidget {
  final Animation<double> animation;
  final String? title;
  const HeaderTitle({
    super.key,
    required this.animation,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomLeft,
      margin: const EdgeInsets.all(12),
      child: Text(
        title ?? "",
        style: context.textTheme().headlineLarge?.copyWith(
              // decrease the size though the text is no longer seen at the end looks better with the animation
              fontSize: Tween<double>(begin: 12, end: 26).evaluate(animation),
              color: ColorTween(begin: Colors.transparent, end: Colors.white)
                  .evaluate(animation),
            ),
      ),
    );
  }
}
