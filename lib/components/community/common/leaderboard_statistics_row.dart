import 'package:flutter/material.dart';
import 'package:klimo/utils/strings.dart';
import 'package:klimo/utils/theme.dart';

class LeaderbordStasticsRow extends StatelessWidget {
  final num? countValue;
  final num? coinsValue;
  final num? emissionsValue;

  const LeaderbordStasticsRow({
    Key? key,
    this.countValue,
    this.coinsValue,
    this.emissionsValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // TODO take care of units still
        if (emissionsValue != null)
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  ((emissionsValue ?? 0) / 52).toStringAsFixed(1),
                  style: context
                      .textTheme()
                      .headlineMedium
                      ?.copyWith(color: Palette.primary),
                ),
                Flexible(
                  child: Text(
                    'kg',
                    style: context
                        .textTheme()
                        .headlineMedium
                        ?.copyWith(color: Palette.primary, fontSize: 8),
                    overflow: TextOverflow.fade,
                  ),
                ),
              ],
            ),
          ),
        if (coinsValue != null)
          Expanded(
            child: Text(
              coinsValue!.toFixedLengthString(),
              style: context
                  .textTheme()
                  .headlineMedium
                  ?.copyWith(color: Palette.yellow),
              textAlign: TextAlign.end,
              overflow: TextOverflow.fade,
            ),
          ),
        if (countValue != null)
          Expanded(
            child: Text(
              countValue!.toFixedLengthString(),
              style: context
                  .textTheme()
                  .headlineMedium
                  ?.copyWith(color: Palette.secondary),
              textAlign: TextAlign.end,
              overflow: TextOverflow.fade,
            ),
          ),
      ],
    );
  }
}
