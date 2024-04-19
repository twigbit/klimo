import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klimo/common/dialogs/error_snackbar.dart';
import 'package:klimo/common/layout/woods_background.dart';
import 'package:klimo/components/calculator/cubit/calculator_cubit.dart';
import 'package:klimo/components/calculator/inputs/calculator_input.dart';
import 'package:klimo/components/calculator/update_cubit/calculator_update_cubit.dart';
import 'package:klimo/components/home/widgets/measurement.dart';
import 'package:klimo/config/labels.dart';
import 'package:klimo/utils/localisation.dart';
import 'package:klimo/utils/theme.dart';
import 'package:klimo_datamodels/input_model.dart';

import '../../calculator/calculator_estimator_layout.dart';
import '../cubit/onboarding_cubit.dart';

class FootprintEstimationPage extends StatefulWidget {
  const FootprintEstimationPage({Key? key}) : super(key: key);

  @override
  FootprintEstimationPageState createState() => FootprintEstimationPageState();
}

class FootprintEstimationPageState extends State<FootprintEstimationPage> {
  final PageController _pageController = PageController();
  final int transitionDuration = 500;
  final Curve curveEffect = Curves.easeInOutSine;

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final List<Input> inputData = context.select((CalculatorCubit c) {
      var s = c.state;
      if (s is CalculatorReady) {
        return [
          s.inputModel.resolvePath("living.people_in_household")!,
          s.inputModel.resolvePath("living.living_area")!,
          s.inputModel.resolvePath("living.housing")!,
          s.inputModel.resolvePath("living.energy_source")!,
          s.inputModel.resolvePath("living.power_consumption_source")!,
          s.inputModel.resolvePath("mobility.means_of_transport")!,
          s.inputModel.resolvePath("nutrition.nutrition_question")!,
          s.inputModel.resolvePath("consumption.monthly_expenses")!,
        ];
      } else {
        return [];
      }
    });

    final List<String> inputDataSectionsKeys = [
      "living",
      "living",
      "living",
      "living",
      "living",
      "mobility",
      "nutrition",
      "consumption",
    ];

    // flag to indicate initializing the CalculatorCubit and loading the inputs completed
    final isReady = inputData.isNotEmpty;
    int pagesNumber = inputData.length + 1;
    double bottom = MediaQuery.of(context).viewInsets.bottom;
    bool isKeyboardClosed = bottom == 0.0;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: screenHeight),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                      height: screenHeight * 0.34,
                      child: const ClipRRect(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(300)),
                          child: WoodsBackground())),
                  Expanded(
                    flex: 3,
                    child: isReady
                        ? BlocProvider.value(
                            value:
                                context.read<CalculatorCubit>().rootValueScope,
                            child: PageView.builder(
                              itemCount: pagesNumber,
                              controller: _pageController,
                              physics: const NeverScrollableScrollPhysics(),
                              onPageChanged: (index) {
                                setState(() {
                                  currentPage = index;
                                });
                              },
                              itemBuilder: (context, index) {
                                if (index == pagesNumber - 1) {
                                  return CalculatorEstimatorLayout(
                                    content: Column(
                                      children: [
                                        Text(
                                          context
                                              .localisation()
                                              .footprint_onboarding_result_title,
                                          style:
                                              context.textTheme().displayLarge,
                                          textAlign: TextAlign.center,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: Text(
                                            context
                                                .localisation()
                                                .footprint_onboarding_result_message,
                                            style:
                                                context.textTheme().bodyMedium,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        BlocSelector<CalculatorCubit,
                                            CalculatorState, double>(
                                          selector: (state) =>
                                              state is CalculatorReady
                                                  ? state.calculationResults
                                                      .totalResult
                                                  : .0,
                                          builder: (context, totalResult) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 48.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 8.0),
                                                    child: Measurement(
                                                      iconPath:
                                                          'assets/icons/co2.svg',
                                                      value: totalResult
                                                          .toStringAsFixed(2),
                                                      color: Palette.red,
                                                    ),
                                                  ),
                                                  Text(
                                                    context
                                                        .localisation()
                                                        .footprint_unit,
                                                    style: context
                                                        .textTheme()
                                                        .bodyMedium,
                                                  )
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                } else {
                                  return CalculatorEstimatorLayout(
                                    section: inputDataSectionsKeys[index],
                                    sectionIcon: getSectionIcon(
                                        inputDataSectionsKeys[index]),
                                    content: inputData.isNotEmpty
                                        ? CalculatorInput(
                                            input: inputData[index],
                                            ignoreCondition: true,
                                            isContextOnboarding: true,
                                          )
                                        : Container(),
                                    isKeyboardOpen: !isKeyboardClosed,
                                  );
                                }
                              },
                            ),
                          )
                        : Container(),
                  ),
                  Expanded(
                    flex: isKeyboardClosed ? 1 : 3,
                    child: isReady
                        ? buildActionButtons(pagesNumber: pagesNumber)
                        : Container(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildActionButtons({required int pagesNumber}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 24.0),
          child: currentPage >= 0 && currentPage < pagesNumber - 1
              ? DotsIndicator(
                  dotsCount: pagesNumber - 1,
                  position: (currentPage).toDouble(),
                  decorator: const DotsDecorator(
                    color: Palette.greySecondary,
                    activeColor: Palette.primary,
                    activeSize: Size.square(11.0),
                  ),
                )
              : Container(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (currentPage != 0)
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Ink(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Palette.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: InkWell(
                        child: const Icon(
                          Icons.arrow_back,
                          color: Palette.primary,
                        ),
                        onTap: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          goBack(pagesNumber);
                        },
                      ),
                    ),
                  ),
                ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: currentPage == pagesNumber - 1
                      ? BlocConsumer<CalculatorUpdateCubit,
                          CalculatorUpdateState>(
                          listener: (BuildContext context,
                              CalculatorUpdateState state) {
                            if (state is CalculatorUpdateLoaded) {
                              context.read<OnboardingCubit>().check();
                            }
                            if (state is CalculatorUpdateError) {
                              context.showErrorMessage(
                                  context.localisation().action_error);
                            }
                          },
                          bloc: context.read<CalculatorCubit>().updateCubit,
                          builder: (context, updateState) {
                            if (updateState is CalculatorUpdateLoading ||
                                updateState is CalculatorUpdateError) {
                              return const CircularProgressIndicator();
                            } else {
                              return ElevatedButton.icon(
                                onPressed: () {
                                  // context
                                  //     .read<OnboardingCubit>()
                                  //     .markOnboardingDone();
                                  context
                                      .read<CalculatorCubit>()
                                      .updateUserValues();
                                },
                                style: ElevatedButton.styleFrom(
                                    alignment: Alignment.centerRight),
                                icon: Text(context.localisation().action_save),
                                label: const Icon(Icons.arrow_forward),
                              );
                            }
                          },
                        )
                      : ElevatedButton.icon(
                          onPressed: () {
                            nextPage(pagesNumber);
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                          style: ElevatedButton.styleFrom(
                              alignment: Alignment.centerRight),
                          icon: Text(context.localisation().action_next),
                          label: const Icon(Icons.arrow_forward),
                        ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void goBack(int pagesNumber) {
    setState(() {
      _pageController.previousPage(
          duration: Duration(milliseconds: transitionDuration),
          curve: curveEffect);
    });
  }

  void nextPage(int pagesNumber) {
    setState(() {
      if (!(_pageController.page!.round() + 1 == pagesNumber)) {
        _pageController.nextPage(
            duration: Duration(milliseconds: transitionDuration),
            curve: curveEffect);
      }
    });
  }
}
