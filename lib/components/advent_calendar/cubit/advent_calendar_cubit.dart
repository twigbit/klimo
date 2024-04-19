import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:klimo/components/advent_calendar/data/advent_calendar_repository.dart';
import 'package:klimo/config/firebase.dart';
import 'package:klimo/utils/loading.dart';
import 'package:klimo_datamodels/advent_calendar.dart';

typedef AdventCalendarState = Loadable<BuiltList<AdventCalendarModel>>;

class AdventCalendarCubit extends Cubit<AdventCalendarState>
    with ErrorHandling {
  AdventCalendarRepository? _adventCalendarRepo;
  StreamSubscription? _adventCalendarSub;
  StreamSubscription? _openedCardsSub;

  BuiltList<AdventCalendarModel> adventData = BuiltList([]);
  BuiltList<String> openedCards = BuiltList([]);

  AdventCalendarCubit() : super(Loadable.loading()) {
    load();
  }

  load() async {
    _openedCardsSub?.cancel;
    _adventCalendarSub?.cancel;
    emit(Loadable.loading());
    _adventCalendarRepo = AdventCalendarRepository();
    _adventCalendarSub = _adventCalendarRepo!.snapshots().listen((event) {
      adventData = event;
      update();
    });

    _openedCardsSub = fb
        .userCollection()
        .doc(auth.currentUser?.uid)
        .adventCalendarCollection<OpenedCardModel>()
        .snapshots()
        .listen((event) {
      openedCards = event.docs.map((e) => e.id).toBuiltList();
      update();
    });
  }

  update() {
    if (adventData.isNotEmpty) {
      emit(Loadable.loaded(adventData
          .map((e) =>
              e.rebuild((b) => b..isOpen = openedCards.contains(e.date.id)))
          .toBuiltList()));
    }
  }

  openCalendarCard(String id) async {
    final OpenedCardModel openedCard =
        OpenedCardModel((builder) => builder..isOpened = true);

    try {
      await fb
          .userCollection()
          .doc(auth.currentUser?.uid)
          .adventCalendarCollection<OpenedCardModel>()
          .doc(id)
          .upset(openedCard);
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  @override
  Future<void> close() {
    _adventCalendarSub?.cancel();
    _openedCardsSub?.cancel();
    return super.close();
  }
}

extension WithDateId on DateTime {
  String get id => "$year$month$day";
}
