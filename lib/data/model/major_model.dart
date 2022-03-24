import 'package:cloud_firestore/cloud_firestore.dart';

class MajorModel {
  String id;
  String major;

  MajorModel({
    required this.id,
    required this.major,
  });

  factory MajorModel.fromDocument(DocumentSnapshot doc) {
    return MajorModel(
      id: doc.id,
      major: doc['major'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'major': major,
    };
  }
}
