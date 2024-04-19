import 'package:flutter/material.dart';
import 'package:klimo/utils/loading.dart';

class Leaderboard<T> extends StatelessWidget {
  const Leaderboard({
    Key? key,
    required this.loadItems,
    required this.buildItem,
    required this.buildEmptyState,
  }) : super(key: key);

  final Loadable<List<T>?>? Function(BuildContext) loadItems;
  final Widget Function(BuildContext, T) buildItem;
  final Widget Function(BuildContext) buildEmptyState;

  @override
  Widget build(BuildContext context) {
    final items = loadItems(context);

    if (items?.isLoading ?? true) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    final itemList = items?.asLoaded?.value;

    if (itemList?.isEmpty ?? true) {
      return buildEmptyState(context);
    }

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 60.0),
      shrinkWrap: true,
      itemCount: itemList!.length,
      itemBuilder: (context, index) {
        T item = itemList[index];
        return buildItem(context, item);
      },
    );
  }
}
