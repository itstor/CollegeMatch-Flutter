import 'package:college_match/data/model/lifestyle_question_model.dart';
import 'package:college_match/screens/global_widgets/dot_loading.dart';
import 'package:college_match/screens/personal_data_page/controllers/personal_data_page_controller.dart';
import 'package:college_match/screens/personal_data_page/local_widgets/mark_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

class LifestyleSection extends StatelessWidget {
  final _controller = Get.find<PersonalDataPageController>();
  LifestyleSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _controller.lifestyleData.obx(
      (data) => ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        controller: _controller.lifeStyleScrollController,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: data!.length,
        itemBuilder: (context, index) {
          final lifestyleQuestion = data[index];

          if (index == 0) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 95),
                Text(
                  "Mark your answers based on your own lifestyle",
                  style: Get.textTheme.subtitle1!.copyWith(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 32),
                _buildQuestionCard(lifestyleQuestion, index),
              ],
            );
          } else if (index == data.length - 1) {
            return Padding(
              padding: EdgeInsets.only(bottom: 80),
              child: _buildQuestionCard(lifestyleQuestion, index),
            );
          } else {
            return _buildQuestionCard(lifestyleQuestion, index);
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
    );
  }

  Widget _buildQuestionCard(
      LifestyleQuestionModel lifestyleQuestion, int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: MarkCardWidget(
        text: lifestyleQuestion,
        initialValue: lifestyleQuestion.answer ?? false,
        validator: (value) => null,
        onSaved: (value) {},
        onTap: (value) {
          _controller.updateLifestyleAnswer(index, value);
        },
      ),
    );
  }
}
