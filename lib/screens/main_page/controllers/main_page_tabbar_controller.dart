import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainPageTabBarController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  final int tabLenght;

  MainPageTabBarController({required this.tabLenght});

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: tabLenght, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
}
