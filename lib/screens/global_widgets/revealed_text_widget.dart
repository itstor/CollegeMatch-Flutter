import 'package:flutter/material.dart';

class RevealedTextWidget extends StatelessWidget {
  final bool isRevealed;
  final String unReveal;
  final String reveal;
  final TextStyle style;

  RevealedTextWidget({
    Key? key,
    required this.isRevealed,
    required this.unReveal,
    required this.reveal,
    required this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isRevealed
        ? Text(reveal, style: style)
        : Text(unReveal, style: style);
  }
}
