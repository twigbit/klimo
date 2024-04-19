extension FormattedOutput on num {
  toFixedLengthString() {
    if (this < 100) {
      return this is int ? toString() : toStringAsFixed(1);
    } else if (this < 1000) {
      return toStringAsFixed(0);
    } else {
      return "${(this / 1000.0).toStringAsFixed(1)}k";
    }
  }
}
