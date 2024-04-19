import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:package_info_plus/package_info_plus.dart';

/*
This is a generic repository for fetching data from the backend.
 */

typedef ApiListRepository<T> = ApiRepository<List<T>>;

class ApiRepository<T> {
  final _cacheManager = DefaultCacheManager();

  final String path;
  final FutureOr<T> Function(Map<String, dynamic> json) deserialize;
  final Map<String, dynamic>? queryParameters;
  final Map<String, String>? headers;
  final bool isV2;
  ApiRepository(
      {required this.path,
      required this.deserialize,
      this.queryParameters,
      this.headers,
      this.isV2 = false});

  Stream<T> get(
          {String? id,
          Completer<void>? reloadCompleter,
          final Map<String, dynamic>? queryParameters}) =>
      isV2
          ? _stream(
              Uri(
                scheme: 'https',
                host: '2zero-api-git-feature-quiz-content-twigbit.vercel.app',
              ).replace(
                  path: '/v1/community/$path${id != null ? "/$id" : ""}',
                  queryParameters: {
                    if (queryParameters != null) ...queryParameters,
                    if (this.queryParameters != null) ...this.queryParameters!
                  }),
              reloadCompleter)
          : _stream(
              Uri(
                scheme: 'https',
                host: '2zero-api-git-feature-quiz-content-twigbit.vercel.app',
              ).replace(
                  path: '/api/v2/$path${id != null ? "/$id" : ""}',
                  queryParameters: {
                    if (queryParameters != null) ...queryParameters,
                    if (this.queryParameters != null) ...this.queryParameters!
                  }),
              reloadCompleter);

  Stream<T> _stream(Uri uri, [Completer<void>? reloadCompleter]) async* {
    final fs = _cacheManager.getFileStream(uri.toString(),
        headers: {"user-agent": await userAgent(), ...(headers ?? {})});
    yield* fs
        .asyncMap<T?>((file) async {
          if (file is FileInfo) {
            if (file.source == FileSource.Online) {
              reloadCompleter?.complete();
            }
            try {
              return deserialize(jsonDecode(await file.file.readAsString()));
            } catch (e) {
              debugPrint('Unable to deserialize ${deserialize.runtimeType}');
              debugPrint(e.toString());
              return null;
            }
          }
          return null;
        })
        .where((val) => val != null)
        .cast<T>();
  }
}

Future<String> userAgent() async {
  final packageInfo = await PackageInfo.fromPlatform();
  var deviceInfo = "unknown/0";
  if (Platform.isAndroid) {
    final androidInfo = await DeviceInfoPlugin().androidInfo;
    deviceInfo = 'android/${androidInfo.version.release}';
    if (!androidInfo.isPhysicalDevice) {
      deviceInfo += ' (simulator)';
    }
  }
  if (Platform.isIOS) {
    final iosInfo = await DeviceInfoPlugin().iosInfo;
    deviceInfo = 'ios/${iosInfo.systemVersion}';
    if (!iosInfo.isPhysicalDevice) {
      deviceInfo += ' (simulator)';
    }
  }
  return '${packageInfo.packageName}/${packageInfo.version} '
      '(${packageInfo.buildNumber}) dart/${Platform.version.split(" ").first} $deviceInfo';
}
