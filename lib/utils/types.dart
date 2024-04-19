mixin Castable<G> on Object {
  T? cast<T extends G>() => this is T ? this as T : null;
}
