import 'package:flutter/material.dart';
import 'package:klimo/utils/localisation.dart';

class NotificationDialog extends StatelessWidget {
  final Function? onNotice;
  final String title;
  final String content;

  const NotificationDialog({
    Key? key,
    this.onNotice,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        ElevatedButton(
          child: Text(
            context.localisation().action_ok,
          ),
          onPressed: () {
            if (onNotice != null) onNotice!();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
