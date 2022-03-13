import 'package:college_match/core/values/firebase_constants.dart';
import 'package:college_match/data/services/auth_service.dart';
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
    ever(firebaseUser, setInitialScreen);

    googleSignInAccount.bindStream(googleSign.onCurrentUserChanged);
    ever(googleSignInAccount, _setInitialScreenGoogle);
  }

  setInitialScreen(User? user) async {
    if (user == null) {
      Get.offNamed("/welcome-page");
    } else {
      bool isUserFinishedRegister =
          await _authService.isUserFinishedRegister(user.uid);
      bool isUserFilledQuestionnaire =
          await _authService.isUserFilledQuestionaire(user.uid);

      if (isUserFinishedRegister && !isUserFilledQuestionnaire) {
        Get.offNamed("/chat-page");
      } else {
        Get.offNamed("/welcome-page");
        print("FIRED");
      }
    }
  }

  _setInitialScreenGoogle(GoogleSignInAccount? googleSignInAccount) async {
    if (googleSignInAccount == null) {
      Get.offNamed("/welcome-page");
    } else {
      // bool isUserFinishedRegister = await _authService
      //     .isUserFinishedRegister(FirebaseAuth.instance.currentUser!.uid);
      // bool isUserFilledQuestionnaire = await _authService
      //     .isUserFilledQuestionaire(FirebaseAuth.instance.currentUser!.uid);
      // print(isUserFilledQuestionnaire);
      // print(isUserFinishedRegister);
      Get.offNamed("/chat-page");
    }
  }
}
