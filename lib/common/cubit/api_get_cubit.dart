import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository/api_repository.dart';
import '../models/atoms.dart';

typedef ApiGetState<T> = Loadable<T>?;

class ApiGetCubit<T> extends Cubit<ApiGetState<T>>
    with WithErrorHandling, WithLoading {
  final ApiRepository<T> _repository;
  StreamSubscription? _sub;

  ApiGetCubit(this._repository) : super(null);

  @override
  load() async {
    if (state == null) emit(const Loadable.loading());
    _sub?.cancel();
    _sub = _repository.get(reloadCompleter: reloadCompleter).listen((event) {
      emit(Loadable.data(event));
    })
      ..onError((e) {
        debugPrint('🚨 An error occured: ${e.toString()}');
        emit(Loadable.error(e.toString()));
      });
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}
