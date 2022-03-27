import 'package:flutter/material.dart';

class RoundedIconButtonWidget extends StatelessWidget {
  final Color color;
  final VoidCallback onPressed;
  final Widget icon;

  const RoundedIconButtonWidget({
    Key? key,
    required this.color,
    required this.onPressed,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(50 / 2),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: icon,
      ),
    );
  }
}
