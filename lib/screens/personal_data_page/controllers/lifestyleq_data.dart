import 'package:college_match/data/model/lifestyle_question_model.dart';
import 'package:college_match/data/model/personality_question_model.dart';
import 'package:college_match/data/services/question_service.dart';
import 'package:get/get.dart';

class LifestyleQData extends GetxController
    with StateMixin<List<LifestyleQuestionModel>> {
  @override
  void onInit() {
    super.onInit();
    Get.find<QuestionService>().getAllLifestyleQuestion().then(
          (value) => change(
            value,
            status: RxStatus.success(),
          ),
        );
  }
}
