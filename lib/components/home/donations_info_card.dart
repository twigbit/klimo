import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klimo/components/auth/cubit/auth_cubit.dart';
import 'package:klimo/components/content/projects/cubit/offset_cubit.dart';
import 'package:klimo/components/home/widgets/horizontal_image_info_card.dart';
import 'package:collection/collection.dart';
import 'package:klimo/navigation/bottom_navigation/cubit/bottom_navigation_cubit.dart';
import 'package:klimo/utils/localisation.dart';

class DonationsInfoCard extends StatelessWidget {
  const DonationsInfoCard({Key? key}) : super(key: key);

  // TODO check values and units for stored emissionSavings
  // TODO check if it's fine with description text and place on info card & if any conversiosn are needed

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OffsetCubit(context.read<AuthCubit>()),
      child: BlocBuilder<OffsetCubit, OffsetState>(
        builder: (context, state) {
          if (state == null) return Container();
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            List<num> emissionSavings = state.value
                    ?.map((e) => e.data().emissionSavings ?? 0)
                    .toList() ??
                [];
            return HorizontalImageInfoCard(
              value: (emissionSavings.sum).toStringAsFixed(2),
              message: context.localisation().projects_donations_info,
              onSelect: () =>
                  context.read<BottomNavigationCubit>().navigateToPage(2),
            );
          }
        },
      ),
    );
  }
}
