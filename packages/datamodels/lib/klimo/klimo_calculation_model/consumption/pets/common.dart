import 'dart:math' as math;

/// Rounds the input [val] to the nearest multiple of [step].
/// It constrains the output to be in the inclusive range from [min] to [max].
num roundToNearest(num val, num min, num max, num step) {
  num off = val % step;
  val -= off;
  val += (off < (step / 2)) ? 0 : step;
  return math.min(max, math.max(min, val));
}
