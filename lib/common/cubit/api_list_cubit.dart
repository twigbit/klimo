import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository/api_repository.dart';
import '../models/atoms.dart';

typedef ApiListState<T> = Loadable<List<T>>?;

class ApiListCubit<T> extends Cubit<ApiListState<T>>
    with WithErrorHandling, WithLoading {
  final ApiRepository<List<T>> _repository;
  StreamSubscription? _sub;

  ApiListCubit(this._repository) : super(null);

  @override
  load({Map<String, dynamic>? queryParams}) async {
    if (state == null) emit(const Loadable.loading());
    _sub?.cancel();
    _sub = _repository
        .get(reloadCompleter: reloadCompleter, queryParameters: queryParams)
        .listen((event) {
      reloadCompleter?.complete();
      emit(Loadable.data(event));
    });
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}
