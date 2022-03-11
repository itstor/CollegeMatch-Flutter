import 'package:college_match/core/values/colors.dart';
import 'package:college_match/core/values/firebase_constants.dart';
import 'package:college_match/screens/global_widgets/glow_button_widget.dart';
import 'package:college_match/screens/global_widgets/rounded_text_field_widget.dart';
import 'package:college_match/screens/welcome_page/controllers/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';

class SignUpFormFirst extends StatelessWidget {
  final _controller = Get.find<SignUpController>();

  SignUpFormFirst({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Form(
          key: _controller.formKeyFirst,
          child: Column(
            children: [
              RoundedTextFieldWidget(
                hintText: "Email Address",
                initialValue:
                    _controller.email == '' ? null : _controller.email,
                validator: (value) => _controller.emailValidator(value!),
                onChanged: _controller.setEmail,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 24),
              Obx(
                () => RoundedTextFieldWidget(
                  hintText: "Password",
                  initialValue:
                      _controller.password == '' ? null : _controller.password,
                  validator: (value) => _controller.passwordValidator(value!),
                  onChanged: _controller.setPassword,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  obscureText: _controller.hidePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _controller.hidePassword
                          ? IconlyLight.hide
                          : IconlyLight.show,
                      color: Colors.grey,
                    ),
                    onPressed: _controller.togglePassword,
                    padding: EdgeInsets.zero,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Obx(
                () => RoundedTextFieldWidget(
                  hintText: "Confirm Password",
                  initialValue: _controller.confirmPassword == ''
                      ? null
                      : _controller.confirmPassword,
                  validator: (value) =>
                      _controller.confirmPasswordValidator(value!),
                  onChanged: _controller.setConfirmPassword,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  obscureText: _controller.hideConfirmPassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _controller.hideConfirmPassword
                          ? IconlyLight.hide
                          : IconlyLight.show,
                      color: Colors.grey,
                    ),
                    onPressed: _controller.toggleConfirmPassword,
                    padding: EdgeInsets.zero,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              GlowButtonWidget(
                height: 60,
                width: double.infinity,
                child: Center(
                  child: Text(
                    "Continue",
                    style: Get.textTheme.subtitle1!.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
                backgroundColor: Color(0xFFA989FF),
                glowColor: AppColor.kPrimaryPurple[100]!,
                glowOffset: const Offset(0, 6),
                borderRadius: 12,
                blurRadius: 22,
                onPressed: _controller.tryContinue,
              ),
              const SizedBox(height: 50),
              //Divider Or Sign up with
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
                      "Or Sign up with",
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
                onPressed: authController.signInWithGoogle,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
