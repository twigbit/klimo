// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options_klimo_preview.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB9dy53LgWvIk9urRWb3_bd8OWyEJAmz-Y',
    appId: '1:342366002778:android:e108dc652b41963a16c263',
    messagingSenderId: '342366002778',
    projectId: 'klimo--preview',
    storageBucket: 'klimo--preview.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA9VD26eGExV0vdP6ZF56bXRTlI-ZmWhB8',
    appId: '1:342366002778:ios:594a8c2606a6aa7516c263',
    messagingSenderId: '342366002778',
    projectId: 'klimo--preview',
    storageBucket: 'klimo--preview.appspot.com',
    androidClientId: '342366002778-0ohkddnrmca20baa43c6c19lrqmtd8jc.apps.googleusercontent.com',
    iosClientId: '342366002778-921jrkuf9e55n2dj5bcuqlleq1cbq51f.apps.googleusercontent.com',
    iosBundleId: 'app.klimo.preview',
  );
}