import 'package:firebase_auth/firebase_auth.dart';
import 'package:klimo/config.dart';

class DynamicLinkOptions {
  static ActionCodeSettings get emailLinkSignInACS {
    switch (AppConfig.flavor) {
      case AppFlavor.preview:
        return previewEmailLinkSignInACS;
      case AppFlavor.production:
        return productionEmailLinkSignInACS;
    }

    throw UnsupportedError(
      'DynamicLinkOptions are not supported for this build flavour.',
    );
  }

  static ActionCodeSettings get productionEmailLinkSignInACS =>
      ActionCodeSettings(
        // Fallback URL in case the user doesn't have the App installed
        // and can't be redirected to the app store / play store.
        url: 'https://www.klimo.app/',
        dynamicLinkDomain: "klimo.page.link",
        // This must be true
        handleCodeInApp: true,
        iOSBundleId: 'app.klimo',
        androidPackageName: 'app.klimo',
        // installIfNotAvailable
        androidInstallApp: true,
        // minimumVersion
        androidMinimumVersion: '12',
      );

  static ActionCodeSettings get previewEmailLinkSignInACS => ActionCodeSettings(
        // Fallback URL in case the user doesn't have the App installed
        // and can't be redirected to the app store / play store.
        url: 'https://www.klimo.app/',
        dynamicLinkDomain: "klimopreview.page.link",
        // This must be true
        handleCodeInApp: true,
        iOSBundleId: 'app.klimo.preview',
        androidPackageName: 'app.klimo.preview',
        // installIfNotAvailable
        androidInstallApp: true,
        // minimumVersion
        androidMinimumVersion: '12',
      );
}

/// maybe these methods will be needed for work with dynamic links
/// (keep it for now but delete it if no longer needed)

//   void initDynamicLinks() async {
//     dynamicLinks.onLink.listen((dynamicLinkData) async {
//       _routerDelegate.setNewRoutePath(
//         await _routeInformationParser.parseRouteInformation(
//           RouteInformation(location: dynamicLinkData.link.path),
//         ),
//       );
//     }).onError((error) {
//       debugPrint('onLink error');
//       debugPrint(error.message);
//     });
//   }

// Future<String> createDynamicLink() async {
//   final DynamicLinkParameters parameters = DynamicLinkParameters(
//     uriPrefix: 'https://klimo.page.link',
//     // TODO check what link to use here
//     link: Uri.parse('https://klimo.page.link'),
//     androidParameters: const AndroidParameters(
//       packageName: 'app.klimo',
//     ),
//     iosParameters: const IOSParameters(
//       bundleId: 'app.klimo',
//       appStoreId: '1583576167',
//     ),
//   );

//   final ShortDynamicLink shortLink =
//       await dynamicLinks.buildShortLink(parameters);
//   final Uri url = shortLink.shortUrl;
//   return url.toString();
// }
