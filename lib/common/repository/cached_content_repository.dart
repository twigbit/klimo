import 'dart:async';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';

abstract class CachedContentRepository<T> {
  final _cacheManager = DefaultCacheManager();

  String get url;
  FutureOr<T> deserialize(String content);

  Stream<T> snapshots() {
    final fs = _cacheManager.getFileStream(url);
    return fs
        .asyncMap<T?>((file) async {
          if (file is FileInfo) {
            return _deserializeFile(file);
          }
          return null;
        })
        .where((val) => val != null)
        .cast<T>();
  }

  Future<T> _deserializeFile(FileInfo file) async {
    final content = await file.file.readAsString();
    final data = await deserialize(content);
    return data;
  }
}
