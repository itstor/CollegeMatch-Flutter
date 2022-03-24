import 'package:college_match/core/values/colors.dart';
import 'package:college_match/screens/global_widgets/dot_loading.dart';
import 'package:college_match/screens/personal_data_page/controllers/personal_data_page_controller.dart';
import 'package:college_match/screens/personal_data_page/local_widgets/mark_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InterestSection extends StatefulWidget {
  InterestSection({Key? key}) : super(key: key);

  @override
  State<InterestSection> createState() => _InterestSectionState();
}

class _InterestSectionState extends State<InterestSection> {
  final _controller = Get.find<PersonalDataPageController>();

  @override
  Widget build(BuildContext context) {
    return _controller.interestData.obx(
      (data) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 95),
              Text(
                "Choose your interests",
                style: Get.textTheme.subtitle1!.copyWith(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 32),
              Wrap(
                children: data!.map(
                  (e) {
                    final bool isSelected =
                        _controller.interestList.contains(e.interest);

                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FilterChip(
                        label: Text(e.interest),
                        selected: isSelected,
                        pressElevation: 0,
                        backgroundColor: Colors.white,
                        selectedColor: AppColor.kPrimaryPurple[100],
                        labelStyle: Get.textTheme.caption!.copyWith(
                          color: isSelected ? Colors.white : Colors.black,
                          fontSize: 14,
                        ),
                        checkmarkColor: Colors.white,
                        onSelected: (value) {
                          if (value) {
                            _controller.interestList.add(e.interest);
                          } else {
                            _controller.interestList.remove(e.interest);
                          }
                          setState(() {});
                        },
                      ),
                    );
                  },
                ).toList(),
              ),
            ],
          ),
        );
      },
      onLoading: SizedBox(
        height: Get.size.height,
        width: Get.size.width,
        child: Center(
          child: Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Center(child: const DotLoading()),
          ),
        ),
      ),
    );
  }
}
