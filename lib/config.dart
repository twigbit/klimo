import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import 'firebase_options_klimo_preview.dart' as firebase_preview;
import 'firebase_options_klimo_production.dart' as firebase_production;

abstract class AppFlavor {
  static const String preview = "preview";
  static const String production = "production";
}

abstract class AppConfig {
  /// Environment the app runs in.
  ///
  /// Defined by the `app.flavor` environment variable.
  /// Defaults to [AppFlavor.preview].
  static const String flavor =
      String.fromEnvironment("app.flavor", defaultValue: AppFlavor.preview);

  /// Options for the Firebase project the app uses.
  ///
  /// Depends on the effective [AppConfig.flavor] value.
  /// For local development and preview builds (internal QA builds) we are using
  /// the Firebase preview projects, for production builds, the Firebase
  /// production project is used.
  static FirebaseOptions get firebaseOptions {
    switch (flavor) {
      case AppFlavor.preview:
        return firebase_preview.DefaultFirebaseOptions.currentPlatform;
      case AppFlavor.production:
        return firebase_production.DefaultFirebaseOptions.currentPlatform;
    }
    throw UnsupportedError(
        "The environment $flavor has no Firebase options defined");
  }

  /// Defines wether the app should use the locally running Firebase emulators.
  /// Emulators are only available for debug or profile mode builds.
  static const bool useFirebaseEmulators =
      !kReleaseMode && bool.fromEnvironment("app.emulators");
}
