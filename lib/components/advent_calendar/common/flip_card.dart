import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klimo/components/advent_calendar/cubit/advent_calendar_cubit.dart';

class FlipCard extends StatefulWidget {
  final String cardId;
  final Widget front;
  final Widget back;

  const FlipCard({
    Key? key,
    required this.cardId,
    required this.front,
    required this.back,
  }) : super(key: key);

  @override
  State<FlipCard> createState() => FlipCardState();
}

class FlipCardState extends State<FlipCard> with TickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        duration: const Duration(milliseconds: 800), vsync: this);
  }

  Future flipCard() async {
    await _animationController.forward();
    if (mounted) {
      context.read<AdventCalendarCubit>().openCalendarCard(widget.cardId);
    }
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        final double angle = _animationController.value * -pi;
        final transform = Matrix4.identity()
          ..rotateY(angle)
          ..setEntry(3, 2, 0.001);
        return GestureDetector(
          onTap: () => flipCard(),
          child: Transform(
            transform: transform,
            alignment: Alignment.center,
            child: isFrontImage(angle.abs())
                ? widget.front
                : Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()..rotateY(pi),
                    child: widget.back,
                  ),
          ),
        );
      });

  // Front Image: from 0 till 90 degrees and 270 till 360 degrees
  // Back Image: from 90 till 270 degrees

  bool isFrontImage(double angle) {
    const degrees90 = pi / 2;
    const degrees270 = 3 * pi / 2;
    return angle <= degrees90 || angle >= degrees270;
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }
}
