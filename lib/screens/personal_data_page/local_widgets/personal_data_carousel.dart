import 'package:flutter/material.dart';

class PersonalDataCarousel extends StatelessWidget {
  final List<Widget> children;
  final int index;
  final Widget loadingWidget;
  final bool isLoading;

  const PersonalDataCarousel({
    Key? key,
    required this.children,
    required this.index,
    required this.loadingWidget,
    required this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: index,
      children: children,
    );
  }
}
