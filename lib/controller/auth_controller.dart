import 'package:college_match/core/values/firebase_constants.dart';
import 'package:college_match/data/services/auth_service.dart';
import 'package:college_match/screens/welcome_page/controllers/welcome_page_controller.dart';
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
    googleSignInAccount = Rx<GoogleSignInAccount?>(googleSign.currentUser);

    firebaseUser.bindStream(auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAllNamed('/welcome-page');
    } else {
      Get.offAllNamed('/chat-page');
    }
  }

  _setInitialScreenGoogle(GoogleSignInAccount? googleSignInAccount) {
    print(googleSignInAccount);
    if (googleSignInAccount == null) {
      Get.offAllNamed('/welcome-page');
    } else {
      Get.offAllNamed('/chat-page');
    }
  }
}