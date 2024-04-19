import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:klimo/utils/launch_url.dart';
import 'package:klimo/components/challenges/common/category_icon.dart';
import 'package:klimo/components/challenges/common/challenge_coins_row.dart';
import 'package:klimo/components/challenges/common/challenge_emissions_row.dart';
import 'package:klimo/utils/localisation.dart';
import 'package:klimo/utils/theme.dart';

class SingleChallengeView extends StatelessWidget {
  final String? category;
  final String? title;
  final String? content;
  final String? information;
  final bool isRecurring;
  final num? coins;
  final num? emissionSavings;
  final Widget? checkInComponent;

  const SingleChallengeView({
    Key? key,
    required this.category,
    this.title,
    this.content,
    this.information,
    this.isRecurring = false,
    this.coins,
    this.emissionSavings,
    this.checkInComponent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    CategoryIcon(
                      category: category,
                      isRecurring: isRecurring,
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          category?.tr(context) ??
                              context.localisation().general,
                          style: context
                              .textTheme()
                              .displaySmall
                              ?.copyWith(color: Palette.primary),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (emissionSavings != null)
                      ChallengeEmissionsRow(value: emissionSavings),
                    if (coins != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: ChallengeCoinsRow(value: coins),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (title != null)
          Text(
            title!,
            style: context.textTheme().displayLarge,
          ),
        if (content != null)
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(content!),
          ),
        if (checkInComponent != null) checkInComponent!,
        if (information != null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  context.localisation().challenges_info,
                  style: context.textTheme().displayMedium,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: MarkdownBody(
                  styleSheet:
                      MarkdownStyleSheet.fromTheme(context.theme()).copyWith(
                    a: TextStyle(
                      color: context.colorScheme().primary,
                      decoration: TextDecoration.underline,
                    ),
                    p: context.textTheme().bodyMedium,
                    h1: context.textTheme().headlineLarge,
                    h2: context.textTheme().headlineMedium,
                    h3: context.textTheme().headlineSmall,
                  ),
                  data: information!,
                  onTapLink: (_, href, __) {
                    if (href != null) openUrl(href);
                  },
                ),
              ),
            ],
          ),
      ],
    );
  }
}

   // this is commented out for now since participants loading is not working yet & actually not needed for v1
        //   BlocProvider(
        // create: (context) =>
        //     ChallengeUserCubit(challenge.id)..loadChallengeUsers(),
        // child: BlocBuilder<ChallengeUserCubit, ChallengeUserState>(
        //   builder: (BuildContext context, ChallengeUserState state) {
        //     if (state is ChallengeUsersLoaded) {
        //       return Column(
        //         children: [
        //           Padding(
        //             padding: const EdgeInsets.only(top: 8.0),
        //             child: Row(
        //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //               children: [
        //                 Text(
        //                   tr('challenges_participants'),
        //                   style: context.textTheme().displayMedium,
        //                 ),
        //                 Text(
        //                   state.users.length.toString(),
        //                   style: context.textTheme().displayMedium,
        //                 ),
        //               ],
        //             ),
        //           ),
        //           GridView.count(
        //             shrinkWrap: true,
        //             crossAxisCount: 5,
        //             children: state.users
        //                 .where(
        //                     (user) => user.data?.profile.imageUrl != null)
        //                 .map(
        //                   (user) => Padding(
        //                     padding: const EdgeInsets.all(4.0),
        //                     child: CircleAvatar(
        //                       backgroundColor: Palette.greenBackground,
        //                       backgroundImage:
        //                           user.data?.profile.imageUrl != null
        //                               ? CachedNetworkImageProvider(
        //                                   user.data!.profile.imageUrl!)
        //                               : null,
        //                       child: user.data?.profile.imageUrl == null
        //                           ? const Icon(
        //                               Icons.person,
        //                               color: Palette.black,
        //                             )
        //                           : null,
        //                     ),
        //                   ),

        //                 ],
        //               );
        //             } else {
        //               return const CircularProgressIndicator();
        //             }
        //           },
        //         ),
        //       ),
        //     ],
        //   ),
        // );
        // } else {
        //   return const Center(
        //     child: CircularProgressIndicator(),
        //   );
        // }
        // },
