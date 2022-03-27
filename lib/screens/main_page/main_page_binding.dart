import 'package:college_match/data/services/chat_service.dart';
import 'package:college_match/data/services/user_service.dart';
import 'package:college_match/screens/main_page/controllers/main_page_controller.dart';
import 'package:college_match/screens/main_page/controllers/main_page_tabbar_controller.dart';
import 'package:college_match/screens/main_page/data/user_data.dart';

import 'package:get/get.dart';

class MainPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserService>(() => UserService());
    Get.lazyPut<ChatService>(() => ChatService());
    Get.lazyPut<UserData>(() => UserData());
    Get.lazyPut<MainPageTabBarController>(
        () => MainPageTabBarController(tabLenght: 3));
    Get.lazyPut<MainPageController>(() => MainPageController());
  }
}
