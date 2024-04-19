import 'package:flutter/material.dart';

class FullScreenBackgroundOverlay extends StatelessWidget {
  const FullScreenBackgroundOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withOpacity(0),
            Colors.black38,
            Colors.black54,
            Colors.black87,
            Colors.black87,
          ],
        ),
      ),
    );
  }
}
