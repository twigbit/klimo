import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klimo/common/buttons/elevated_button.dart';
import 'package:klimo/components/auth/cubit/auth_cubit.dart';
import 'package:klimo/components/onboarding/cubit/onboarding_cubit.dart';
import 'package:klimo/components/onboarding/onboarding_layout.dart';
import 'package:klimo/config/analytics.dart';
import 'package:klimo/config/firebase.dart';
import 'package:klimo/utils/localisation.dart';
import 'package:klimo/utils/theme.dart';
import 'package:klimo_datamodels/user.dart';

import '../../../common/dialogs/confirmation_dialog.dart';

class DeletionRequestPage extends StatelessWidget {
  const DeletionRequestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OnboardingLayout(
      headerAction: TextButton(
          onPressed: () {
            context.read<AuthCubit>().signOut();
            // TODO implement
          },
          child: Text(context.localisation().sign_out_title)),
      primaryButton: ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (innerContext) => ConfirmationDialog(
              title: context.localisation().revoke_deletion_request_title,
              content: context.localisation().revoke_deletion_request_question,
              onConfirm: () async {
                // TODO implement
                await context
                    .read<OnboardingCubit>()
                    .state
                    .cast<OnboardingStepDeletionRequestPending>()!
                    .deletionRequest
                    .reference
                    .type<DeletionRequestUpdate>()
                    .upset(DeletionRequestUpdate(
                      (b) => b
                        ..status = DeletionRequestStatus.revoked
                        ..revokedAt = FieldValue.serverTimestamp(),
                    ));
                // analytics
                analytics.logOnboardingAction(
                    action: 'revoke_account_deletion_request');
              },
            ),
          );
          // TODO implement
        },
        child: Text(context.localisation().revoke_deletion_request_title),
      ).expanded(),
      progress: 0 / 7,
      title: context.localisation().deletion_request_done_title,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(
              context.localisation().deletion_request_done_message,
              style: context.textTheme().bodyMedium,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
