import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klimo/common/buttons/elevated_button.dart';
import 'package:klimo/components/community/community_fragment.dart';
import 'package:klimo/components/community/cubit/join_community_cubit.dart';
import 'package:klimo/components/onboarding/cubit/onboarding_cubit.dart';
import 'package:klimo/components/onboarding/onboarding_layout.dart';
import 'package:klimo/config/analytics.dart';
import 'package:klimo/config/firebase.dart';
import 'package:klimo/utils/localisation.dart';

import '../../community/cubit/user_community_cubit.dart';
import '../../user/cubit/user_cubit.dart';

class CommunityPage extends StatelessWidget {
  const CommunityPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => JoinCommunityCubit(
        context.read<UserCommunityCubit>(),
        context.read<UserCubit>(),
      )..loadCommunities(),
      child: BlocConsumer<JoinCommunityCubit, JoinCommunityState>(
        listener: (context, state) {
          if (state is JoinCommunitySuccess) {
            context.read<OnboardingCubit>().check();
          }
        },
        builder: (BuildContext context, state) {
          return OnboardingLayout(
              headerAction: TextButton(
                  onPressed: () {
                    context.read<JoinCommunityCubit>().selectCommunity(null);
                    context.read<JoinCommunityCubit>().joinCommunity();

                    // analytics
                    analytics.logOnboardingAction(
                        action: AnalyticsValues.skipCommunitySelection);
                  },
                  child: Text(context.localisation().action_skip)),
              primaryButton: ElevatedButton(
                onPressed: state is CommunitiesLoaded &&
                        state.selectedCommunityIndex != null
                    ? () {
                        context.read<JoinCommunityCubit>().joinCommunity();
                        // analytics
                        analytics.logOnboardingAction(
                            action: AnalyticsValues.joinCommunity);
                      }
                    : null,
                child: Text(context.localisation().action_save),
              ).expanded(),
              progress: 3 / 7,
              decoration: state is JoinCommunityLoading
                  ? OnboardingLayoutDecoration.loading
                  : state is JoinCommunitySuccess
                      ? OnboardingLayoutDecoration.success
                      : null,
              title: context.localisation().community_select_title,
              child: const CommunityFragment());
        },
      ),
    );
  }
}
