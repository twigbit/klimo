import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/cubit/api_get_cubit.dart';
import '../../../common/repository/api_repository.dart';
import '../models/story.dart';
import '../quiz/widgets/quiz_progress_indicator.dart';

class StoryProgress extends StatelessWidget {
  const StoryProgress({super.key, required this.storyId});

  final String storyId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ApiGetCubit<StoryDetails>(ApiRepository(
          path: '_/stories/$storyId',
          deserialize: (content) {
            return StoryDetails.fromJson(content['story']);
          },
          isV2: true))
        ..load(),
      child: BlocBuilder<ApiGetCubit<StoryDetails>, ApiGetState<StoryDetails>>(
        builder: (context, state) {
          return state?.whenOrNull(
                  data: (data) {
                    // show quiz progress indicator in case story contains quiz only
                    if (data.pages.where((page) => page.quiz != null).length ==
                        data.pages.length) {
                      final numberOfQuizes =
                          data.pages.where((page) => page.quiz != null).length;
                      return QuizProgressIndicator(
                        storyId: storyId,
                        totalNumberofQuestions: numberOfQuizes,
                      );
                    } else {
                      // TODO: define other cases of story content and decide what to show
                      return const SizedBox();
                    }
                  },
                  loading: () => const SizedBox()) ??
              const SizedBox();
        },
      ),
    );
  }
}
