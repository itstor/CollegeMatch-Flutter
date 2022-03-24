import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:college_match/core/values/colors.dart';
import 'package:college_match/screens/personal_data_page/controllers/personal_data_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class GenderSection extends StatelessWidget {
  final _controller = Get.find<PersonalDataPageController>();
  GenderSection({Key? key}) : super(key: key);

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
            "What's your gender?",
            style: Get.textTheme.subtitle1!.copyWith(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          Expanded(
              child: Row(
            children: [
              Flexible(
                flex: 1,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: BouncingWidget(
                    onPressed: () {
                      _controller.gender.value = "Male";
                    },
                    duration: Duration(milliseconds: 200),
                    scaleFactor: 2,
                    child: Obx(
                      () => Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: _controller.gender.value == "Male"
                              ? AppColor.kPrimaryPurple[100]
                              : Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: SvgPicture.asset(
                                  "assets/images/male-symbol.svg",
                                  color: _controller.gender.value == "Male"
                                      ? Colors.white
                                      : AppColor.kPrimaryPurple[100],
                                ),
                              ),
                            ),
                            Text(
                              "Male",
                              style: Get.textTheme.subtitle2!.copyWith(
                                color: _controller.gender.value == "Male"
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Flexible(
                flex: 1,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: BouncingWidget(
                    onPressed: () {
                      _controller.gender.value = "Female";
                    },
                    duration: Duration(milliseconds: 200),
                    scaleFactor: 2,
                    child: Obx(
                      () => Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: _controller.gender.value == "Female"
                              ? AppColor.kPrimaryPink[100]
                              : Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: SvgPicture.asset(
                                "assets/images/female-symbol.svg",
                                color: _controller.gender.value == "Female"
                                    ? Colors.white
                                    : AppColor.kPrimaryPink[100],
                              ),
                            ),
                            Text(
                              "Female",
                              style: Get.textTheme.subtitle2!.copyWith(
                                color: _controller.gender.value == "Female"
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          )),
          const SizedBox(height: 92),
        ],
      ),
    );
  }
}
