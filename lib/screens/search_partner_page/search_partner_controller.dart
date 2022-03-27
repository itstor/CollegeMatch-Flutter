import 'package:college_match/core/values/colors.dart';
import 'package:college_match/core/values/firebase_constants.dart';
import 'package:college_match/data/model/user_model.dart';
import 'package:college_match/data/services/chat_service.dart';
import 'package:college_match/data/services/user_service.dart';
import 'package:college_match/screens/main_page/main_page.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class SearchPartnerController extends GetxController {
  final UserService _userService = Get.find<UserService>();
  final ChatService _chatService = Get.find<ChatService>();
  late bool isFirtsTime;

  @override
  void onInit() {
    super.onInit();
    try {
      isFirtsTime = Get.arguments;
    } catch (e) {
      isFirtsTime = false;
    }
    Future.delayed(Duration(seconds: 5), () async {
      var response = await _userService.searchPartner(auth.currentUser!.uid);

      if (response.isNotEmpty) {
        if (response['status'] == 'waiting') {
          Fluttertoast.showToast(
            msg: 'There is no partner available at the moment',
            gravity: ToastGravity.BOTTOM,
            backgroundColor: AppColor.kAccentColor['red'],
          );

          if (isFirtsTime) {
            Get.offAllNamed(MainPage.routeName);
          } else {
            Get.back();
          }
        } else if (response['status'] == 'success') {
          String groupChatid = await _chatService.connectUser(
              response['partner'], auth.currentUser!.uid);

          UserModel partnerUser =
              await _userService.getUser(response['partner']);

          Get.offNamed('/chat-page', arguments: {
            'peerUser': partnerUser,
            'isRevealed': false,
            'groupChatId': groupChatid,
          });
        }
      }
    });
  }
}
