import 'package:college_match/data/services/question_service.dart';
import 'package:college_match/data/services/user_service.dart';
import 'package:college_match/screens/personal_data_page/controllers/interest_data.dart';
import 'package:college_match/screens/personal_data_page/controllers/lifestyleq_data.dart';
import 'package:college_match/screens/personal_data_page/controllers/majors_data.dart';
import 'package:college_match/screens/personal_data_page/controllers/personal_data_page_controller.dart';
import 'package:college_match/screens/personal_data_page/controllers/personalityq_data.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

class PersonalDataBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserService>(() => UserService());
    Get.lazyPut<QuestionService>(() => QuestionService());
    Get.lazyPut<PersonalityQData>(() => PersonalityQData());
    Get.lazyPut<LifestyleQData>(() => LifestyleQData());
    Get.lazyPut<MajorsData>(() => MajorsData());
    Get.lazyPut<InterestData>(() => InterestData());
    Get.lazyPut<PersonalDataPageController>(() => PersonalDataPageController());
  }
}
