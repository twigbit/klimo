import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

abstract class KlimoIcons {
  static String _asset(String name) => "assets/icons/klimo/$name";

  static final beach = _asset("Beach.svg");
  static final bike = _asset("Bike.svg");
  static final bird = _asset("Bird.svg");
  static final car = _asset("Car.svg");
  static final carSharing = _asset("Car_Sharing.svg");
  static final carSharing1 = _asset("Car_Sharing_1.svg");
  static final cat = _asset("Cat.svg");
  static final cruise = _asset("Cruise.svg");
  static final cultural = _asset("Cultural.svg");
  static final dog = _asset("Dog.svg");
  static final family = _asset("Family.svg");
  static final fish = _asset("Fish.svg");
  static final hiking = _asset("Hiking.svg");
  static final horse = _asset("Horse.svg");
  static final kickScooter = _asset("Kick Scooter.svg");
  static final motorcycle = _asset("Motorcycle.svg");
  static final reptile = _asset("Reptile.svg");
  static final rodent = _asset("Rodent.svg");
  static final skiing = _asset("Skiing.svg");
  static final stayHome = _asset("Stay_home.svg");
}

/// Icon widget that renders a svg iconset with the same API as the [Icon] class of flutter.
class KlimoIcon extends StatelessWidget {
  /// Creates an icon.
  ///
  /// The [size] and [color] default to the value given by the current [IconTheme].
  const KlimoIcon(
    this.icon, {
    Key? key,
    this.size,
    this.color,
    this.semanticLabel,
  }) : super(key: key);

  /// The icon to display. The available icons are described in [KlimoIcons].
  ///
  /// The icon can be null, in which case the widget will render as an empty space of the specified [size].
  final String? icon;

  /// See [Icon.size]
  final double? size;

  /// See [Icon.color]
  final Color? color;

  /// See [Icon.semanticLabel]
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final iconTheme = IconTheme.of(context);
    final iconSize = size ?? iconTheme.size;

    if (icon == null) {
      return Semantics(
        label: semanticLabel,
        child: SizedBox(width: iconSize, height: iconSize),
      );
    }

    final iconColor = color ?? iconTheme.color!;
    final iconOpacity = iconTheme.opacity ?? 1.0;

    return Semantics(
      label: semanticLabel,
      child: ExcludeSemantics(
        child: SvgPicture.asset(icon!,
            width: iconSize,
            height: iconSize,
            excludeFromSemantics: true,
            color: iconOpacity != 1.0
                ? iconColor.withOpacity(iconColor.opacity * iconOpacity)
                : iconColor),
      ),
    );
  }
}

/// Renders an icon on a circle.
class IconOnCircle extends StatelessWidget {
  const IconOnCircle({Key? key, required this.icon}) : super(key: key);

  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    final iconTheme = IconTheme.of(context);
    final iconColor = iconTheme.color!;

    return Container(
      width: 48,
      height: 48,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: iconColor.withAlpha(30),
          borderRadius: BorderRadius.circular(24)),
      child: Center(
        child: icon,
      ),
    );
  }
}
