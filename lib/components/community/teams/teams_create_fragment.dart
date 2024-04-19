import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klimo/common/buttons/elevated_button.dart';
import 'package:klimo/common/layout/util.dart';
import 'package:klimo/components/community/teams/cubit/join_or_create_team_cubit.dart';
import 'package:klimo/utils/localisation.dart';

class TeamsCreateFragment extends StatefulWidget {
  const TeamsCreateFragment({Key? key}) : super(key: key);

  @override
  State<TeamsCreateFragment> createState() => _TeamsCreateFragmentState();
}

class _TeamsCreateFragmentState extends State<TeamsCreateFragment> {
  String teamName = "";
  String teamInfo = "";
  String teamPW = "";

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Text(
              context.localisation().community_teams_create_info,
              textAlign: TextAlign.center,
            ),
            TextFormField(
              onChanged: (value) {
                setState(() {
                  teamName = value;
                });
              },
              decoration: InputDecoration(
                labelText: context.localisation().team_create_name,
              ),
            ),
            TextFormField(
              onChanged: (value) {
                setState(() {
                  teamInfo = value;
                });
              },
              decoration: InputDecoration(
                labelText: context.localisation().team_create_info,
              ),
              minLines: 2,
              maxLines: 4,
            ),
            // TODO add password parameter for private teams creation / joining feature
            // TextFormField(
            //   onChanged: (value) {
            //     setState(() {
            //       teamPW = value;
            //     });
            //   },
            //   decoration: const InputDecoration(
            //     labelText: 'Passwort',
            //   ),
            // ),
            ElevatedButton(
              onPressed: teamName.isEmpty
                  ? null
                  : () async {
                      context.read<JoinOrCreateTeamCubit>().createTeam(
                            name: teamName,
                            info: teamInfo,
                            password: teamPW,
                          );
                      Navigator.pop(context);
                    },
              child: Text(context.localisation().action_save),
            ).expanded(),
          ].padded(const EdgeInsets.only(bottom: 24.0)),
        ),
      ],
    );
  }
}
