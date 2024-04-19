import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:built_collection/built_collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:klimo/utils/iterable.dart';
import 'package:klimo/components/community/cubit/user_community_cubit.dart';
import 'package:klimo/components/user/cubit/user_cubit.dart';
import 'package:klimo/config/analytics.dart';
import 'package:klimo/config/firebase.dart';
import 'package:klimo_datamodels/community.dart';
import 'package:klimo_datamodels/user.dart';

part 'join_community_state.dart';

class JoinCommunityCubit extends Cubit<JoinCommunityState> with ErrorHandling {
  final UserCommunityCubit communityCubit;
  StreamSubscription? loadCommuntiyBlocSub;
  final UserCubit userCubit;

  List<QueryDocumentSnapshot<UserCommuntityReference>>? _userCommunities;

  JoinCommunityCubit(this.communityCubit, this.userCubit)
      : super(JoinCommunityInitial());

  loadCommunities() async {
    List<QueryDocumentSnapshot<CommunityModel>> communities = (await fb
            .communityCollection<CommunityModel>()
            .where('config.visibility', whereIn: ['public', 'fallback']).get())
        .docs;
    _userCommunities = (await fb
            .userCollection()
            .userDoc()!
            .communityCollection<UserCommuntityReference>()
            .get())
        .docs;
    BuiltList<CommunityRef> allCommunities = BuiltList.from([
      ..._userCommunities!.map<CommunityRef>((e) => e.data().community),
      ...communities.map<CommunityRef>((e) => CommunityRef.fromSnapshot(e))
    ].distinct());

    int? currentCommunityIndex = allCommunities.indexWhere((element) =>
        element.ref.id ==
        communityCubit.state?.value?.data()?.community.ref.id);
    if (currentCommunityIndex == -1) currentCommunityIndex = null;
    emit(CommunitiesLoaded(
      allCommunities,
      selectedCommunityIndex: currentCommunityIndex,
    ));
  }

  selectCommunity(int? selectedCommunityIndex) {
    assert(this.state is CommunitiesLoaded);
    final CommunitiesLoaded state = this.state as CommunitiesLoaded;
    emit(CommunitiesLoaded(state.communities,
        selectedCommunityIndex: selectedCommunityIndex));
  }

  joinCommunity() async {
    assert(this.state is CommunitiesLoaded);
    final CommunitiesLoaded state = this.state as CommunitiesLoaded;
    assert(state.communities.isNotEmpty);

    CommunityRef community;
    if (state.selectedCommunityIndex == null) {
      QueryDocumentSnapshot<CommunityModel> fallback = (await fb
              .communityCollection<CommunityModel>()
              .where('config.visibility', isEqualTo: 'fallback')
              .get())
          .docs
          .first;
      community = CommunityRef.fromSnapshot(fallback);
    } else if (state.selectedCommunityIndex! >= 0) {
      community = state.communities[state.selectedCommunityIndex!];
    } else {
      throw ('Internal Error: The community selection is invalid');
    }
    DocumentSnapshot<UserModel> user = userCubit.state!.value!;
    DocumentReference<UserCommuntityReferenceUpdate> userCommunityDoc = user
        .reference
        .communityCollection<UserCommuntityReferenceUpdate>()
        .doc(community.ref.id);

    WriteBatch batch = firestore.batch();
    batch.upset<UserCommuntityReferenceUpdate>(
        userCommunityDoc,
        UserCommuntityReferenceUpdate(
            (b) => b..community = community.toBuilder()));
    batch.upset<UserRef>(community.ref.userCollection<UserRef>().doc(user.id),
        UserRef.fromSnapshot(user));
    batch.upset<UserUpdate>(
        user.reference.type(),
        UserUpdate((updates) =>
            updates..context.activeCommunity = userCommunityDoc.type()));
    await batch.commit();

    // analytics
    analytics.setCommunityProperty(communityId: community.ref.id);
    if (communityCubit.state?.value?.data()?.community.ref.id != null &&
        state.selectedCommunityIndex != null &&
        state.selectedCommunityIndex != -1) {
      analytics.logUpdateCommunity(
        params: {
          AnalyticsParameters.previousValue:
              communityCubit.state?.value?.data()?.community.ref.id,
          AnalyticsParameters.value:
              state.communities[state.selectedCommunityIndex!].ref.id,
        },
      );
    }
    analytics.logJoinCommunity(
      params: {
        AnalyticsParameters.communityId: community.ref.id,
        AnalyticsParameters.communityName: community.name["de"],
        AnalyticsParameters.communityNameEN: community.name["en"],
      },
    );
  }

  @override
  Future<void> close() {
    loadCommuntiyBlocSub?.cancel();
    return super.close();
  }
}
