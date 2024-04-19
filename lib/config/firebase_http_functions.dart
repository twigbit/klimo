// The code of this file is taken from FlutterFires `cloud_functions` package:
// https://github.com/firebase/flutterfire/blob/f1dae735483bf293c4b18a8ff7c3ab6ca3cbe6e7/packages/cloud_functions/cloud_functions/lib/src/firebase_functions.dart
//
// Modifications (c) Copyright 2022, twigbit technologies GmbH

// Copyright 2019, the Chromium project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Copyright 2018, the Chromium project authors. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are
// met:
//
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above
//       copyright notice, this list of conditions and the following
//       disclaimer in the documentation and/or other materials provided
//       with the distribution.
//     * Neither the name of Google Inc. nor the names of its
//       contributors may be used to endorse or promote products derived
//       from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
// "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
// LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
// A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
// OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
// SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
// LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
// DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
// THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class FirebaseHttpFunctions {
  static const defaultRegion = "europe-west1";

  static final Map<String, FirebaseHttpFunctions> _cachedInstances = {};

  /// Returns an instance using the default [FirebaseApp] and region.
  static FirebaseHttpFunctions get instance {
    return FirebaseHttpFunctions.instanceFor();
  }

  /// Returns an instance using a specified [FirebaseApp] & region.
  static FirebaseHttpFunctions instanceFor({FirebaseApp? app, String? region}) {
    app ??= Firebase.app();
    region ??= defaultRegion;
    String cachedKey = '${app.name}_$region';

    if (_cachedInstances.containsKey(cachedKey)) {
      return _cachedInstances[cachedKey]!;
    }

    FirebaseHttpFunctions newInstance = FirebaseHttpFunctions._(app, region);
    _cachedInstances[cachedKey] = newInstance;

    return newInstance;
  }

  FirebaseHttpFunctions._(this.app, this.region);

  final FirebaseApp app;
  final String region;

  String? _baseUrl;

  String get baseUrl =>
      _baseUrl ??
      "https://$region-${app.options.projectId}.cloudfunctions.net/";

  /// Return the URL to a firebase http function.
  ///
  /// Set the [functionName] of the function you want to call
  /// Use the [params] Map to append values to the search string
  String getFunctionUrl(String functionName, [Map<String, String>? params]) {
    final base = Uri.parse(baseUrl);
    final uri = base.replace(
      pathSegments:
          [...base.pathSegments, functionName].where((s) => s.isNotEmpty),
      queryParameters: params,
    );
    return uri.toString();
  }

  /// Changes this instance to point to a Cloud Functions emulator running locally.
  ///
  /// Set the [host] of the local emulator, such as "localhost"
  /// Set the [port] of the local emulator, such as "5001" (port 5001 is default for functions package)
  void useFunctionsEmulator(String host, int port) {
    String mappedHost = host;
    // Android considers localhost as 10.0.2.2 - automatically handle this for users.
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
      if (mappedHost == 'localhost' || mappedHost == '127.0.0.1') {
        // ignore: avoid_print
        print('Mapping Functions Emulator host "$mappedHost" to "10.0.2.2".');
        mappedHost = '10.0.2.2';
      }
    }

    _baseUrl = 'http://$mappedHost:$port/${app.options.projectId}/$region/';
  }
}
