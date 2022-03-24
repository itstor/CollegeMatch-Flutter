import 'package:cloud_firestore/cloud_firestore.dart';

class InterestModel {
  String id;
  String interest;

  InterestModel({
    required this.id,
    required this.interest,
  });

  factory InterestModel.fromDocument(DocumentSnapshot doc) {
    return InterestModel(
      id: doc.id,
      interest: doc['interest'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'interest': interest,
    };
  }
}
