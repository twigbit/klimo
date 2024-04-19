import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:klimo/components/community/cubit/user_community_cubit.dart';
import 'package:klimo/repositories/content_repository.dart';
import 'package:klimo/utils/loading.dart';
import 'package:klimo_datamodels/articles.dart';

import '../../../../config/firebase.dart';

typedef ArticleState = Loadable<NewsModel>?;

class ArticleCubit extends Cubit<ArticleState> with ErrorHandling {
  NewsContentRepository? _newsRepo;

  final UserCommunityCubit _communityCubit;

  StreamSubscription? _communityIdSub;
  StreamSubscription? _newsSub;

  ArticleCubit(this._communityCubit) : super(null) {
    _communityIdSub = _communityCubit.communityId.listen((communityId) {
      load();
    });
  }

  String? _effectiveCommunityId;
  String? _lastArticleId;

  show(NewsModel news) {
    emit(Loadable.loaded(news));
  }

  load([String? id]) async {
    id ??= _lastArticleId;
    _lastArticleId = id;

    if (id == null) {
      debugPrint("Warning: [ArticleCubit] Article id is null.");
      return;
    }

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
      try {
        final content = event.firstWhere((item) => item.id == id);
        emit(Loadable.loaded(content));
      } on StateError {
        debugPrint(
            "Error: 404 Article with id $id in community $communityId not found.");
      }
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
