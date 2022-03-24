import 'package:college_match/core/values/colors.dart';
import 'package:college_match/screens/global_widgets/dot_loading.dart';
import 'package:college_match/screens/global_widgets/glow_button_widget.dart';
import 'package:college_match/screens/global_widgets/rounded_text_field_widget.dart';
import 'package:college_match/screens/welcome_page/controllers/signin_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';

class SignInForm extends StatelessWidget {
  SignInForm({Key? key}) : super(key: key);

  final _controller = Get.find<SignInController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Form(
          key: _controller.formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(
                () => RoundedTextFieldWidget(
                  hintText: "Email Address",
                  initialValue:
                      _controller.email == '' ? null : _controller.email,
                  validator: (value) => _controller.emailValidator(value!),
                  onChanged: _controller.onChangeEmail,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  errorText: _controller.emailErrorMsg == ''
                      ? null
                      : _controller.emailErrorMsg,
                ),
              ),
              const SizedBox(height: 24),
              Obx(
                () => RoundedTextFieldWidget(
                  hintText: "Password",
                  initialValue:
                      _controller.password == '' ? null : _controller.password,
                  validator: (value) => _controller.passwordValidator(value!),
                  onChanged: _controller.onChangePassword,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  obscureText: _controller.hidePassword,
                  errorText: _controller.passwordErrorMsg == ''
                      ? null
                      : _controller.passwordErrorMsg,
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
              const SizedBox(height: 32),
              Obx(
                () => _controller.isLoading
                    ? const SizedBox(
                        child: DotLoading(),
                        height: 60,
                      )
                    : GlowButtonWidget(
                        height: 60,
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            "Sign In",
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
                        onPressed: () => _controller.trySubmit(),
                      ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
