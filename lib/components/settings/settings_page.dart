import 'package:flutter/material.dart';
import 'package:klimo/common/layout/util.dart';
import 'package:klimo/utils/localisation.dart';

import 'settings_page_sections.dart';
import 'build_info.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.localisation().settings_headline),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          top: 16.0,
          bottom: 32.0,
        ),
        child: Column(
          children: const [
            ProfileSection(),
            DividerComponent(),
            CommunitySection(),
            DividerComponent(),
            GeneralSection(),
            DividerComponent(),
            ApprovalSection(),
            DividerComponent(),
            MoreSection(),
            DividerComponent(),
            PartnerSection(),
            BuildInfo(),
          ].padded(const EdgeInsets.symmetric(vertical: 0)),
        ),
      ),
    );
  }
}
