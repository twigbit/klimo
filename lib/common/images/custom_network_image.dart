import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'image_utility.dart';
import '../models/attachement.dart';

class CustomNetworkImage extends StatelessWidget {
  final String imageUrl;
  final BoxFit? fit;
  final Widget? placeholder;
  final double? height;
  final double? width;
  final Alignment? alignment;

  const CustomNetworkImage({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.height,
    this.width,
    this.alignment,
  });

  factory CustomNetworkImage.withPlaceholder(
    Attachement attachement,
    BuildContext context, {
    double? height,
    double width = 750,
    quality = kDefaultQuality,
    BoxFit? fit,
  }) =>
      CustomNetworkImage(
        imageUrl: optimizedImageUrl(
            src: attachement.url,
            width: width,
            height: height,
            quality: quality,
            context: context),
        fit: fit ?? BoxFit.cover,
        // show a logo when images are loadings
        placeholder: Container(
          color: Colors.blueGrey.shade200,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fadeInDuration: const Duration(milliseconds: 100),
      fadeOutDuration: const Duration(milliseconds: 100),
      placeholderFadeInDuration: const Duration(milliseconds: 50),
      alignment: alignment ?? Alignment.center,
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      placeholder: (context, url) => placeholder ?? Container(),
      errorWidget: (context, url, error) => const Icon(
        Icons.image_not_supported_outlined,
        color: Colors.grey,
      ),
    );
  }
}
