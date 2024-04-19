import 'package:flutter/material.dart';
import 'package:klimo/utils/localisation.dart';
import 'package:klimo/utils/theme.dart';
import 'package:klimo_datamodels/util.dart';

import '../../../common/layout/klimo_card.dart';

class SelectGroupCard extends StatelessWidget {
  final Translation? logoUrl;
  final String? name;
  final bool isSelected;
  final Function() onTap;

  const SelectGroupCard(
      {Key? key,
      this.logoUrl,
      this.name,
      required this.isSelected,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: KlimoCard(
        onTap: onTap,
        borderColor: isSelected ? Palette.primary : null,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              logoUrl != null
                  ? Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Image.network(
                        logoUrl!.tr(context),
                        width: 80,
                        height: 32,
                      ),
                    )
                  : Container(height: 32),
              if (name != null)
                Expanded(
                  child: Text(
                    name!,
                    style: context.textTheme().headlineMedium,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
