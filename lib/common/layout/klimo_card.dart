import 'package:flutter/material.dart';

class KlimoCard extends StatelessWidget {
  final Widget child;
  final Color? color;
  final Function()? onTap;
  final Color? borderColor;
  final EdgeInsets? padding;

  const KlimoCard({
    Key? key,
    required this.child,
    this.color,
    this.onTap,
    this.borderColor,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            border: borderColor != null
                ? Border.all(color: borderColor!, width: 2)
                : null,
            borderRadius: BorderRadius.circular(12),
            color: color ?? Colors.white,
            boxShadow: const [
              //check border of shadow or the blur radius
              BoxShadow(
                offset: Offset(0, 1),
                color: Colors.black12,
                blurRadius: 3.0,
              )
            ],
          ),
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}
