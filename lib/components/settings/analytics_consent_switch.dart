import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klimo/components/analytics_consent/cubit/consent_cubit.dart';
import 'package:klimo/components/user/cubit/user_cubit.dart';
import 'package:klimo/config/analytics.dart';
import 'package:klimo/config/firebase.dart';
import 'package:klimo/utils/theme.dart';
import 'package:klimo/utils/loading.dart';
import 'package:klimo_datamodels/consent.dart';
import 'package:klimo_datamodels/user.dart';

class AnalyticsConsentSwitch extends StatelessWidget {
  const AnalyticsConsentSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConsentCubit, Loadable<ConsentModel?>?>(
      builder: (context, state) {
        if (state == null) return Container();
        if (state.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Switch(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            activeColor: Palette.primary,
            value: state.value!.enableAnalytics!,
            onChanged: (value) {
              context
                  .read<ConsentCubit>()
                  .updateConsent(enableAnalytics: value);

              // analytics
              analytics.logSettingsAction(
                  action: AnalyticsValues.switchConsentSettings);
              if (value) {
                ProfileModel? profile =
                    context.read<UserCubit>().state?.value?.data()?.profile;

                // set test users properties in analytics if already activated to ensure respective data collection
                analytics.setTestUserProperty(
                    isActiveTestUser: profile?.testUser != null);

                if (profile?.testUser != null) {
                  analytics.setFederalStateProperty(
                      federalState: profile?.testUser?.federalState);
                  analytics.setTestUserTokenProperty(
                      token: profile?.testUser?.token);

                  // log register event in case test user is activated
                  analytics.logTestUserRegistration(params: {
                    AnalyticsParameters.token: profile?.testUser?.token,
                    AnalyticsParameters.federalState:
                        profile?.testUser?.federalState,
                  });
                }
              }
            },
          );
        }
      },
    );
  }
}
