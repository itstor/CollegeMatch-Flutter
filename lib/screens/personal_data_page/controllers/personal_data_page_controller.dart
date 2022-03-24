import 'dart:io';

import 'package:college_match/core/values/colors.dart';
import 'package:college_match/core/values/firebase_constants.dart';
import 'package:college_match/data/model/major_model.dart';
import 'package:college_match/data/model/user_answers_model.dart';
import 'package:college_match/data/services/user_service.dart';
import 'package:college_match/screens/global_widgets/rounded_text_field_widget.dart';
import 'package:college_match/screens/personal_data_page/controllers/interest_data.dart';
import 'package:college_match/screens/personal_data_page/controllers/lifestyleq_data.dart';
import 'package:college_match/screens/personal_data_page/controllers/majors_data.dart';
import 'package:college_match/screens/personal_data_page/controllers/personalityq_data.dart';
import 'package:college_match/screens/personal_data_page/local_widgets/major_bottom_sheet_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'package:drop_down_list/drop_down_list.dart';

class PersonalDataPageController extends GetxController {
  final _userService = Get.find<UserService>();
  late final personalityData = Get.find<PersonalityQData>();
  late final majorData = Get.find<MajorsData>();
  late final lifestyleData = Get.find<LifestyleQData>();
  late final interestData = Get.find<InterestData>();
  final _imagePicker = ImagePicker();

  String _name = '';
  String _major = '';
  DateTime? _birthday;
  Rx<File?> profilePicture = Rx<File?>(null);
  Rx<String> gender = ''.obs;
  late LinkedScrollControllerGroup scrollController;
  late ScrollController personalityScrollController;
  late ScrollController lifeStyleScrollController;
  late TextEditingController nameTextController;
  late TextEditingController birthdayTextController;
  late TextEditingController majorTextController;
  late TextEditingController majorSearchTextController;
  Rx<double> backButtonOpacity = 1.0.obs;
  Rx<bool> isBackButtonVisible = true.obs;
  Rx<int> stepIndex = 0.obs;
  Rx<bool> isScrolling = false.obs;
  List<String> interestList = [];

  String get name => _name;
  DateTime? get birthday => _birthday;

  @override
  void onInit() {
    super.onInit();
    scrollController = LinkedScrollControllerGroup();
    nameTextController = TextEditingController();
    birthdayTextController = TextEditingController();
    majorTextController = TextEditingController();
    majorSearchTextController = TextEditingController();
    personalityScrollController = scrollController.addAndGet();
    lifeStyleScrollController = scrollController.addAndGet();

    scrollController.addOffsetChangedListener(() {
      // print(scrollController.offset);
      if (scrollController.offset < 50) {
        if (scrollController.offset < 0) {
          backButtonOpacity.value = 1.0;
          return;
        }
        backButtonOpacity.value = 1 - (scrollController.offset / 50);
        isBackButtonVisible.value = true;
      } else {
        backButtonOpacity.value = 0;
        isBackButtonVisible.value = false;
      }

      // if (scrollController.offset > 0) {
      //   isScrolling.value = true;
      // }
    });
  }

  @override
  void dispose() {
    personalityScrollController.dispose();
    lifeStyleScrollController.dispose();
    nameTextController.dispose();
    birthdayTextController.dispose();
    majorTextController.dispose();
    super.dispose();
  }

  set name(String value) {
    _name = value;
  }

  Future<bool> goBack() {
    if (stepIndex.value > 0) {
      stepIndex.value--;
      scrollController.resetScroll();

      return Future.value(false);
    }

    return Future.value(true);
  }

  void goNext() {
    if (stepIndex.value < 7) {
      switch (stepIndex.value) {
        case 0:
          {
            if (nameTextController.text.isEmpty) {
              Fluttertoast.showToast(
                msg: 'Please enter your name',
                gravity: ToastGravity.BOTTOM,
                backgroundColor: AppColor.kAccentColor['red'],
              );
              return;
            } else if (nameTextController.text.length > 20) {
              Fluttertoast.showToast(
                msg: 'Name should be less than 20 characters',
                gravity: ToastGravity.BOTTOM,
                backgroundColor: AppColor.kAccentColor['red'],
              );
              return;
            } else {
              _name = nameTextController.text;
              Get.focusScope?.unfocus();
            }
          }
          break;
        case 1:
          {
            if (gender.value == '') {
              Fluttertoast.showToast(
                msg: 'Please choose your gender',
                gravity: ToastGravity.BOTTOM,
                backgroundColor: AppColor.kAccentColor['red'],
              );
              return;
            }
          }
          break;
        case 2:
          {
            if (_birthday == null) {
              Fluttertoast.showToast(
                msg: 'Please enter your birthday',
                gravity: ToastGravity.BOTTOM,
                backgroundColor: AppColor.kAccentColor['red'],
              );
              return;
            } else if (_birthday!.isAfter(DateTime.now())) {
              Fluttertoast.showToast(
                msg: 'Birthday should be before today',
                gravity: ToastGravity.BOTTOM,
                backgroundColor: AppColor.kAccentColor['red'],
              );
              return;
            }
          }
          break;
        case 3:
          {
            if (majorTextController.text.isEmpty) {
              Fluttertoast.showToast(
                msg: 'Please enter your major',
                gravity: ToastGravity.BOTTOM,
                backgroundColor: AppColor.kAccentColor['red'],
              );
              return;
            } else {
              _major = majorTextController.text;
              Get.focusScope?.unfocus();
            }
          }
          break;
        default:
      }
      stepIndex.value++;
      scrollController.resetScroll();
    }
  }

  Future getImage() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profilePicture.value = File(pickedFile.path);
    }
  }

  Future<DateTime?> setBirthday(BuildContext context) async {
    print('bruhh');

    _birthday = await showRoundedDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2100),
        borderRadius: 16,
        height: 280,
        theme: ThemeData(
          primarySwatch: Colors.pink,
        ));

    if (_birthday != null) {
      birthdayTextController.text =
          "${_birthday!.day}-${_birthday!.month}-${_birthday!.year}";
    }

    return _birthday;
  }

  void showMajorBottomSheet(context, List<MajorModel>? data) {
    if (data == null) {
      Fluttertoast.showToast(
        msg: 'No data found',
        gravity: ToastGravity.BOTTOM,
        backgroundColor: AppColor.kAccentColor['red'],
      );
      return;
    }

    MajorBottomSheetWidget.majorBottomSheetWidget(context,
        majorTextController: majorTextController,
        data: data,
        searchTextController: majorSearchTextController);
  }

  void updatePersonalityAnswer(int index, double value) {
    personalityData.state![index].scaleAnswers = value * 10 ~/ 2;
    print(value);
    //TODO FIX THIS
    // print(personalityData.state![index].scaleAnswers);
  }

  void updateLifestyleAnswer(int index, bool value) {
    lifestyleData.state![index].answer = value;
  }

  void _submitData() {
    List<int> personalityAnswers = [];
    List<bool> lifestyleAnswers = [];

    personalityData.state!
        .map((e) => personalityAnswers.add(e.scaleAnswers ?? 0));
    lifestyleData.state!.map((e) => lifestyleAnswers.add(e.answer ?? false));

    _userService.putUserAnswers(
        uid: auth.currentUser!.uid,
        answers: UserAnswersModel(
          userId: auth.currentUser!.uid,
          lifestyleAnswer: lifestyleAnswers,
          personalityAnswer: personalityAnswers,
        ).toMap());
  }
}
