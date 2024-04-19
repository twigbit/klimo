extension Sugar<T, V extends Iterable<T>> on V {
  T? get safeFirst => isEmpty ? null : first;
  List<T> distinct() {
    List<T> result = [];
    for (final element in this) {
      if (!result.contains(element)) result.add(element);
    }
    return result;
  }
}
