import 'package:flutter/material.dart';

class RoundedIconButtonWidget extends StatelessWidget {
  final double size;
  final Color color;
  final VoidCallback onPressed;
  final Widget icon;

  const RoundedIconButtonWidget({
    Key? key,
    required this.size,
    required this.color,
    required this.onPressed,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(size / 2),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: icon,
      ),
    );
  }
}
