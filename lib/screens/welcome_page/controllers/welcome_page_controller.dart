import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

enum WelcomePanelState { login, register }

class WelcomePageController extends GetxController {
  final Rx<WelcomePanelState> panelState = WelcomePanelState.login.obs;
  final PanelController panelController = PanelController();

  void hideKeyboard() {
    Get.focusScope?.unfocus();
  }

  void movePanel() {
    if (panelState.value == WelcomePanelState.login) {
      panelController.close();
      Future.delayed(const Duration(milliseconds: 500), () {
        panelState.value = WelcomePanelState.register;
        panelController.open();
      });
    } else {
      panelController.close();
      Future.delayed(const Duration(milliseconds: 500), () {
        panelState.value = WelcomePanelState.login;
        panelController.open();
      });
    }
  }
}
