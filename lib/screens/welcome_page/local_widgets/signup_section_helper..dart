import 'package:flutter/material.dart';

class SignUpSectionHelper extends StatelessWidget {
  final List<Widget> children;
  final int index;
  final Widget loadingWidget;
  final bool isLoading;
  const SignUpSectionHelper({
    Key? key,
    required this.index,
    required this.children,
    required this.loadingWidget,
    required this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isLoading ? loadingWidget : children[index];
  }
}
