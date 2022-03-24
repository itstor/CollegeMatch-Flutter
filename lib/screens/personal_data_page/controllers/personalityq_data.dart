import 'package:college_match/data/model/personality_question_model.dart';
import 'package:college_match/data/services/question_service.dart';
import 'package:get/get.dart';

class PersonalityQData extends GetxController
    with StateMixin<List<PersonalityQuestionModel>> {
  @override
  void onInit() async {
    super.onInit();
    // Future.delayed(Duration(seconds: 2), () {
    Get.find<QuestionService>().getAllPersonalityQuestion().then(
          (value) => change(
            value,
            status: RxStatus.success(),
          ),
        );
    // });
  }
}
