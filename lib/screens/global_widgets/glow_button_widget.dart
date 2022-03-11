import 'package:flutter/material.dart';

class GlowButtonWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final Widget child;
  final Color backgroundColor;
  final Color glowColor;
  final double? borderRadius;
  final Offset glowOffset;
  final double blurRadius;
  final Padding? contentPadding;
  final VoidCallback? onPressed;

  const GlowButtonWidget(
      {Key? key,
      this.height,
      this.width,
      required this.child,
      required this.backgroundColor,
      required this.glowColor,
      required this.glowOffset,
      required this.borderRadius,
      required this.blurRadius,
      this.contentPadding,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: glowColor,
            blurRadius: blurRadius,
            offset: glowOffset,
          ),
        ],
      ),
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 0),
          ),
          backgroundColor: backgroundColor,
          side: BorderSide.none,
        ),
        child: child,
      ),
    );
  }
}
