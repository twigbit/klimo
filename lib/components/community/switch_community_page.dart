import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klimo/common/buttons/elevated_button.dart';
import 'package:klimo/components/community/community_fragment.dart';
import 'package:klimo/components/community/cubit/join_community_cubit.dart';
import 'package:klimo/utils/localisation.dart';

class SwitchCommunityPage extends StatelessWidget {
  const SwitchCommunityPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text(context.localisation().community_select_title)),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Stack(
          children: [
            const Padding(
              padding: EdgeInsets.only(
                top: 24.0,
                bottom: 8.0,
                right: 8.0,
                left: 8.0,
              ),
              child: SingleChildScrollView(
                child: CommunityFragment(),
              ),
            ),
            BlocBuilder<JoinCommunityCubit, JoinCommunityState>(
              builder: (context, state) {
                return Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 24.0),
                    child: ElevatedButton(
                      onPressed: state is CommunitiesLoaded &&
                              state.selectedCommunityIndex != null
                          ? () {
                              context
                                  .read<JoinCommunityCubit>()
                                  .joinCommunity();
                              Navigator.pop(context);
                            }
                          : null,
                      child: Text(
                        context.localisation().action_save,
                      ),
                    ).expanded(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
