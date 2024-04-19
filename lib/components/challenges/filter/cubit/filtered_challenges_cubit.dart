import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:built_collection/built_collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:klimo/utils/loading.dart';
import 'package:klimo_datamodels/challenges.dart';

import '../../../../config/firebase.dart';
import '../../list/cubit/challenge_list_cubit.dart';

part 'filtered_challenges_state.dart';

class FilteredChallengesCubit extends Cubit<FilteredChallengesState>
    with ErrorHandling {
  final ChallengeListCubit _listCubit;
  StreamSubscription? _sub;

  FilteredChallengesCubit(this._listCubit)
      : super(FilteredChallengesInitial()) {
    _sub = _listCubit.stream.listen((event) {
      _updated(event);
    });
    _updated(_listCubit.state);
  }

  _updated(Loadable<BuiltList<DocumentSnapshot<Challenge>>> event) {
    if (event.isLoading) {
      emit(FilteredChallengesInitial());
    } else {
      final Set<String?> categoryKeys =
          (event.value!.map((e) => e.data()?.category).toSet()..remove(null));
      final Set<String> selectedKeys = state is FiltersLoaded
          ? state
              .cast<FiltersLoaded>()!
              .filters
              .where((v) => categoryKeys.contains(v))
              .toSet()
          : {};
      emit(FiltersLoaded(
          BuiltSet(categoryKeys),
          BuiltSet(selectedKeys),
          BuiltList(event.value!.where((v) =>
              selectedKeys.isEmpty ||
              selectedKeys.contains(v.data()?.category)))));
    }
  }

  toggleFilter(String filter) {
    assert(this.state is FiltersLoaded);
    assert(_listCubit.state.isLoaded);
    final FiltersLoaded state = this.state as FiltersLoaded;
    BuiltSet filters = state.filters.contains(filter)
        ? BuiltSet<String>(state.filters.toSet()..remove(filter))
        : BuiltSet<String>(state.filters.toSet()..add(filter));
    emit(state.copyWith(
        filters as BuiltSet<String>,
        BuiltList(_listCubit.state.value!.where(
            (v) => filters.isEmpty || filters.contains(v.data()?.category)))));
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}
