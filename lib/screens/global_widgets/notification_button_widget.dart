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
        RoundedIconButtonWidget(
          size: size,
          color: color,
          onPressed: onPressed,
          icon: icon,
        ),
        Positioned(
          top: -4,
          left: size / 2,
          child: number == null || number == 0
              ? Container()
              : Container(
                  width: notificationSize,
                  height: notificationSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: notificationColor,
                  ),
                  child: Center(
                    child: Text(
                      number.toString(),
                      style: Theme.of(context).textTheme.caption?.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ),
                ),
        )
      ],
    );
  }
}
