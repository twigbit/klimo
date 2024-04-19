import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klimo/common/buttons/elevated_button.dart';
import 'package:klimo/components/analytics_consent/consent_fragment.dart';
import 'package:klimo/components/analytics_consent/cubit/consent_cubit.dart';
import 'package:klimo/components/onboarding/onboarding_layout.dart';
import 'package:klimo/utils/loading.dart';
import 'package:klimo/utils/localisation.dart';
import 'package:klimo_datamodels/consent.dart';

class ConsentPage extends StatelessWidget {
  const ConsentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConsentCubit, Loadable<ConsentModel?>?>(
      builder: (BuildContext context, state) {
        return OnboardingLayout(
            headerAction: TextButton(
                onPressed: () {
                  context
                      .read<ConsentCubit>()
                      .updateConsent(enableAnalytics: false);
                },
                child: Text(context.localisation().consent_data_no_help)),
            primaryButton: ElevatedButton(
              child: Text(context.localisation().action_agree),
              onPressed: () {
                context
                    .read<ConsentCubit>()
                    .updateConsent(enableAnalytics: true);
              },
            ).expanded(),
            progress: 2 / 7,
            decoration: state!.isLoading
                ? OnboardingLayoutDecoration.loading
                : state.isLoaded && state.value != null
                    ? OnboardingLayoutDecoration.success
                    : null,
            title: context.localisation().consent_data_help,
            child: const ConsentFragment());
      },
    );
  }
}
