import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klimo/common/buttons/elevated_button.dart';
import 'package:klimo/common/dialogs/confirmation_dialog.dart';
import 'package:klimo/common/dialogs/error_snackbar.dart';
import 'package:klimo/components/calculator/cubit/calculator_cubit.dart';
import 'package:klimo/components/calculator/update_cubit/calculator_update_cubit.dart';
import 'package:klimo/components/onboarding/cubit/onboarding_cubit.dart';
import 'package:klimo/components/onboarding/onboarding_layout.dart';
import 'package:klimo/config/analytics.dart';
import 'package:klimo/config/firebase.dart';
import 'package:klimo/utils/localisation.dart';
import 'package:klimo/utils/theme.dart';

import '../../../navigation/routes.dart';

class FootprintPage extends StatefulWidget {
  const FootprintPage({Key? key}) : super(key: key);

  @override
  State<FootprintPage> createState() => _FootprintPageState();
}

class _FootprintPageState extends State<FootprintPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CalculatorUpdateCubit, CalculatorUpdateState>(
      bloc: context.read<CalculatorCubit>().updateCubit,
      listener: (BuildContext context, CalculatorUpdateState state) {
        if (state is CalculatorUpdateLoaded) {
          context.read<OnboardingCubit>().check();
        }
        if (state is CalculatorUpdateError) {
          context.showErrorMessage(context.localisation().action_error);
        }
      },
      builder: (BuildContext context, CalculatorUpdateState state) {
        return OnboardingLayout(
          headerAction: TextButton(
            onPressed: () {
              showDialog<void>(
                context: context,
                builder: (BuildContext dialogContext) {
                  return ConfirmationDialog(
                    title:
                        context.localisation().footprint_onboarding_skip_title,
                    content: context
                        .localisation()
                        .footprint_onboarding_skip_message,
                    onConfirm: () async {
                      Navigator.of(dialogContext).pop();
                      // TODO perform action!
                      await context.read<CalculatorCubit>().updateUserValues();

                      // analytics
                      analytics.logOnboardingAction(
                          action: AnalyticsValues.skipFootprintOnboarding);
                    },
                  );
                },
              );
            },
            child: Text(
              context.localisation().action_skip,
            ),
          ),
          primaryButton: ElevatedButton(
            child: Text(context.localisation().footprint_onboarding_start),
            onPressed: () {
              context.read<OnboardingCubit>().startFootprintCalculation();

              // analytics
              analytics.logOnboardingAction(
                  action: AnalyticsValues.doFootprintOnboarding);
            },
          ).expanded(),
          secondaryButton: TextButton(
            child: Text(context
                .localisation()
                .footprint_onboarding_detailed_calculation),
            onPressed: () async {
              await context.read<CalculatorCubit>().updateUserValues();
              if (!mounted) return;
              Router.of(context)
                  .routerDelegate
                  .setNewRoutePath(CalculatorRoute());

              // analytics
              analytics.logOnboardingAction(
                  action: AnalyticsValues.chooseDetailedFootprintCalculation);
            },
          ),
          progress: 6 / 7,
          decoration: state is CalculatorUpdateLoading
              ? OnboardingLayoutDecoration.loading
              : state is CalculatorUpdateLoaded
                  ? OnboardingLayoutDecoration.success
                  : null,
          title: context.localisation().footprint_onboarding_start_title,
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: context.localisation().footprint_onboarding_start_message_1,
              style: context.textTheme().bodyMedium,
              children: [
                TextSpan(
                  text: context
                      .localisation()
                      .footprint_onboarding_start_message_2,
                  style: context.textTheme().bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                TextSpan(
                    text: context
                        .localisation()
                        .footprint_onboarding_start_message_3)
              ],
            ),
          ),
        );
      },
    );
  }
}
