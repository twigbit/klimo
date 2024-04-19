import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klimo/config/firebase.dart';
import 'package:klimo/utils/loading.dart';

typedef DocumentFetcherState<T> = Loadable<DocumentSnapshot<T>?>;

class DocumentFetcherCubit<T> extends Cubit<DocumentFetcherState<T>>
    with ErrorHandling {
  final DocumentReference<T>? ref;
  final bool listen;
  StreamSubscription? _sub;

  DocumentFetcherCubit(this.ref, {this.listen = false})
      : super(Loadable.loading());

  load() async {
    if (ref == null) {
      debugPrint(
          'DocumentFetcherCubit: Cannot load document without a reference');
      emit(Loadable.loaded(null));
    } else {
      if (listen) {
        _sub?.cancel();
        _sub = ref!.snapshots().listen((event) {
          emit(Loadable.loaded(event));
        });
      } else {
        emit(Loadable.loaded(await ref!.get()));
      }
    }
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}
