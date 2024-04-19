import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:klimo/utils/launch_url.dart';
import 'package:klimo/config/constants.dart';
import 'package:klimo/utils/localisation.dart';
import 'package:klimo/utils/theme.dart';

class ConsentFragment extends StatelessWidget {
  const ConsentFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: context.textTheme().bodyMedium,
        children: <TextSpan>[
          TextSpan(text: context.localisation().consent_data_share_message_1),
          TextSpan(
            text: context.localisation().consent_data_share_message_2,
            style: context.textTheme().bodyMedium!.copyWith(
                  color: Palette.primary,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
            recognizer: TapGestureRecognizer()
              ..onTap = () => openUrl(privacyPolicyLink),
          ),
          TextSpan(text: context.localisation().consent_data_share_message_3),
        ],
      ),
    );
  }
}
