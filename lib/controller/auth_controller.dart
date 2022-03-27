import 'package:college_match/core/values/firebase_constants.dart';
import 'package:college_match/data/services/auth_service.dart';
import 'package:college_match/screens/chat_page/chat_page.dart';
import 'package:college_match/screens/main_page/main_page.dart';
import 'package:college_match/screens/personal_data_page/personal_data_page.dart';
import 'package:college_match/screens/welcome_page/controllers/signup_controller.dart';
import 'package:college_match/screens/welcome_page/controllers/welcome_page_controller.dart';
import 'package:college_match/screens/welcome_page/welcome_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

enum UserStatus {
  registerSuccess,
  registerUnfinished,
  phoneNumberUnfinished,
}

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> firebaseUser;

  late Rx<GoogleSignInAccount?> googleSignInAccount;
  final _authService = Get.find<AuthService>();

  @override
  void onReady() {
    super.onReady();

    firebaseUser = Rx<User?>(auth.currentUser);
    // googleSignInAccount = Rx<GoogleSignInAccount?>(googleSign.currentUser);

    firebaseUser.bindStream(auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) async {
    if (user == null) {
      Get.offAllNamed(WelcomePage.routeName);
    } else {
      final bool _isUserFinishedRegister =
          await _authService.isUserFinishedRegister(auth.currentUser!.uid);

      final bool _isUserFilledQuitionaire =
          await _authService.isUserFilledQuestionaire(auth.currentUser!.uid);

      if (_isUserFinishedRegister && _isUserFilledQuitionaire) {
        // Get.offAllNamed(MainPage.routeName);
        Get.offAllNamed(MainPage.routeName);
      } else if (_isUserFinishedRegister) {
        Get.offAllNamed(PersonalDataPage.routeName);
      } else {
        if (Get.currentRoute != WelcomePage.routeName) {
          print('Get.currentRoute: ${Get.currentRoute}');

          Get.offAllNamed(WelcomePage.routeName);
          print('here');
        }

        final _signupController = Get.find<SignUpController>();

        if (_signupController.currentStep == SignUpSteps.first) {
          final _welcomepageController = Get.find<WelcomePageController>();

          _signupController.setSignUpStep(SignUpSteps.second);
          _welcomepageController.setPanelState(WelcomePanelState.register);
          _welcomepageController.openPanel();
        }
      }
    }
  }
}
