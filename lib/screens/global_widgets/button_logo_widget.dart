import 'package:flutter/material.dart';

class ButtonLogoWidget extends StatelessWidget {
  final double? width;
  final double height;
  final EdgeInsets padding;
  final Widget logo;
  final String? text;
  final Color textColor;
  final Color color;
  final VoidCallback onTap;
  const ButtonLogoWidget(
      {Key? key,
      required this.height,
      this.width,
      required this.padding,
      required this.logo,
      this.text,
      required this.color,
      this.textColor = Colors.black,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(height / 2),
          ),
          backgroundColor: color,
          side: BorderSide.none,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            logo,
            text != null
                ? Expanded(
                    child: Center(
                      child: Text(
                        text!,
                        style: Theme.of(context).textTheme.subtitle2?.copyWith(
                              color: textColor,
                            ),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
