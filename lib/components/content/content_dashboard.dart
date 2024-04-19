import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klimo/common/layout/dashboard_section.dart';
import 'package:klimo/common/layout/util.dart';
import 'package:klimo/utils/launch_url.dart';
import 'package:klimo/components/auth/cubit/auth_cubit.dart';
import 'package:klimo/components/content/articles/cubit/articles_cubit.dart';
import 'package:klimo/config/analytics.dart';
import 'package:klimo/config/constants.dart';
import 'package:klimo/utils/localisation.dart';
import 'package:klimo/utils/theme.dart';
import 'package:klimo_datamodels/articles.dart';
import 'package:url_launcher/url_launcher.dart';

import 'news_card.dart';
import 'projects/cubit/projects_list_cubit.dart';
import 'projects/project_card.dart';

class ContentDashboard extends StatelessWidget {
  const ContentDashboard({Key? key}) : super(key: key);

  static const cardWidth = 300.0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            DashboardSection(
              title: context.localisation().dashboard_news_headline,
              child: SizedBox(
                height: 180,
                child: BlocBuilder<ArticlesCubit, ArticlesState>(
                  builder: (context, state) {
                    if (state.isLoaded) {
                      final List news = state.value!
                          .where((item) => item.type == ArticleType.news)
                          .toList();
                      // deactivate sorting for now & observe if correct order is given with incoming data
                      // news.sort(
                      //     (a, b) => (b.publishedAt).compareTo(a.publishedAt));
                      return ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        children: news
                            .map((article) => Container(
                                  constraints:
                                      const BoxConstraints(maxWidth: cardWidth),
                                  child: NewsCard(
                                    article: article,
                                    actionScope: AnalyticsValues.feedScope,
                                  ),
                                ))
                            .toList(),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ),
            DashboardSection(
              title: context.localisation().dashboard_guides_headline,
              child: SizedBox(
                height: 180,
                child: BlocBuilder<ArticlesCubit, ArticlesState>(
                  builder: (context, state) {
                    if (state.isLoaded) {
                      final List guides = state.value!
                          .where((item) => item.type == ArticleType.guide)
                          .toList();
                      guides.sort(
                          (a, b) => (b.publishedAt).compareTo(a.publishedAt));
                      return ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        children: guides
                            .map((article) => Container(
                                  constraints:
                                      const BoxConstraints(maxWidth: cardWidth),
                                  child: NewsCard(
                                    article: article,
                                    actionScope: AnalyticsValues.feedScope,
                                  ),
                                ))
                            .toList(),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ),
            BlocBuilder<ProjectsListCubit, ProjectsListState>(
              builder: (context, state) {
                if (state is ProjectsListLoaded) {
                  return DashboardSection(
                    title: context.localisation().articles_projects,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      height: 200,
                      child: ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        children: [
                          Stack(
                            children: [
                              Container(
                                constraints:
                                    const BoxConstraints(maxWidth: cardWidth),
                                child: ProjectCard(
                                  headerImage: Image.asset(
                                    'assets/images/projects.png',
                                    fit: BoxFit.cover,
                                  ),
                                  title: context
                                      .localisation()
                                      .articles_projects_first_title,
                                  subtitle: context
                                      .localisation()
                                      .articles_projects_first_subtitle,
                                  onClick: () =>
                                      launchUrl(Uri.parse(ecoCrowdLink)),
                                ),
                              ),
                              Positioned(
                                bottom: 10,
                                left: 12,
                                child: Text(
                                  context
                                      .localisation()
                                      .articles_projects_first_credits,
                                  style: context
                                      .textTheme()
                                      .bodySmall!
                                      .copyWith(fontSize: 8),
                                ),
                              ),
                            ],
                          ),
                          ...state.projects
                              .map(
                                (project) => ProjectCard(
                                  headerImage: CachedNetworkImage(
                                    imageUrl: project.imageUrl,
                                    fit: BoxFit.cover,
                                  ),
                                  title: project.title,
                                  subtitle: project.summary,
                                  onClick: () {
                                    final url = Uri.parse(project.url);
                                    final state =
                                        "u_${context.read<AuthCubit>().state.value?.uid}";
                                    openUrl(url.replace(queryParameters: {
                                      ...url.queryParameters,
                                      "state": state
                                    }).toString());
                                  },
                                ),
                              )
                              .toList(),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
            DashboardSection(
              title: context.localisation().articles_actions,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    // TODO add here some logic and data when Aktionen are available, for now just show the empty "state"
                    RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                        text: context.localisation().actions_empty_message_1,
                        style: context
                            .textTheme()
                            .bodyMedium!
                            .copyWith(color: Palette.grey),
                        children: [
                          TextSpan(
                            text:
                                context.localisation().actions_empty_message_2,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => openUrl(actionLink),
                            style: const TextStyle(color: Palette.primary),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ].padded(const EdgeInsets.only(bottom: 16)),
        ),
      ),
    );
  }
}
