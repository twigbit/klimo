import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../common/cubit/api_list_cubit.dart';
import '../../common/layout/story_card.dart';
import '../stories/models/story.dart';
import '../stories/widgets/story_progress.dart';

class StoriesSection extends StatelessWidget {
  const StoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ApiListCubit(StoriesRepository())..load(),
      child: BlocBuilder<StoriesCubit, StoriesState>(
          builder: (context, state) =>
              state?.whenOrNull(
                data: (data) {
                  return ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: data
                        .map(
                          (story) => Container(
                            constraints: const BoxConstraints(maxWidth: 300),
                            child: Stack(
                              children: [
                                StoryCard(item: story),
                                Positioned(
                                  top: 16,
                                  right: 16,
                                  child: StoryProgress(storyId: story.id),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  );
                },
              ) ??
              const SizedBox()),
    );
  }
}
