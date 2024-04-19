import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klimo_datamodels/articles.dart';

import '../../config/analytics.dart';
import '../content/articles/cubit/articles_cubit.dart';
import '../content/news_card.dart';

class NewsSection extends StatelessWidget {
  const NewsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArticlesCubit, ArticlesState>(
      builder: (context, state) {
        if (state.isLoaded) {
          final List<NewsModel> articles = state.value!.toList();
          articles.sort((a, b) => b.publishedAt.compareTo(a.publishedAt));
          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: articles.map(
              (article) {
                return Container(
                  constraints: const BoxConstraints(maxWidth: 300),
                  child: NewsCard(
                    article: article,
                    actionScope: AnalyticsValues.homeScreenScope,
                  ),
                );
              },
            ).toList(),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
