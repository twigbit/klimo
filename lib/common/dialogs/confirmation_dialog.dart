import 'package:flutter/material.dart';
import 'package:klimo/utils/localisation.dart';

class ConfirmationDialog extends StatelessWidget {
  final Function()? onConfirm;
  final String title;
  final String? content;

  const ConfirmationDialog({
    Key? key,
    this.onConfirm,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: content != null ? Text(content!) : null,
      actions: <Widget>[
        TextButton(
          child: Text(
            context.localisation().action_cancel,
          ),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
        ElevatedButton(
          onPressed: onConfirm ?? () => Navigator.of(context).pop(true),
          child: Text(
            context.localisation().action_confirm,
          ),
        ),
      ],
    );
  }
}
