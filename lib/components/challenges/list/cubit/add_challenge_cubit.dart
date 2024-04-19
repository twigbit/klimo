import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klimo/components/challenges/dashboard/cubit/user_challenge_list_cubit.dart';
import 'package:klimo/components/community/cubit/user_community_cubit.dart';
import 'package:klimo/components/user/cubit/user_cubit.dart';
import 'package:klimo/config/analytics.dart';
import 'package:klimo/config/date.dart';
import 'package:klimo/utils/loading.dart';
import 'package:klimo_datamodels/challenges.dart';
import 'package:klimo_datamodels/user.dart';

import '../../../../config/firebase.dart';

typedef AddChallengeState = Loadable<bool>;

class AddChallengeCubit extends Cubit<AddChallengeState> with ErrorHandling {
  final DocumentSnapshot<Challenge> challenge;
  final UserCommunityCubit _communityCubit;
  final UserCubit _userCubit;
  final UserChallengeListCubit _userListCubit;

  AddChallengeCubit(this.challenge, this._communityCubit, this._userCubit,
      this._userListCubit)
      : super(Loadable.loaded(false)) {
    if (_userListCubit.state?.value != null) {
      if (_userListCubit.state!.value!.docs
          .any((v) => v.data().challenge.ref.id == challenge.id)) {
        emit(Loadable.loaded(true));
      }
    }
  }

  addChallenge() async {
    emit(Loadable.loading());
    WriteBatch batch = firestore.batch();

    final UserChallenge challengeCopy = UserChallenge((b) => b
      ..challenge = ChallengeRef.fromSnapshot(challenge).toBuilder()
      ..community = _communityCubit.state!.value!.data()!.community.toBuilder()
      ..state.startedAt = _userListCubit.timeframeCubit.state.start);

    batch.upset(
        _userCubit.state!.value!.reference
            .challengeCollection<UserChallenge>()
            .doc(),
        challengeCopy);
    batch.upset(challengeCopy.challenge.ref.userCollection<UserRef>().doc(),
        UserRef.fromSnapshot(_userCubit.state!.value!));
    await batch.commit();

    // log event
    analytics.logChallengeAdded(
      params: {
        AnalyticsParameters.challengeId: challenge.id,
        AnalyticsParameters.challengeRootId: challenge.data()?.rootId,
        AnalyticsParameters.challengeTitle: challenge.data()?.title["de"],
        AnalyticsParameters.challengeTitleEN: challenge.data()?.title["en"],
        AnalyticsParameters.challengeCategory: challenge.data()?.category,
        AnalyticsParameters.challengeCoins: challenge.data()?.coins,
        AnalyticsParameters.challengeEmissionSavings:
            challenge.data()?.emissionSavings,
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
        AnalyticsParameters.challengeStart:
            (_userListCubit.timeframeCubit.state.start).toReadableDate(),
        AnalyticsParameters.challengeEnd:
            (_userListCubit.timeframeCubit.state.end).toReadableDate(),
      },
    );
    emit(Loadable.loaded(true));
  }

  @override
  void onChange(Change<AddChallengeState> change) {
    super.onChange(change);
  }
}
