import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AdventCalendarClosedCard extends StatelessWidget {
  final String imageUrl;
  final bool isAvailable;
  const AdventCalendarClosedCard({
    Key? key,
    required this.imageUrl,
    this.isAvailable = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Stack(
        children: [
          Opacity(
            opacity: isAvailable ? 1.0 : 0.5,
            child: Card(
              elevation: 2,
              clipBehavior: Clip.hardEdge,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)),
              child: SvgPicture.network(
                imageUrl,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
