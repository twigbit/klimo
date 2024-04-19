import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:klimo/common/layout/util.dart';
import 'package:klimo/config/constants.dart';
import 'package:klimo/utils/theme.dart';

enum OnboardingLayoutDecoration { loading, success }

class OnboardingLayout extends StatelessWidget {
  final Widget child;
  final Widget? headerAction;
  final Widget? primaryButton;
  final Widget? secondaryButton;
  final double progress;
  final String? title;

  final OnboardingLayoutDecoration? decoration;

  const OnboardingLayout(
      {Key? key,
      required this.child,
      this.headerAction,
      this.primaryButton,
      this.secondaryButton,
      required this.progress,
      this.decoration,
      this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SafeArea(
          child: Stack(
            children: [
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 8.0,
                    right: 16,
                    left: 16,
                  ),
                  child: Column(
                      children: [
                    Hero(
                      tag: 'progressBar',
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SvgPicture.asset(
                                logo,
                                width: 80,
                              ),
                              SizedBox(
                                  height: 44,
                                  child: Center(
                                      child: decoration ==
                                              OnboardingLayoutDecoration.success
                                          ? const Icon(
                                              Icons.check,
                                              color: Palette.primary,
                                            )
                                          : decoration ==
                                                  OnboardingLayoutDecoration
                                                      .loading
                                              ? const SizedBox(
                                                  height: 24,
                                                  width: 24,
                                                  child:
                                                      CircularProgressIndicator(),
                                                )
                                              : headerAction ?? Container()))
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              child: LinearProgressIndicator(
                                backgroundColor: Palette.greySecondaryLight,
                                minHeight: 12,
                                value: progress,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 56),
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 56),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                if (title != null)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Text(
                                      title!,
                                      style: context.textTheme().displayLarge,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 16,
                                    bottom: 48,
                                  ),
                                  child: child,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ).overridePadding(),
                  ].padded(const EdgeInsets.only(bottom: 8))),
                ),
              ),
              Positioned(
                bottom: 16,
                right: 16,
                left: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    decoration != OnboardingLayoutDecoration.success &&
                            decoration != OnboardingLayoutDecoration.loading &&
                            primaryButton != null
                        ? primaryButton!
                        : Container(
                            height: 48,
                          ),
                    secondaryButton ?? Container(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
