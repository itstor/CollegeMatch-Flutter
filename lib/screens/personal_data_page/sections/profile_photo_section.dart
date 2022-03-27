import 'package:college_match/screens/personal_data_page/controllers/personal_data_page_controller.dart';
import 'package:college_match/screens/personal_data_page/personal_data_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePhotoSection extends StatelessWidget {
  final _controller = Get.find<PersonalDataPageController>();
  ProfilePhotoSection({Key? key}) : super(key: key);

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
            "Give us your best photo",
            style: Get.textTheme.subtitle1!.copyWith(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          Expanded(
            child: Center(
              child: InkWell(
                onTap: _controller.getImage,
                child: Container(
                  width: Get.width * 0.55,
                  height: Get.width * 0.55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Get.width * 0.55 / 2),
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Obx(() => Container(
                          width: Get.width * 0.5,
                          height: Get.width * 0.5,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Get.width * 0.55 / 2),
                          ),
                          child: _controller.profilePicture.value == null
                              ? Image.asset(
                                  _controller.gender.value == "Male"
                                      ? "assets/images/default-profile-picture/male.png"
                                      : "assets/images/default-profile-picture/female.png",
                                  fit: BoxFit.cover,
                                )
                              : Image.file(
                                  _controller.profilePicture.value!,
                                  fit: BoxFit.cover,
                                ),
                        )),
                  ),
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
