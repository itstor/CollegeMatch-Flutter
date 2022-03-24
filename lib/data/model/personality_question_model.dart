import 'package:cloud_firestore/cloud_firestore.dart';

class PersonalityQuestionModel {
  final String id;
  final String question;
  int? scaleAnswers;

  PersonalityQuestionModel({
    required this.id,
    required this.question,
    this.scaleAnswers,
  });

  factory PersonalityQuestionModel.fromDocument(DocumentSnapshot doc) {
    return PersonalityQuestionModel(
      id: doc.id,
      question: doc['question'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'question': question,
      'scaleAnswers': scaleAnswers,
    };
  }
}
