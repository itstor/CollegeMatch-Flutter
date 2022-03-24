import 'package:college_match/data/model/major_model.dart';
import 'package:college_match/data/services/question_service.dart';
import 'package:drop_down_list/drop_down_list.dart';
import 'package:get/get.dart';

class MajorsData extends GetxController with StateMixin<List<MajorModel>> {
  @override
  void onInit() {
    super.onInit();
    Get.find<QuestionService>().getAllMajor().then(
          (value) => change(
            value,
            status: RxStatus.success(),
          ),
        );
  }
}
