import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klimo/config/firebase.dart';
import 'package:klimo/utils/loading.dart';

typedef DocumentWriterState<T> = Loadable<bool>?;

class DocumentWriterCubit<T> extends Cubit<DocumentWriterState<T>>
    with ErrorHandling {
  final DocumentReference<T> ref;

  DocumentWriterCubit(
    this.ref,
  ) : super(Loadable.loading());

  write(T value) async {
    emit(Loadable.loading());
    await ref.upset(value);
    emit(Loadable.loaded(true));
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    emit(Loadable.loaded(false));
    super.onError(error, stackTrace);
  }
}
