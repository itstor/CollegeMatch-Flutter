import 'package:college_match/screens/global_widgets/rounded_icon_button_widget.dart';
import 'package:flutter/material.dart';

class NotficationButtonWidget extends StatelessWidget {
  final double size;
  final Color color;
  final VoidCallback onPressed;
  final Widget icon;
  final int? number;
  final Color notificationColor;
  final double notificationSize;

  const NotficationButtonWidget({
    Key? key,
    required this.size,
    required this.color,
    required this.onPressed,
    required this.icon,
    required this.notificationColor,
    required this.notificationSize,
    this.number,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 30,
          height: 30,
          child: RoundedIconButtonWidget(
            color: color,
            onPressed: onPressed,
            icon: icon,
          ),
        ),
      ],
    );
  }
}
