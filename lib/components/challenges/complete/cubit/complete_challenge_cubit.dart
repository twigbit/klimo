import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klimo/components/community/cubit/user_community_cubit.dart';
import 'package:klimo/config/analytics.dart';
import 'package:klimo/utils/loading.dart';
import 'package:klimo_datamodels/challenges.dart';

import '../../../../config/firebase.dart';

typedef CompleteChallengeState = Loadable<bool>?;

class CompleteChallengeCubit extends Cubit<CompleteChallengeState>
    with ErrorHandling {
  final DocumentSnapshot<UserChallenge> challenge;
  final UserCommunityCubit _communityCubit;

  CompleteChallengeCubit(
    this.challenge,
    this._communityCubit,
  ) : super(null);

  void complete(bool success) async {
    emit(Loadable.loading());
    UserChallengeUpdate update = UserChallengeUpdate((b) => b
      ..state.completedAt = DateTime.now()
      ..state.success = success);

    await challenge.reference.type<UserChallengeUpdate>().upset(update);

    // log analytics event
    analytics.logChallengeCompleted(
      params: {
        AnalyticsParameters.challengeSuccess: success ? 1 : 0,
        AnalyticsParameters.challengeId: challenge.data()?.challenge.ref.id,
        AnalyticsParameters.challengeRootId: challenge.data()?.challenge.rootId,
        AnalyticsParameters.challengeTitle:
            challenge.data()?.challenge.title["de"],
        AnalyticsParameters.challengeTitleEN:
            challenge.data()?.challenge.title["en"],
        AnalyticsParameters.challengeCategory:
            challenge.data()?.challenge.category,
        AnalyticsParameters.challengeCoins:
            success ? challenge.data()?.challenge.coins : 0,
        AnalyticsParameters.challengeEmissionSavings:
            success ? challenge.data()?.challenge.emissionSavings : 0,
        AnalyticsParameters.communityId:
            _communityCubit.state?.value?.data()?.community.ref.id,
        AnalyticsParameters.communityName:
            _communityCubit.state?.value?.data()?.community.name["de"],
        AnalyticsParameters.communityNameEN:
            _communityCubit.state?.value?.data()?.community.name["en"],
        AnalyticsParameters.departmentId:
            _communityCubit.state?.value?.data()?.department?.ref.id,
        AnalyticsParameters.departmentName:
            _communityCubit.state?.value?.data()?.department?.name["de"],
        AnalyticsParameters.departmentNameEN:
            _communityCubit.state?.value?.data()?.department?.name["en"],
        AnalyticsParameters.teamId:
            _communityCubit.state?.value?.data()?.team?.ref.id,
        AnalyticsParameters.teamName:
            _communityCubit.state?.value?.data()?.team?.name,
      },
    );
  }

  void reset() async {
    emit(Loadable.loading());

    await challenge.reference.type<UserChallengeUpdate>().update({
      'state.completedAt': FieldValue.delete(),
      'state.success': FieldValue.delete()
    });
    emit(null);
  }

  @override
  void onChange(Change<CompleteChallengeState> change) {
    super.onChange(change);
  }
}
