import 'package:college_match/core/values/colors.dart';
import 'package:college_match/screens/welcome_page/controllers/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class SignUpFormOTP extends StatelessWidget {
  final _controller = Get.find<SignUpController>();

  SignUpFormOTP({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        color: AppColor.kGrayColor[10]!,
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: AppColor.kPrimaryPurple[100]!, width: 1.5),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    return Column(
      children: [
        Text("Verification", style: Get.textTheme.headline2),
        const SizedBox(height: 18),
        Text(
          "Enter the code sent to the number",
          style: Get.textTheme.bodyText2!.copyWith(
            color: AppColor.kTyphographyColor[50]!,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          _controller.phoneNumber,
          style: Get.textTheme.bodyText1!.copyWith(
            color: AppColor.kTyphographyColor[80],
          ),
        ),
        const SizedBox(height: 32),
        Pinput(
          defaultPinTheme: defaultPinTheme,
          focusedPinTheme: focusedPinTheme,
          submittedPinTheme: submittedPinTheme,
          validator: (s) {
            return s == '2222' ? null : 'Pin is incorrect';
          },
          pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
          showCursor: true,
          onCompleted: (pin) => print(pin),
        ),
        const SizedBox(height: 32),
        Text(
          "Didn't receive the code?",
          style: Get.textTheme.bodyText2!.copyWith(
            color: AppColor.kTyphographyColor[50]!,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Resend code",
          style: Get.textTheme.bodyText2!.copyWith(
            color: AppColor.kPrimaryPurple[100]!,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
