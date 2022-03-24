import 'package:cloud_firestore/cloud_firestore.dart';

class UserAnswersModel {
  UserAnswersModel({
    this.id,
    this.userId,
    this.lifestyleAnswer,
    this.personalityAnswer,
  });

  String? id;
  String? userId;
  List<bool>? lifestyleAnswer;
  List<int>? personalityAnswer;

  factory UserAnswersModel.fromDocument(DocumentSnapshot doc) {
    return UserAnswersModel(
      id: doc.id,
      userId: doc.get('userId'),
      lifestyleAnswer: doc.get('lifestyleAnswer'),
      personalityAnswer: doc.get('personalityAnswer'),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'lifestyleAnswer': lifestyleAnswer,
      'personalityAnswer': personalityAnswer,
    };
  }
}
