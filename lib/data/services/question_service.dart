import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_match/data/model/interest_model.dart';
import 'package:college_match/data/model/lifestyle_question_model.dart';
import 'package:college_match/data/model/major_model.dart';
import 'package:college_match/data/model/personality_question_model.dart';

class QuestionService {
  Future<List<MajorModel>> getAllMajor() async {
    final List<MajorModel> _majorList = [];

    try {
      await FirebaseFirestore.instance.collection('majors').get().then(
        (QuerySnapshot snapshot) {
          for (var doc in snapshot.docs) {
            _majorList.add(MajorModel.fromDocument(doc));
          }
        },
      );
    } catch (e) {
      print(e);
    }
    return _majorList;
  }

  Future<List<LifestyleQuestionModel>> getAllLifestyleQuestion() async {
    final List<LifestyleQuestionModel> _lifestyleQuestionList = [];

    try {
      await FirebaseFirestore.instance
          .collection('lifestyleQuestions')
          .orderBy("index", descending: false)
          .get()
          .then(
        (QuerySnapshot snapshot) {
          for (var doc in snapshot.docs) {
            _lifestyleQuestionList
                .add(LifestyleQuestionModel.fromDocument(doc));
          }
        },
      );
    } catch (e) {
      print(e);
    }
    return _lifestyleQuestionList;
  }

  Future<List<PersonalityQuestionModel>> getAllPersonalityQuestion() async {
    final List<PersonalityQuestionModel> _personalityQuestionList = [];

    try {
      await FirebaseFirestore.instance
          .collection('testmbti')
          .orderBy("index", descending: false)
          .get()
          .then(
        (QuerySnapshot snapshot) {
          for (var doc in snapshot.docs) {
            _personalityQuestionList
                .add(PersonalityQuestionModel.fromDocument(doc));
          }
        },
      );
    } catch (e) {
      print(e);
    }
    return _personalityQuestionList;
  }

  Future<List<InterestModel>> getAllInterest() async {
    final List<InterestModel> _interestList = [];

    try {
      await FirebaseFirestore.instance.collection('interests').get().then(
        (QuerySnapshot snapshot) {
          for (var doc in snapshot.docs) {
            _interestList.add(InterestModel.fromDocument(doc));
          }
        },
      );
    } catch (e) {
      print(e);
    }
    return _interestList;
  }
}
