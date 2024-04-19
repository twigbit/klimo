import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:klimo/utils/localisation.dart';

import '../../config/firebase.dart';
import '../../utils/iterable.dart';

part 'atoms.freezed.dart';

typedef Translation<T> = Map<String, T>;

extension TranslationExtension<T> on Translation<T> {
  T tr(BuildContext context) {
    return this[context.locale().toString()] ?? values.safeFirst;
  }
}

@freezed
class Loadable<T> with _$Loadable<T> {
  const Loadable._();
  const factory Loadable.data(T value) = Data<T>;
  const factory Loadable.loading() = Loading<T>;
  const factory Loadable.error(String? message) = Error<T>;

  Widget build(Widget Function(T value) builder) => when(
        data: (value) => builder(value),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (message) => Text('Error: $message'),
      );

  T? get value => whenOrNull(data: (value) => value);
}

mixin WithErrorHandling<T> on BlocBase<T> {
  @override
  void onError(error, stackTrace) {
    debugPrint('Error in ${runtimeType.toString()}: ${error.toString()}');
    debugPrint(stackTrace.toString());
    if (!kIsWeb) crashlytics.recordError(error, stackTrace);
    super.onError(error, stackTrace);
  }
}

mixin WithLoading<T> on Cubit<Loadable<T>?> {
  void load();
  Completer<void>? reloadCompleter;
  Future<void> reload() {
    if (state is Loading) return Future.value();
    if (reloadCompleter?.isCompleted ?? true) {
      reloadCompleter = Completer<void>();
      load();
    }
    return reloadCompleter!.future;
  }

  @override
  void onChange(Change<Loadable<T>?> change) {
    change.nextState?.whenOrNull(
      data: (data) {
        reloadCompleter?.complete();
      },
    );
    super.onChange(change);
  }
}
