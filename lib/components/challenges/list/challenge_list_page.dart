import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klimo/common/layout/klimo_bottom_sheet.dart';
import 'package:klimo/components/challenges/common/single_challenge_view.dart';
import 'package:klimo/config/constants.dart';
import 'package:klimo/utils/localisation.dart';
import 'package:klimo_datamodels/challenges.dart';

import '../../../common/cubit/document_fetcher_cubit.dart';
import '../filter/category_filter_row.dart';
import '../filter/cubit/filtered_challenges_cubit.dart';
import 'challenge_list_card.dart';

class ChallengeListPage extends StatelessWidget {
  final String title;

  const ChallengeListPage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: BlocBuilder<FilteredChallengesCubit, FilteredChallengesState>(
          builder: (context, state) {
        if (state is FiltersLoaded) {
          return Stack(
            children: [
              ChallengesList(challenges: state.challenges.toList()),
              const CategoryFilterRow(),
            ],
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      }),
    );
  }
}

class ChallengesList extends StatelessWidget {
  final List<DocumentSnapshot<Challenge>> challenges;
  const ChallengesList({Key? key, required this.challenges}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 56),
      itemCount: challenges.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: ChallengeListCard(
            challengeSnap: challenges[index],
            onTap: (() => _openChallengeSingleView(context, index)),
          ),
        );
      },
    );
  }

  void _openChallengeSingleView(
    BuildContext context,
    int index,
  ) async {
    await showKlimoModalBottomSheet(
      context: context,
      builder: (ctx) => BlocProvider(
        create: (context) => DocumentFetcherCubit<Challenge>(
            challenges[index].reference,
            listen: true)
          ..load(),
        child: BlocBuilder<DocumentFetcherCubit<Challenge>,
            DocumentFetcherState<Challenge>>(
          builder: (context, state) {
            if (state.isLoaded) {
              final Challenge challenge = state.value!.data()!;
              return KlimoBottomSheet(
                  header: const KlimoBottomSheetHeader(),
                  body: SingleChallengeView(
                    category: challenge.category,
                    title: challenge.title.tr(context),
                    content: challenge.content.tr(context),
                    information: challenge.informations?.tr(context),
                    isRecurring: challenge.type == recurring,
                    coins: challenge.coins,
                    emissionSavings: challenge.emissionSavings,
                  ));
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
