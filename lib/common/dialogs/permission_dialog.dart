import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:klimo/utils/localisation.dart';

class PermissionDialog extends StatelessWidget {
  final String message;

  const PermissionDialog({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(context.localisation().permissions_missing_title),
      content: Text(message),
      actions: [
        TextButton(
          child: Text(context.localisation().permissions_missing_dismiss),
          onPressed: () => Navigator.pop(context),
        ),
        ElevatedButton(
          onPressed: AppSettings.openAppSettings,
          child: Text(context.localisation().permissions_missing_settings),
        ),
      ],
    );
  }
}
