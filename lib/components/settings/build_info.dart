import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:klimo/common/dialogs/error_snackbar.dart';
import 'package:klimo/config.dart';
import 'package:klimo/config/firebase.dart';
import 'package:klimo/utils/theme.dart';
import 'package:package_info_plus/package_info_plus.dart';

class BuildInfo extends StatelessWidget {
  const BuildInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PackageInfo>(
        future: PackageInfo.fromPlatform(),
        builder: (ctx, snapshot) {
          final versionStr =
              "${snapshot.data?.version}+${snapshot.data?.buildNumber}";
          return GestureDetector(
            onLongPress: () {
              Clipboard.setData(ClipboardData(text: versionStr)).then((_) {
                context.showErrorMessage("Version copied to clipboard");
              });
            },
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
              child: Text(
                "App Version: $versionStr${AppConfig.flavor == AppFlavor.production ? "" : "\nApp Name: ${snapshot.data?.appName}"
                    "\nPackage Name: ${snapshot.data?.packageName}"
                    "\nFlavor: ${AppConfig.flavor}"
                    "\nBackend: ${firebase.options.projectId} ${AppConfig.useFirebaseEmulators ? "(emulator)" : ""}"}",
                style: ctx.textTheme().bodySmall,
              ),
            ),
          );
        });
  }
}
