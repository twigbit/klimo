import 'package:flutter/material.dart';
import 'package:klimo/utils/theme.dart';

const sizeValues = [
  16,
  32,
  48,
  64,
  96,
  128,
  256,
  384,
  640,
  750,
  828,
  1080,
  1200,
  1920,
  2048,
  3840
];

const kDefaultQuality = 50;

String optimizedImageUrl({
  required String src,
  required BuildContext context,
  double? width = 200,
  double? height,
  int quality = kDefaultQuality,
}) {
  final srcUrl = Uri.parse(src);
  // Check if the image URL qualifies for optimisation
  if (srcUrl.host.endsWith('twigbit.vercel.app') ||
      srcUrl.host == 'localhost' ||
      srcUrl.host == 'api.2zero.dev') {
    final scalingFactor = context.media.devicePixelRatio;
    final scaledWidth = width != null ? width * scalingFactor : null;
    final scaledHeight = height != null ? height * scalingFactor : null;
    int? applicableWidth = scaledWidth != null
        ? sizeValues.fold(
            10000000,
            (previousValue, element) => (element - (scaledWidth).abs() <
                    (previousValue! - scaledWidth).abs()
                ? element
                : previousValue))
        : null;
    int? applicableHeight = scaledHeight != null && width == null
        ? sizeValues.fold(
            10000000,
            (previousValue, element) => (element - scaledHeight).abs() <
                    (previousValue! - scaledHeight).abs()
                ? element
                : previousValue)
        : null;
    final base = "https://${srcUrl.host}/_next/image";
    final url =
        "$base?url=${Uri.encodeComponent(src)}${(applicableHeight != null) ? "&h=$applicableHeight" : ""}${(applicableWidth != null) ? "&w=$applicableWidth" : ""}&q=$quality";
    return url;
  }
  return src;
}
