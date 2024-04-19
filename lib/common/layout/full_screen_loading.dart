import 'package:flutter/material.dart';
import 'package:klimo/utils/theme.dart';
import 'package:shimmer/shimmer.dart';

class FullScreenLoading extends StatelessWidget {
  const FullScreenLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomShimmer(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Row(
                  children: List.generate(
                    4,
                    (index) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: _loadingContainer(height: 6, borderRadius: 4),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: CloseButton(),
              ),
            ),
            const Expanded(child: SizedBox()),
            CustomShimmer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: _loadingContainer(
                        height: 27, width: 200, borderRadius: 10),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: _loadingContainer(
                        height: 27, width: 150, borderRadius: 10),
                  ),
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: _loadingContainer(height: 45, borderRadius: 25),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 56),
          ],
        ),
      ),
    );
  }

  Widget _loadingContainer({
    double? width,
    double? height,
    double borderRadius = 0,
  }) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.all(
          Radius.circular(borderRadius),
        ),
      ),
    );
  }
}

class CustomShimmer extends StatelessWidget {
  const CustomShimmer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade100,
      highlightColor: context.colorScheme().primary.withOpacity(0.15),
      child: child,
    );
  }
}
