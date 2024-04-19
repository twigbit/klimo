import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:klimo/common/buttons/elevated_button.dart';
import 'package:klimo/common/dialogs/error_snackbar.dart';
import 'package:klimo/common/layout/util.dart';
import 'package:klimo/utils/launch_url.dart';
import 'package:klimo/components/auth/cubit/sign_in_cubit.dart';
import 'package:klimo/components/auth/util.dart';
import 'package:klimo/config/constants.dart';
import 'package:klimo/utils/localisation.dart';
import 'package:klimo/utils/theme.dart';

class SingInFragment extends StatelessWidget {
  final String? title;
  final bool isOnWelcomePage;
  const SingInFragment({
    Key? key,
    this.title,
    this.isOnWelcomePage = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInCubit, SignInState>(
      builder: (context, state) {
        if (state is SignInAwaitEmailConfirmation ||
            (state is SignInLoading && state.isEmailAuth)) {
          return Column(
            children: [
              const MailReceivedView(),
              if (isOnWelcomePage)
                const Padding(
                  padding: EdgeInsets.only(top: 56.0),
                  child: MailReceivedButtons(),
                ),
            ],
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (title != null)
              Text(
                title!,
                textAlign: TextAlign.center,
                style: context.textTheme().displayLarge,
              ),
            Text(
              context.localisation().sign_in_mail,
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                16.0,
                0.0,
                16.0,
                40.0,
              ),
              child: TextField(
                // decoration: InputDecoration(
                //     errorText: state is SignInError ? state.error : null),
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) =>
                    context.read<SignInCubit>().updateEmail(value),
                onSubmitted: (String? value) {},
              ),
            ),
            const PrivacyStatement(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: ElevatedButton(
                onPressed: (state is SignInInitial &&
                        state.email != null &&
                        state.email!.isNotEmpty &&
                        validateEmail(state.email) == null)
                    ? () {
                        context
                            .read<SignInCubit>()
                            .signInWithEmail(context.locale().languageCode);
                      }
                    : null,
                child: Text(context.localisation().sign_in_button),
              ).expanded(),
            ),
            Text(
              context.localisation().sign_in_other_providers,
              style: context.textTheme().bodyMedium,
              textAlign: TextAlign.center,
            ),
            SignInButton(
              Buttons.Google,
              text: context.localisation().sign_in_google,
              onPressed: state is SignInLoading
                  ? () {}
                  : () {
                      context.read<SignInCubit>().signInWithGoogle();
                    },
              padding: const EdgeInsets.only(
                left: 48.0,
                right: 32.0,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24)),
            ).overridePadding(),
            if (!kIsWeb && Platform.isIOS)
              SignInButton(
                Buttons.AppleDark,
                text: context.localisation().sign_in_apple,
                onPressed: state is SignInLoading
                    ? () {}
                    : () {
                        context.read<SignInCubit>().signInWithApple();
                      },
                padding: const EdgeInsets.only(
                  left: 48.0,
                  right: 32.0,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24)),
              ),
          ].padded(const EdgeInsets.only(bottom: 16)),
        );
      },
      listener: (context, state) {
        if (state is SignInError) {
          context.showErrorMessage(context.localisation().action_error);
        }
      },
    );
  }
}

class PrivacyStatement extends StatelessWidget {
  const PrivacyStatement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: context.textTheme().bodyMedium,
        children: <TextSpan>[
          TextSpan(text: context.localisation().auth_terms_agreement_message_1),
          TextSpan(
            text: context.localisation().auth_terms_of_service,
            style: context.textTheme().bodyMedium!.copyWith(
                  color: Palette.primary,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
            recognizer: TapGestureRecognizer()
              ..onTap = () => openUrl(termsOfServiceLink),
          ),
          TextSpan(text: context.localisation().auth_terms_agreement_message_2),
          TextSpan(
              text: context.localisation().auth_privacy_policy,
              style: context.textTheme().bodyMedium!.copyWith(
                    color: Palette.primary,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
              recognizer: TapGestureRecognizer()
                ..onTap = () => openUrl(privacyPolicyLink)),
          TextSpan(text: context.localisation().auth_terms_agreement_message_3),
        ],
      ),
    );
  }
}

class MailReceivedView extends StatelessWidget {
  const MailReceivedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.email_outlined,
          size: 48,
        ),
        Text(
          context.localisation().sign_in_receive_mail,
          textAlign: TextAlign.center,
          style: context.textTheme().displayLarge,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 16.0,
          ),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: context.textTheme().bodyMedium,
              text: context.localisation().sign_in_mail_info_1,
              children: [
                TextSpan(
                    text: context.localisation().sign_in_mail_info_2,
                    style: context
                        .textTheme()
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class MailReceivedButtons extends StatelessWidget {
  const MailReceivedButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            if (Platform.isAndroid) {
              AndroidIntent intent = const AndroidIntent(
                action: 'android.intent.action.MAIN',
                category: 'android.intent.category.APP_EMAIL',
              );
              intent.launch().catchError((e) {});
            } else if (Platform.isIOS) {
              openUrl(
                "message://",
                isOpenedInApp: false,
              );
            }
          },
          child: Text(
            context.localisation().sign_in_open_mail,
          ),
        ).expanded(),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: TextButton(
            onPressed: () => context
                .read<SignInCubit>()
                .signInWithEmail(context.locale().languageCode),
            child: Text(
              context.localisation().sign_in_resend_mail,
            ),
          ),
        ),
      ],
    );
  }
}
