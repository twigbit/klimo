import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Loadable<T> extends Equatable with Castable<Loadable<T>> {
  final T? _value;

  const Loadable._(this._value);

  bool get isLoading => !isLoaded;
  bool get isLoaded => this is Loaded;

  Loaded<T>? get asLoaded => cast<Loaded<T>>();

  // TODO experiment with snapshot alternative.
  T? get value => _value;

  // V? data<V>() =>
  //     T is DocumentSnapshot<V> ? (_value as DocumentSnapshot<V>).data() : null;

  factory Loadable.loading() => Loading<T>._();
  factory Loadable.loaded(T value) => Loaded<T>._(value);

  @override
  List<Object?> get props => [
        _value,
        isLoading,
      ];
}

class Loaded<T> extends Loadable<T> {
  const Loaded._(T value) : super._(value);

  @override
  T get value => _value as T;
}

class Loading<T> extends Loadable<T> {
  const Loading._() : super._(null);
}

extension WithSnapshotSugar<T> on Loadable<DocumentSnapshot<T>?> {
  T? data() => _value?.data();
}

mixin Castable<G> on Object {
  T? cast<T extends G>() => this is T ? this as T : null;
}
