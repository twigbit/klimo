import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klimo/common/buttons/elevated_button.dart';
import 'package:klimo/common/layout/woods_background.dart';
import 'package:klimo/utils/localisation.dart';
import 'package:klimo/utils/theme.dart';
import '../cubit/onboarding_cubit.dart';

final List<String> tutorialScreens = [
  "assets/images/tutorial_1.png",
  "assets/images/tutorial_2.png",
  "assets/images/tutorial_3.png",
  "assets/images/tutorial_4.png",
  "assets/images/tutorial_5.png",
  "assets/images/tutorial_6.png",
];

class TutorialPage extends StatefulWidget {
  final bool isOpenedExplicitly;
  const TutorialPage({Key? key, this.isOpenedExplicitly = false})
      : super(key: key);

  @override
  State<TutorialPage> createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
  double _currentPosition = 0.0;
  final int _pagesNumber = tutorialScreens.length;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const WoodsBackground(),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    onPageChanged: (int index) {
                      setState(() {
                        _currentPosition = index.toDouble();
                      });
                    },
                    itemCount: tutorialScreens.length,
                    itemBuilder: (context, index) {
                      return _buildPage(tutorialScreens[index]);
                    },
                  ),
                ),
                if (_currentPosition >= 0)
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 16.0,
                      bottom: 8.0,
                    ),
                    child: DotsIndicator(
                      dotsCount: _pagesNumber,
                      position: _currentPosition,
                      decorator: const DotsDecorator(
                        color: Palette.greySecondary,
                        activeColor: Palette.primary,
                        activeSize: Size.square(11.0),
                      ),
                    ),
                  ),
                _currentPosition >= 0 &&
                        _currentPosition < _pagesNumber - 1.0 &&
                        !widget.isOpenedExplicitly
                    ? TextButton(
                        child: Text(context.localisation().action_skip),
                        onPressed: () {
                          context.read<OnboardingCubit>().next();
                        },
                      )
                    : ElevatedButton(
                        onPressed: () {
                          widget.isOpenedExplicitly
                              ? Navigator.pop(context)
                              : context.read<OnboardingCubit>().next();
                        },
                        child: Text(
                          context.localisation().action_ok,
                        ),
                      ).expanded(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _buildPage(String imagePath) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(48.0),
        ),
      ),
      child: Center(
        child: ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(16.0),
          ),
          child: Image.asset(
            imagePath,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
