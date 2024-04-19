import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klimo/config/firebase.dart';
import 'package:klimo/utils/loading.dart';

typedef DocumentQueryState<T> = Loadable<QuerySnapshot<T>>?;
typedef QueryBuilder<T> = Query<T> Function(Query<T>);

class DocumentQueryCubit<T> extends Cubit<DocumentQueryState<T>>
    with ErrorHandling {
  final Query<T>? ref;
  final bool listen;
  StreamSubscription? sub;

  DocumentQueryCubit(this.ref, {this.listen = false}) : super(null);

  load({QueryBuilder<T>? queryBuilder}) async {
    emit(Loadable.loading());
    if (ref == null) {
      debugPrint(
          'DocumentFetcherCubit: Cannot load document without a reference');
      emit(null);
    } else {
      Query<T> query = queryBuilder != null ? queryBuilder(ref!) : ref!;
      sub?.cancel();
      if (listen) {
        sub = query.snapshots().listen((event) {
          emit(Loadable.loaded(event));
        });
      } else {
        emit(Loadable.loaded(await query.get()));
      }
    }
  }

  @override
  Future<void> close() {
    sub?.cancel();
    return super.close();
  }

  @override
  void onChange(Change<DocumentQueryState<T>> change) {
    super.onChange(change);
  }
}
