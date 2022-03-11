import 'package:college_match/core/values/colors.dart';
import 'package:college_match/screens/global_widgets/glow_button_widget.dart';
import 'package:college_match/screens/global_widgets/rounded_text_field_widget.dart';
import 'package:college_match/screens/welcome_page/controllers/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class SignUpFormSecond extends StatelessWidget {
  final _controller = Get.find<SignUpController>();

  SignUpFormSecond({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Form(
          key: _controller.formKeySecond,
          child: Column(
            children: [
              RoundedTextFieldWidget(
                hintText: "Username",
                initialValue:
                    _controller.username == '' ? null : _controller.username,
                validator: (value) => _controller.usernameValidator(value!),
                onChanged: _controller.setUsername,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 24),
              InternationalPhoneNumberInput(
                onInputChanged: (PhoneNumber number) {
                  _controller.setPhoneNumber(number.phoneNumber ?? '');
                },
                onInputValidated: (bool value) {
                  print(value);
                },
                selectorConfig: const SelectorConfig(
                  selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                ),
                textStyle: Get.textTheme.bodyText2!.copyWith(
                  fontWeight: FontWeight.w500,
                ),
                initialValue: PhoneNumber(
                  isoCode: 'ID',
                  phoneNumber: _controller.phoneNumber,
                ),
                keyboardAction: TextInputAction.done,
                spaceBetweenSelectorAndTextField: 0,
                ignoreBlank: false,
                autoValidateMode: AutovalidateMode.disabled,
                selectorTextStyle: Get.textTheme.bodyText1,
                formatInput: false,
                keyboardType: const TextInputType.numberWithOptions(
                    signed: true, decimal: true),
                inputDecoration: InputDecoration(
                  hintText: "Phone Number",
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                  hintStyle: Get.textTheme.bodyText2!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFFC8C8C8),
                  ),
                  errorStyle: Get.textTheme.caption!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColor.kAccentColor['red']!,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                        color: AppColor.kPrimaryPurple[100]!, width: 1.5),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                        color: AppColor.kAccentColor['red']!, width: 1.5),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                        color: AppColor.kAccentColor['red']!, width: 1.5),
                  ),
                  filled: true,
                  fillColor: AppColor.kGrayColor[10]!,
                ),
                searchBoxDecoration: InputDecoration(
                  hintText: "Country Name",
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                  hintStyle: Get.textTheme.bodyText2!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFFC8C8C8),
                  ),
                  errorStyle: Get.textTheme.caption!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColor.kAccentColor['red']!,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                        color: AppColor.kPrimaryPurple[100]!, width: 1.5),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                        color: AppColor.kAccentColor['red']!, width: 1.5),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                        color: AppColor.kAccentColor['red']!, width: 1.5),
                  ),
                  filled: true,
                  fillColor: AppColor.kGrayColor[10]!,
                ),
              ),
              const SizedBox(height: 60),
              GlowButtonWidget(
                height: 60,
                width: double.infinity,
                child: Center(
                  child: Text(
                    "Sign up",
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
                onPressed: _controller.trySignUp,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
