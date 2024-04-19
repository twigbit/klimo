import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klimo/common/dialogs/confirmation_dialog.dart';
import 'package:klimo/components/auth/cubit/auth_cubit.dart';
import 'package:klimo/components/auth/cubit/sign_in_cubit.dart';
import 'package:klimo/utils/localisation.dart';

import '../../auth/sign_in_fragment.dart';
import '../onboarding_layout.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInCubit(context.read<AuthCubit>()),
      child: BlocBuilder<SignInCubit, SignInState>(
        builder: (context, state) {
          return OnboardingLayout(
            headerAction: state is! SignInAwaitEmailConfirmation
                ? TextButton(
                    onPressed: () {
                      showDialog<void>(
                        context: context,
                        builder: (BuildContext dialogContext) {
                          return ConfirmationDialog(
                            title: context.localisation().sign_in_skip_title,
                            content:
                                context.localisation().sign_in_skip_message,
                            onConfirm: () {
                              Navigator.of(dialogContext).pop();
                              context.read<SignInCubit>().signInAnonymously();
                            },
                          );
                        },
                      );
                    },
                    child: Text(context.localisation().action_skip))
                : TextButton(
                    onPressed: () => context.read<SignInCubit>().reset(),
                    child: Text(context.localisation().action_back)),
            decoration: state is SignInSuccess
                ? OnboardingLayoutDecoration.success
                : state is SignInLoading
                    ? OnboardingLayoutDecoration.loading
                    : null,
            primaryButton: state is SignInAwaitEmailConfirmation ||
                    (state is SignInLoading && state.isEmailAuth)
                ? const MailReceivedButtons()
                : null,
            progress: 1 / 7,
            title: (state is SignInAwaitEmailConfirmation ||
                    (state is SignInLoading && state.isEmailAuth))
                ? null
                : context.localisation().sign_in_title,
            child: const SingInFragment(),
          );
        },
      ),
    );
  }
}
