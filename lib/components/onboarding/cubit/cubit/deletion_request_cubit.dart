import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:klimo/common/cubit/document_query_cubit.dart';
import 'package:klimo/components/auth/cubit/auth_cubit.dart';
import 'package:klimo/utils/loading.dart';
import 'package:klimo_datamodels/user.dart';

import '../../../../config/firebase.dart';

typedef DeletionRequestState = Loadable<DocumentSnapshot<DeletionRequest>>;

class DeletionRequestCubit extends DocumentQueryCubit<DeletionRequest> {
  final AuthCubit _authCubit;
  StreamSubscription? _authSub;

  DeletionRequestCubit(this._authCubit)
      : super(fb.deletionRequestCollection(), listen: true) {
    _authSub = _authCubit.stream.listen((state) {
      if (state.value != null) {
        load(
            queryBuilder: (b) => b
                .where('userRef', isEqualTo: state.value!.ref)
                .where('status', isEqualTo: DeletionRequestStatus.pending.name)
                .limit(1));
      } else {
        sub?.cancel();
        emit(null);
      }
    });
  }
  @override
  Future<void> close() {
    _authSub?.cancel();
    return super.close();
  }
}
