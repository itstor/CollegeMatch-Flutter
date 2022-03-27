import 'package:college_match/screens/chat_page/controllers/chat_page_controller.dart';
import 'package:get/get.dart';

class ChatPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatPageController>(() => ChatPageController());
  }
}
