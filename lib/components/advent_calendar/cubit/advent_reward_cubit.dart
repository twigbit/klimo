import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:klimo/common/cubit/document_query_cubit.dart';
import 'package:klimo/config/firebase.dart';
import 'package:klimo/config/firebase_http_functions.dart';
import 'package:http/http.dart' as http;
import 'package:klimo/utils/loading.dart';
import 'package:klimo_datamodels/rewards.dart';

typedef AdventRewardState = Loadable<bool>?;

class AdventRewardCubit extends Cubit<AdventRewardState> with ErrorHandling {
  final DocumentQueryCubit<UserRewardModel> _userRewardCubit;
  final String rewardId;

  AdventRewardCubit(this._userRewardCubit, this.rewardId)
      : super(Loadable.loaded(false)) {
    if (_userRewardCubit.state?.value != null) {
      if (_userRewardCubit.state!.value!.docs
          .any((document) => document.id == rewardId)) {
        emit(Loadable.loaded(true));
      }
    }
  }

  redeemReward(String rewardId) async {
    emit(Loadable.loading());

    try {
      final queryParameters = {
        'uid': FirebaseAuth.instance.currentUser!.uid,
        'rewardId': rewardId,
      };
      final uri = Uri.parse(FirebaseHttpFunctions.instance.getFunctionUrl(
        'assignExplicitReward',
        queryParameters,
      ));
      await http.get(uri, headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      });
      emit(Loadable.loaded(true));
    } catch (error) {
      debugPrint(error.toString());
      emit(Loadable.loaded(false));
    }
  }
}
