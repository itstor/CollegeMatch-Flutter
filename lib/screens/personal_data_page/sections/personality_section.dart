import 'package:college_match/data/model/personality_question_model.dart';
import 'package:college_match/screens/global_widgets/dot_loading.dart';
import 'package:college_match/screens/personal_data_page/controllers/personal_data_page_controller.dart';
import 'package:college_match/screens/personal_data_page/local_widgets/personality_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class PersonalitySection extends StatelessWidget {
  final _controller = Get.find<PersonalDataPageController>();
  PersonalitySection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NotificationListener<UserScrollNotification>(
      onNotification: (notification) {
        if (notification.direction == ScrollDirection.forward ||
            notification.direction == ScrollDirection.reverse) {
          _controller.isScrolling.value = true;
        } else if (notification.direction == ScrollDirection.idle) {
          Future.delayed(const Duration(milliseconds: 1000),
              () => _controller.isScrolling.value = false);
        }

        return false;
      },
      child: _controller.personalityData.obx(
        (data) => ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          controller: _controller.personalityScrollController,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: data!.length,
          itemBuilder: (context, index) {
            final questionData = data[index];

            if (index == 0) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 95),
                  Text(
                    "Choose your best answer based on your own personality",
                    style: Get.textTheme.subtitle1!.copyWith(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    "1 if you dissagree, 5 if you agree",
                    style: Get.textTheme.caption!.copyWith(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 32),
                  _buildQuestionCard(questionData, index),
                ],
              );
            } else if (index == data.length - 1) {
              return Padding(
                padding: EdgeInsets.only(bottom: 80),
                child: _buildQuestionCard(questionData, index),
              );
            } else {
              return _buildQuestionCard(questionData, index);
            }
          },
        ),
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
      ),
    );
  }

  Padding _buildQuestionCard(PersonalityQuestionModel questionData, int index) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: PersonalityCardWidget(
        question: questionData.question,
        initialValue: ((questionData.scaleAnswers ?? 1).toDouble() - 1) / 4,
        onChanged: (value) {
          _controller.updatePersonalityAnswer(index, value ?? 0);
        },
      ),
    );
  }
}
