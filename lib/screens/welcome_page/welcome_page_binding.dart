import 'package:college_match/screens/welcome_page/controllers/signin_controller.dart';
import 'package:get/get.dart';

import 'controllers/signup_controller.dart';
import 'controllers/welcome_page_controller.dart';

class WelcomePageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WelcomePageController>(() => WelcomePageController());
    Get.lazyPut<SignInController>(() => SignInController());
    Get.lazyPut<SignUpController>(() => SignUpController());
  }
}
