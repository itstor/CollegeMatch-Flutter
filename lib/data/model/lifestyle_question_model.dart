import 'package:cloud_firestore/cloud_firestore.dart';

class LifestyleQuestionModel {
  final String id;
  final String question;
  bool? answer;

  LifestyleQuestionModel({
    required this.id,
    required this.question,
    this.answer,
  });

  factory LifestyleQuestionModel.fromDocument(DocumentSnapshot doc) {
    return LifestyleQuestionModel(
      id: doc.id,
      question: doc['question'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'question': question,
      'scaleAnswers': answer,
    };
  }
}
