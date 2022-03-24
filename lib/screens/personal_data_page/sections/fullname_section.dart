import 'package:college_match/core/values/colors.dart';
import 'package:college_match/screens/personal_data_page/controllers/personal_data_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FullnameSection extends StatelessWidget {
  final _controller = Get.find<PersonalDataPageController>();

  FullnameSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 95),
          Text(
            "Hello! What do you want to call you?",
            style: Get.textTheme.subtitle1!.copyWith(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          Expanded(
            child: Center(
              child: TextFormField(
                controller: _controller.nameTextController,
                style: Get.textTheme.subtitle1!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
                cursorColor: AppColor.kPrimaryPurple[100],
                cursorHeight: 25,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  hintText: "Your name...",
                  hintStyle: Get.textTheme.subtitle1!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  errorStyle: Get.textTheme.caption!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColor.kAccentColor['red']!,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                        color: AppColor.kAccentColor['red']!, width: 1.5),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                        color: AppColor.kAccentColor['red']!, width: 1.5),
                  ),
                  filled: true,
                  fillColor: Colors.black.withOpacity(0.05),
                ),
              ),
            ),
          ),
          const SizedBox(height: 92),
        ],
      ),
    );
  }
}
