import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:klimo/common/layout/klimo_bottom_sheet.dart';
import 'package:klimo/components/advent_calendar/data/advent_calendar_assets.dart';
import 'package:klimo/config/analytics.dart';
import 'package:klimo/utils/localisation.dart';
import 'package:klimo_datamodels/util.dart';

import '../../../utils/launch_url.dart';
import '../../../utils/theme.dart';

class AdventFactCard extends StatelessWidget {
  final String? title;
  final Translation fact;
  const AdventFactCard({
    super.key,
    required this.fact,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() => showKlimoModalBottomSheet(
          context: context,
          builder: (context) => KlimoBottomSheet(
                backGroundColor: Palette.adventCalendarBeige,
                header: const KlimoBottomSheetHeader(),
                body: _AdventFactCardDialog(fact: fact),
              ))).logInteraction(
        params: {
          AnalyticsParameters.action: AnalyticsValues.openAdventCalendarFact,
          AnalyticsParameters.scope: AnalyticsValues.adventsCalendarScope,
        },
      ),
      child: Stack(
        children: [
          Card(
            color: Palette.adventCalendarBeige,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  SvgPicture.asset(
                    AdventCalendarImages.lightBulb,
                    height: 64,
                    fit: BoxFit.contain,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Weihnachtstipp',
                            textAlign: TextAlign.center,
                            style: context
                                .textTheme()
                                .headlineMedium
                                ?.copyWith(color: Palette.darkGreen),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              title ?? "",
                              style: context
                                  .textTheme()
                                  .bodySmall
                                  ?.copyWith(color: Palette.darkGreen),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 12.0,
            right: 12.0,
            child: Text(
              context.localisation().advents_tipp_read_more,
              style: context
                  .textTheme()
                  .labelLarge
                  ?.copyWith(color: Palette.adventCalendarRed),
            ),
          ),
        ],
      ),
    );
  }
}

class _AdventFactCardDialog extends StatelessWidget {
  final Translation fact;

  const _AdventFactCardDialog({required this.fact});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              SvgPicture.asset(
                AdventCalendarImages.lightBulb,
                fit: BoxFit.contain,
                height: 48,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  top: 16.0,
                ),
                child: Text(
                  'Weihnachtstipp',
                  style: context
                      .textTheme()
                      .headlineLarge
                      ?.copyWith(color: Palette.darkGreen),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Markdown(
            shrinkWrap: true,
            data: fact.tr(context),
            styleSheet:
                MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
              a: const TextStyle(
                color: Palette.primary,
                decoration: TextDecoration.underline,
                decorationColor: Palette.primary,
              ),
              h1: context.textTheme().displayLarge,
              h2: context.textTheme().displayMedium,
              h3: context.textTheme().displaySmall,
              p: context.textTheme().bodyLarge,
            ),
            onTapLink: (_, href, __) {
              if (href != null) {
                final Uri url = Uri.parse(href);
                openUrl(url.toString());
              }
            },
          ),
        ),
      ],
    );
  }
}
