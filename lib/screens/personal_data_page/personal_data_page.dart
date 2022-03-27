import 'package:college_match/screens/global_widgets/glow_button_widget.dart';
import 'package:college_match/screens/personal_data_page/controllers/personal_data_page_controller.dart';
import 'package:college_match/screens/personal_data_page/sections/birthday_section.dart';
import 'package:college_match/screens/personal_data_page/sections/fullname_section.dart';
import 'package:college_match/screens/personal_data_page/sections/gender_section.dart';
import 'package:college_match/screens/personal_data_page/sections/interest_section.dart';
import 'package:college_match/screens/personal_data_page/sections/lifestyle_section.dart';
import 'package:college_match/screens/personal_data_page/sections/major_section.dart';
import 'package:college_match/screens/personal_data_page/sections/personality_section.dart';
import 'package:college_match/screens/personal_data_page/sections/profile_photo_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';

class PersonalDataPage extends StatelessWidget {
  static String routeName = '/personal-data-page';
  final _controller = Get.find<PersonalDataPageController>();

  PersonalDataPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _controller.goBack,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFC4B1F8),
                    Color(0xFFFDB1D5),
                  ],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                ),
              ),
            ),
            SafeArea(
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Obx(
                    () => IndexedStack(
                      index: _controller.stepIndex.value,
                      children: [
                        FullnameSection(),
                        GenderSection(),
                        BirthdaySection(),
                        MajorSection(),
                        PersonalitySection(),
                        LifestyleSection(),
                        InterestSection(),
                        ProfilePhotoSection(),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 32,
                    left: 32,
                    child: _buildBackButton(),
                  ),
                  Obx(
                    () => AnimatedPositioned(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                      bottom: _controller.isScrolling.value ? -60 : 24,
                      child: GlowButtonWidget(
                        height: 60,
                        width: Get.width * 0.85,
                        child: Center(
                          child: Text(
                            _controller.stepIndex.value != 7
                                ? "Continue"
                                : "Submit",
                            style: Get.textTheme.subtitle1!.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        backgroundColor: Color(0xFFA989FF),
                        glowColor: Color(0xFFA989FF),
                        glowOffset: const Offset(0, 6),
                        borderRadius: 30,
                        blurRadius: 25,
                        onPressed: _controller.goNext,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackButton() {
    return Obx(() => Visibility(
          visible: _controller.isBackButtonVisible.value,
          child: OutlinedButton(
            onPressed: () {
              _controller.goBack();
            },
            child: Icon(
              IconlyLight.arrowLeft,
              color:
                  Colors.black.withOpacity(_controller.backButtonOpacity.value),
              size: 22,
            ),
            style: OutlinedButton.styleFrom(
              fixedSize: Size(40, 40),
              minimumSize: Size.zero,
              backgroundColor:
                  Colors.white.withOpacity(_controller.backButtonOpacity.value),
              padding: EdgeInsets.zero,
              side: BorderSide.none,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ));
  }
}
