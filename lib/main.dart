import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klimo/config/firebase.dart';
import 'package:klimo/config/firebase_http_functions.dart';
import 'package:klimo/config/firebase_messaging.dart';
import 'package:klimo/navigation/navigation.dart';
import 'package:klimo/repositories/dynamiclink_repository.dart';
import 'package:klimo/utils/theme.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'config.dart';
import 'l10n/app_localizations.dart';
part 'config/theme.dart';

///anything here works when app is in background (regarding notifications)
///for this reason it should be top level / outside the app's scopes
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint(message.data.toString());
  if (message.notification != null) debugPrint(message.notification!.title);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: AppConfig.firebaseOptions);

  if (AppConfig.useFirebaseEmulators) {
    // ignore: avoid_print
    print("Using Firebase Emulators.");
    final app = Firebase.app();
    var host = "localhost";

    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
      // ignore: avoid_print
      print('Mapping Emulator host "$host" to "10.0.2.2".');
      host = "10.0.2.2";
    }

    FirebaseAuth.instanceFor(app: app).useAuthEmulator("localhost", 9099);

    FirebaseFunctions.instanceFor(app: app, region: 'europe-west1')
        .useFunctionsEmulator("localhost", 5001);

    FirebaseHttpFunctions.instanceFor(app: app)
        .useFunctionsEmulator("localhost", 5001);

    FirebaseFirestore.instanceFor(app: app).settings = Settings(
      host: "$host:8080",
      sslEnabled: false,
      persistenceEnabled: false,
    );
  }

  if (!kIsWeb) {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  }

  final dynamicLinkRepository =
      DynamicLinkRepository(await links.getInitialLink());

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  NotificationsServices.initialize();

  runApp(KlimoApp(
    dynamicLinkRepository: dynamicLinkRepository,
  ));
}

class KlimoApp extends StatefulWidget {
  final DynamicLinkRepository dynamicLinkRepository;

  const KlimoApp({
    Key? key,
    required this.dynamicLinkRepository,
  }) : super(key: key);

  @override
  KlimoAppState createState() => KlimoAppState();
}

class KlimoAppState extends State<KlimoApp> {
  final KlimoRouterDelegate _routerDelegate = KlimoRouterDelegate();
  final KlimoRouteInformationParser _routeInformationParser =
      KlimoRouteInformationParser();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Builder(
      builder: (context) {
        return MultiProvider(
          providers: [
            RepositoryProvider.value(value: widget.dynamicLinkRepository),
          ],
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: AppConfig.flavor == AppFlavor.production
                ? 'klimo'
                : 'klimo (Preview)',
            theme: _theme,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            // localizationsDelegates: context.localizationDelegates,
            // supportedLocales: context.supportedLocales,
            // locale: context.locale,
            routerDelegate: _routerDelegate,
            routeInformationParser: _routeInformationParser,
          ),
        );
      },
    );
  }
}
