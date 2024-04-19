import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klimo/common/cubit/document_query_cubit.dart';
import 'package:klimo/components/notification/notification_button.dart';
import 'package:klimo/config/firebase.dart';
import 'package:klimo/utils/localisation.dart';
import 'package:klimo/utils/theme.dart';
import 'package:klimo_datamodels/rewards.dart';

import "package:collection/collection.dart";
import 'package:http/http.dart' as http;

import '../../config/constants.dart';
import '../../utils/loading.dart';
import '../user/cubit/user_cubit.dart';

class RewardsDashboard extends StatefulWidget {
  const RewardsDashboard({Key? key}) : super(key: key);

  @override
  State<RewardsDashboard> createState() => _RewardsDashboardState();
}

class _RewardsDashboardState extends State<RewardsDashboard> {
  final transformationController = TransformationController();

  @override
  void initState() {
    const zoomFactor = 1.0;
    transformationController.value = Matrix4.identity();
    transformationController.value
        .multiply(Matrix4.identity()..scale(zoomFactor));
    // transformationController.value
    //     .multiply(Matrix4.identity()..translate(200, 300));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const Size imageSize = Size(1431, 1501);
    final num screenWidth = MediaQuery.of(context).size.width;
    final num scale = screenWidth / imageSize.width;

    // transformationController.value
    //     .multiply(Matrix4.identity()..translate(screenWidth / 2, 0.0));

    return BlocProvider(
      create: (context) => DocumentQueryCubit<UserRewardModel>(
          fb
              .userCollection()
              .doc(FirebaseAuth.instance.currentUser?.uid)
              .collection('rewards')
              .typed<UserRewardModel>(),
          listen: true)
        ..load(),
      child: BlocBuilder<DocumentQueryCubit<UserRewardModel>,
          DocumentQueryState<UserRewardModel>>(
        builder: (context, state) {
          return Container(
            color: const Color(0xFFf9efcf),
            child: Stack(
              children: [
                Center(
                  child: InteractiveViewer(
                    clipBehavior: Clip.none,
                    transformationController: transformationController,
                    maxScale: 5,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        const RewardsDashboardBackground(),
                        if (state != null && state is Loaded)
                          ...state.value!.docs.distinct().map((e) {
                            final reward = e.data().reward;
                            return Positioned(
                              bottom: (1500 - reward.y - (reward.height / 2)) *
                                  scale.toDouble(),
                              left: (reward.x - (reward.width / 2)) *
                                  scale.toDouble(),
                              child: Image.network(
                                reward.assetUrl,
                                height: reward.height.toDouble() * scale,
                                width: reward.width.toDouble() * scale,
                              ),
                            );
                          })
                        else
                          const Center(
                            child: CircularProgressIndicator(),
                          ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                                context
                                    .localisation()
                                    .rewards_dashboard_headline,
                                style: context.textTheme().headlineLarge),
                          ),
                          const NotificationButton(),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                    bottom: 8,
                    left: 8,
                    right: 8,
                    child: Text(
                      context.localisation().rewards_dashboard_hint,
                      style: context.textTheme().labelMedium?.copyWith(
                            color: Colors.black38,
                          ),
                      textAlign: TextAlign.center,
                    )),
                // secret loose rewards handle
                Positioned(
                  left: 0,
                  bottom: 0,
                  child: InkWell(
                    onLongPress: () async {
                      var docs = await FirebaseFirestore.instance
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .collection('rewards')
                          .get();
                      for (var doc in docs.docs) {
                        await doc.reference.delete();
                      }
                    },
                    child: const SizedBox(
                      height: 48,
                      width: 48,
                    ),
                  ),
                ),
                // secret get reward handle
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: InkWell(
                    onLongPress: () async {
                      final uri = Uri.parse(httpFunctions.getFunctionUrl(
                          "fetchRewards",
                          {'uid': FirebaseAuth.instance.currentUser!.uid}));
                      await http.get(uri, headers: {
                        HttpHeaders.contentTypeHeader: 'application/json',
                      });
                    },
                    child: const SizedBox(
                      height: 48,
                      width: 48,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

extension Distinct on List<QueryDocumentSnapshot<UserRewardModel>> {
  List<QueryDocumentSnapshot<UserRewardModel>> distinct() {
    return groupBy(
      this,
      (QueryDocumentSnapshot<UserRewardModel> p0) =>
          p0.data().reward.x.toString() + p0.data().reward.y.toString(),
    )
        .values
        .map((e) => (e
              ..sort(
                (a, b) =>
                    (a.data().reward.z ?? 0).toInt() -
                    (b.data().reward.z ?? 0).toInt(),
              ))
            .last)
        .toList();
  }
}

class RewardsDashboardBackground extends StatelessWidget {
  const RewardsDashboardBackground({super.key});

  String _getBackgroundImageFile({required num points}) {
    if (points < 40) {
      // initial background
      return RewardAssetFiles.rewardBackgroundLevel1;
    } else if (points < 60) {
      return RewardAssetFiles.rewardBackgroundLevel2;
    } else {
      // final background
      return RewardAssetFiles.rewardBackgroundLevel3;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, userState) {
        final rewardPoints = userState?.value?.data()?.rewardStats.points;
        final imagePath = _getBackgroundImageFile(points: rewardPoints ?? 0);

        return Image.asset(imagePath);
      },
    );
  }
}
