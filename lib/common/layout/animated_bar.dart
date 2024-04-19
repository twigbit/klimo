import 'package:flutter/material.dart';

class AnimatedBar extends StatelessWidget {
  final AnimationController animController;
  final int position;
  final int currentIndex;
  final Brightness brightness;

  const AnimatedBar({
    Key? key,
    required this.animController,
    required this.position,
    required this.currentIndex,
    this.brightness = Brightness.light,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color activeColor = (brightness == Brightness.light
        ? Colors.white.withOpacity(0.9)
        : Colors.black.withOpacity(0.7));
    final Color inactiveColor = (brightness == Brightness.light
        ? Colors.white.withOpacity(0.5)
        : Colors.black.withOpacity(0.5));

    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: <Widget>[
                _buildContainer(
                  double.infinity,
                  position < currentIndex ? activeColor : inactiveColor,
                ),
                position == currentIndex
                    ? AnimatedBuilder(
                        animation: animController,
                        builder: (context, child) {
                          return _buildContainer(
                            constraints.maxWidth * animController.value,
                            activeColor,
                          );
                        },
                      )
                    : const SizedBox.shrink(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildContainer(double width, Color color) {
    return Material(
      color: Colors.transparent,
      elevation: 2,
      child: Container(
        height: 5.0,
        width: width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    );
  }
}
