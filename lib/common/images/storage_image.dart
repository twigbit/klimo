import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:klimo/config/firebase.dart';
import 'package:klimo_datamodels/util.dart';
import 'package:path/path.dart';

typedef ImageBuilder = Widget Function(BuildContext, String)?;

class StorageImage extends StatelessWidget {
  final Future<String> future;
  final ImageBuilder builder;

  factory StorageImage.thumb(ImageModel image, {ImageBuilder? builder}) =>
      StorageImage._(
        future: (() async => (await image.thumbUrl) ?? image.downloadUrl)(),
        builder: builder,
      );

  factory StorageImage(ImageModel image, {ImageBuilder? builder}) =>
      StorageImage._(
        future: Future.value(image.downloadUrl),
        builder: builder,
      );

  const StorageImage._({Key? key, required this.future, this.builder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: future,
        builder: (context, snapshot) {
          return snapshot.data != null
              ? builder != null
                  ? builder!(context, snapshot.data!)
                  : CachedNetworkImage(
                      imageUrl: snapshot.data!,
                      fit: BoxFit.cover,
                    )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        });
  }
}

extension WithStorage on ImageModel {
  Future<String?> get thumbUrl async {
    String thumbPath =
        storagePath.replaceAll(extension(storagePath), "_200x200.jpeg");
    try {
      return await storage.ref(thumbPath).getDownloadURL();
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }
}
