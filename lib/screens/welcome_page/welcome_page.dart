import 'package:college_match/core/values/firebase_constants.dart';
import 'package:college_match/data/services/auth_service.dart';
import 'package:college_match/screens/global_widgets/button_logo_widget.dart';
import 'package:college_match/screens/global_widgets/circle_logo_widget.dart';
import 'package:college_match/screens/global_widgets/dot_loading.dart';
import 'package:college_match/screens/global_widgets/glow_button_widget.dart';
import 'package:college_match/screens/welcome_page/controllers/signup_controller.dart';
import 'package:college_match/screens/welcome_page/controllers/welcome_page_controller.dart';
import 'package:college_match/screens/welcome_page/local_widgets/signin_form.dart';
import 'package:college_match/screens/welcome_page/local_widgets/signup_form_first.dart';
import 'package:college_match/screens/welcome_page/local_widgets/signup_form_otp.dart';
import 'package:college_match/screens/welcome_page/local_widgets/signup_form_second.dart';
import 'package:college_match/screens/welcome_page/local_widgets/signup_section_helper..dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class WelcomePage extends StatelessWidget {
  static const String routeName = "/welcome-page";
  WelcomePage({
    Key? key,
    this.initialSignUpSteps = SignUpSteps.first,
  }) : super(key: key);

  final _screenSize = Get.mediaQuery.size;
  final _controller = Get.find<WelcomePageController>();
  final _signupController = Get.find<SignUpController>();
  final _authService = Get.find<AuthService>();
  final SignUpSteps initialSignUpSteps;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SlidingUpPanel(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
        minHeight: 0,
        maxHeight: _screenSize.height * 0.83,
        controller: _controller.panelController,
        boxShadow: [
          BoxShadow(
            color: Colors.grey[850]!.withAlpha(15),
            blurRadius: 20,
            offset: const Offset(0, -10),
          ),
        ],
        header: Container(
          width: Get.size.width,
          padding: const EdgeInsets.only(top: 12),
          child: Center(
            child: Container(
              height: 5,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.grey[300]!,
                borderRadius: BorderRadius.circular(32),
              ),
            ),
          ),
        ),
        onPanelClosed: () => _controller.hideKeyboard(),
        panel: Obx(
          () => _controller.panelState.value == WelcomePanelState.login
              ? _buildLoginPanel()
              : _buildSignUpPanel(),
        ),
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/background-1.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SafeArea(
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const SizedBox(height: 36),
                        Image.asset(
                          "assets/images/collegematch-title.png",
                          height: 36,
                          width: 173,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            color: Color(0xFFC4C4C4),
                            borderRadius: BorderRadius.all(
                              Radius.circular(32),
                            ),
                          ),
                          width: 137,
                          height: 137,
                        ),
                        const SizedBox(height: 32),
                        Text(
                          "College Match",
                          style: Get.textTheme.headline2
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: 240,
                          child: Text(
                            "Lorem ipsum  dolor sit amet lorem lorem lorem lorem ipsum",
                            textAlign: TextAlign.center,
                            style: Get.textTheme.bodyText2,
                          ),
                        )
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _signInWithGoogleButton(),
                      const SizedBox(height: 18),
                      _signInWithEmail(),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account?",
                            style: Get.textTheme.caption,
                          ),
                          TextButton(
                            onPressed: () {
                              _controller.panelState.value =
                                  WelcomePanelState.register;
                              _controller.panelController.open();
                            },
                            child: Text(
                              "Sign up",
                              style: Get.textTheme.caption
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            ),
                            style: TextButton.styleFrom(
                                padding: const EdgeInsets.only(left: 4),
                                minimumSize: Size.zero),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding _buildLoginPanel() {
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              child: Text(
                "Login",
                style: Get.textTheme.headline1,
              ),
            ),
            const SizedBox(height: 32),
            SignInForm(),
            const SizedBox(height: 64),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 1,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Colors.white,
                          Colors.grey[400]!,
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    "Or Sign in with",
                    style: Get.textTheme.caption,
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 1,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                        colors: [
                          Colors.white,
                          Colors.grey[400]!,
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28),
            GlowButtonWidget(
              width: 60,
              height: 60,
              child: Center(
                child: Image.asset('assets/icons/google-icon.png'),
              ),
              backgroundColor: Colors.white,
              glowColor: const Color(0xFF9E9E9E).withAlpha(30),
              glowOffset: const Offset(0, 8),
              borderRadius: 34,
              blurRadius: 15,
              onPressed: _authService.signInWithGoogle,
            ),
            Expanded(child: Container()),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account?",
                  style: Get.textTheme.caption,
                ),
                TextButton(
                  onPressed: _controller.movePanel,
                  child: Text(
                    "Sign up",
                    style: Get.textTheme.caption
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.only(left: 4),
                    minimumSize: Size.zero,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Padding _buildSignUpPanel() {
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: double.infinity,
                child: Text(
                  "Sign Up",
                  style: Get.textTheme.headline1,
                ),
              ),
              const SizedBox(height: 32),
              SignUpSectionHelper(
                index: _signupController.currentStep.index,
                loadingWidget: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: Get.size.height * 0.6),
                  child: const Center(
                    child: DotLoading(),
                  ),
                ),
                isLoading: _signupController.isLoading,
                children: [
                  SignUpFormFirst(),
                  SignUpFormSecond(),
                  // ConstrainedBox(
                  //   constraints:
                  //       BoxConstraints(minHeight: Get.size.height * 0.5),
                  //   child: Center(
                  //     child: SignUpFormOTP(),
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  ButtonLogoWidget _signInWithGoogleButton() {
    return ButtonLogoWidget(
      height: 58,
      width: _screenSize.width * 0.8,
      padding: const EdgeInsets.all(11),
      logo: CircleLogoWidget(
          diameter: 38,
          color: Colors.white,
          image: Image.asset("assets/icons/google-icon.png"),
          padding: 8),
      color: Colors.white.withOpacity(0.58),
      text: "Sign in with Google",
      onTap: _authService.signInWithGoogle,
    );
  }

  ButtonLogoWidget _signInWithEmail() {
    return ButtonLogoWidget(
      height: 58,
      width: _screenSize.width * 0.8,
      padding: const EdgeInsets.all(11),
      logo: CircleLogoWidget(
        diameter: 38,
        color: Colors.white,
        image: Image.asset("assets/icons/mail-icon.png"),
        padding: 8,
      ),
      color: Colors.black,
      text: "Sign in with Email",
      textColor: Colors.white,
      onTap: () {
        _controller.panelState.value = WelcomePanelState.login;
        _controller.panelController.open();
      },
    );
  }
}
