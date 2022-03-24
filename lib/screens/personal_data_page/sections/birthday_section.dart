import 'package:college_match/core/values/colors.dart';
import 'package:college_match/screens/personal_data_page/controllers/personal_data_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BirthdaySection extends StatelessWidget {
  final _controller = Get.find<PersonalDataPageController>();
  BirthdaySection({Key? key}) : super(key: key);

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
            "Nice to meet you ${_controller.name}! What is your birthday?",
            style: Get.textTheme.subtitle1!.copyWith(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          Expanded(
            child: Center(
              child: TextFormField(
                controller: _controller.birthdayTextController,
                style: Get.textTheme.subtitle1!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
                readOnly: true,
                onTap: () => _controller.setBirthday(context),
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  hintText: "Your birthday...",
                  hintStyle: Get.textTheme.subtitle1!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
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
