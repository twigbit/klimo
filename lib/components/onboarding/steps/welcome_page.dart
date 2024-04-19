import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klimo/common/buttons/elevated_button.dart';
import 'package:klimo/common/layout/klimo_bottom_sheet.dart';
import 'package:klimo/common/layout/woods_background.dart';
import 'package:klimo/utils/launch_url.dart';
import 'package:klimo/components/auth/cubit/auth_cubit.dart';
import 'package:klimo/components/auth/cubit/sign_in_cubit.dart';
import 'package:klimo/components/auth/sign_in_fragment.dart';
import 'package:klimo/components/onboarding/cubit/onboarding_cubit.dart';
import 'package:klimo/config/constants.dart';
import 'package:klimo/config/firebase.dart';
import 'package:klimo/utils/localisation.dart';
import 'package:klimo/utils/theme.dart';
import 'package:klimo/config/analytics.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //placeholder for the positioned image, but check how to solve this without empty sized box later!!
                  SizedBox(
                    height: screenHeight * 0.2,
                  ),
                  Expanded(
                    child: Center(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "${context.localisation().welcome_title} 👋",
                              textAlign: TextAlign.center,
                              style: context.textTheme().displayLarge,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  text:
                                      context.localisation().welcome_tutorial_1,
                                  style: context
                                      .textTheme()
                                      .bodyLarge!
                                      .copyWith(color: Palette.grey),
                                  children: [
                                    TextSpan(
                                      text: context
                                          .localisation()
                                          .welcome_tutorial_2,
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          context
                                              .read<OnboardingCubit>()
                                              .showTutorial();
                                        },
                                      style: const TextStyle(
                                          color: Palette.primary),
                                    ),
                                    TextSpan(
                                      text: context
                                          .localisation()
                                          .welcome_tutorial_3,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      children: [
                        ElevatedButton(
                            child: Text(
                                context.localisation().welcome_button_start),
                            onPressed: () {
                              context.read<OnboardingCubit>().next();
                            }).expanded(),
                        Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: Text(
                              context.localisation().welcome_already_signed_in),
                        ),
                        TextButton(
                          onPressed: () {
                            showKlimoModalBottomSheet(
                              context: context,
                              builder: (ctx) => KlimoBottomSheet(
                                header: const KlimoBottomSheetHeader(),
                                body: BlocProvider(
                                  create: (context) =>
                                      SignInCubit(context.read<AuthCubit>()),
                                  child: SingInFragment(
                                    title: context.localisation().sign_in_title,
                                    isOnWelcomePage: true,
                                  ),
                                ),
                              ),
                            );
                          },
                          child: Text(context.localisation().action_sign_in),
                        ),
                        // if (auth.currentUser != null) // TODO remove for production
                        //   TextButton(onPressed: () => auth.signOut(), child: const Text('Abmelden'))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: screenHeight * 0.36,
            child: const ClipRRect(
              borderRadius:
                  BorderRadius.only(bottomRight: Radius.circular(200)),
              child: WoodsBackground(),
            ),
          ),
          Positioned(
            top: screenHeight * 0.08,
            right: 20,
            left: 20,
            //check why klimo card is not working
            child: InkWell(
                onTap: () {
                  openUrl(mailLink);
                  // analytics
                  analytics.logOnboardingAction(
                      action: AnalyticsValues.useEmailContact);
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                            8.0,
                            8.0,
                            24.0,
                            8.0,
                          ),
                          child: SizedBox(
                            height: 40,
                            child: Image.asset("assets/icons/mail_icon.png"),
                          ),
                        ),
                        Flexible(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(context.localisation().welcome_contact),
                                Text(
                                    context
                                        .localisation()
                                        .welcome_contact_message,
                                    style: context
                                        .textTheme()
                                        .headlineMedium
                                        ?.copyWith(color: Palette.primary)),
                              ]),
                        )
                      ],
                    ),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
