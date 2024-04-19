import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:klimo/components/challenges/dashboard/cubit/user_challenge_list_cubit.dart';
import 'package:klimo/components/challenges/list/cubit/add_challenge_cubit.dart';
import 'package:klimo/components/community/cubit/user_community_cubit.dart';
import 'package:klimo/components/user/cubit/user_cubit.dart';
import 'package:klimo/utils/theme.dart';
import 'package:klimo_datamodels/challenges.dart';
import 'package:provider/provider.dart';

class StartChallengeButton extends StatelessWidget {
  final Brightness brightness;
  final DocumentSnapshot<Challenge> challenge;
  final Color? buttonBackgroundColor;

  const StartChallengeButton({
    Key? key,
    this.brightness = Brightness.light,
    required this.challenge,
    this.buttonBackgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProxyProvider0<AddChallengeCubit>(
      update: (context, previous) => AddChallengeCubit(
          challenge,
          context.read<UserCommunityCubit>(),
          context.read<UserCubit>(),
          context.read<UserChallengeListCubit>()),
      child: BlocBuilder<AddChallengeCubit, AddChallengeState>(
        builder: (context, state) {
          if (state.value == false) {
            return Padding(
              padding: const EdgeInsets.all(0.0),
              child: FloatingActionButton.small(
                heroTag: Random().nextInt(100000).toString(),
                backgroundColor: buttonBackgroundColor ??
                    (brightness == Brightness.light
                        ? Palette.primary
                        : Palette.white),
                onPressed: () {
                  context.read<AddChallengeCubit>().addChallenge();
                },
                child: Icon(
                  Icons.add,
                  color: brightness == Brightness.light
                      ? Palette.white
                      : Palette.primary,
                ),
              ),
            );
          }

          if (state.value == true) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(
                FontAwesomeIcons.check,
                color: brightness == Brightness.dark
                    ? Palette.white
                    : Palette.primary,
              ),
            );
          }
          return const Padding(
            padding: EdgeInsets.all(4.0),
            child: Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}
