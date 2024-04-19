import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:klimo/utils/theme.dart';

class LogoList extends StatelessWidget {
  const LogoList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double logoWidth = MediaQuery.of(context).size.width * 0.48;
    Widget logoWrapper(String assetPath,
            [double height = 52, double padding = 16]) =>
        Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
            side: const BorderSide(color: Palette.greyLight),
          ),
          margin: const EdgeInsets.all(4.0),
          child: Padding(
            padding: EdgeInsets.all(padding),
            child: SizedBox(
              height: height,
              width: logoWidth,
              child: assetPath.endsWith('.svg')
                  ? SvgPicture.asset(assetPath)
                  : Image.asset(assetPath),
            ),
          ),
        );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              logoWrapper('assets/logos/logo_tb.svg', 28),
              logoWrapper('assets/logos/logo_iee.png', 30),
              logoWrapper('assets/logos/logo_uk.png', 66, 0),
              logoWrapper('assets/logos/logo_hoe.png', 40)
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              logoWrapper('assets/logos/logo_denet.png', 46, 18),
              logoWrapper('assets/logos/logo_bmwk.png', 190, 0),
            ],
          ),
        ),
      ],
    );
  }
}
