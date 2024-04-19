import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:built_collection/built_collection.dart';
import 'package:klimo/components/community/cubit/user_community_cubit.dart';
import 'package:klimo/repositories/content_repository.dart';
import 'package:klimo/utils/loading.dart';
import 'package:klimo_datamodels/articles.dart';

import '../../../../config/firebase.dart';

typedef ArticlesState = Loadable<BuiltList<NewsModel>>;

class ArticlesCubit extends Cubit<ArticlesState> with ErrorHandling {
  NewsContentRepository? _newsRepo;

  final UserCommunityCubit _communityCubit;

  StreamSubscription? _communityIdSub;
  StreamSubscription? _newsSub;

  ArticlesCubit(this._communityCubit) : super(Loadable.loading()) {
    _communityIdSub = _communityCubit.communityId.listen((communityId) {
      load();
    });

    load();
  }

  String? _effectiveCommunityId;

  load() async {
    String? communityId =
        _communityCubit.state?.value?.data()?.community.ref.id;

    if (communityId == null) {
      // UserCommunityCubit is still loading, so we stay in the loading state
      // as well and wait for the next state of the UserCommunityCubit.
      return;
    }

    if (communityId == _effectiveCommunityId) {
      // Community didn't change so we don't need to re-init the ContentRepo here
      return;
    }

    emit(Loadable.loading());

    _newsRepo = NewsContentRepository(communityId);
    _newsSub?.cancel();
    _newsSub = _newsRepo!.snapshots().listen((event) {
      emit(Loadable.loaded(event));
    });
    _effectiveCommunityId = communityId;
  }

  @override
  Future<void> close() {
    _communityIdSub?.cancel();
    _newsSub?.cancel();
    return super.close();
  }
}
