import 'package:url_launcher/url_launcher.dart';

Future<void> openUrl(String url, {bool isOpenedInApp = true}) async {
  final Uri toLaunch = Uri.parse(url);
  await canLaunchUrl(toLaunch)
      ? await launchUrl(
          toLaunch,
          mode: isOpenedInApp
              ? LaunchMode.inAppWebView
              : LaunchMode.externalApplication,
        )
      : throw 'Could not launch $url}';
}
