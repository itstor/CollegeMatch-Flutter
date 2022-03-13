import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String uid;
  String answerId;
  String photoUrl;
  String email;
  String username;
  String phone;
  String name;
  String major;
  bool questionaireFilled;
  bool registerFinished;
  bool emailVerified;
  List<String> alreadyConnect;

  UserModel({
    required this.uid,
    required this.answerId,
    required this.photoUrl,
    required this.email,
    required this.username,
    required this.phone,
    required this.name,
    required this.major,
    required this.questionaireFilled,
    required this.registerFinished,
    required this.alreadyConnect,
    required this.emailVerified,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'answerId': answerId,
      'photoUrl': photoUrl,
      'email': email,
      'username': username,
      'phone': phone,
      'name': name,
      'major': major,
      'questionaireFilled': questionaireFilled,
      'registerFinished': registerFinished,
      'alreadyConnect': alreadyConnect,
      'emailVerified': emailVerified,
    };
  }

  factory UserModel.fromDocument(DocumentSnapshot doc) {
    return UserModel(
      uid: doc.get('uid'),
      answerId: doc.get('answerId'),
      photoUrl: doc.get('photoUrl'),
      email: doc.get('email'),
      username: doc.get('username'),
      phone: doc.get('phone'),
      name: doc.get('name'),
      major: doc.get('major'),
      questionaireFilled: doc.get('questionaireFilled'),
      registerFinished: doc.get('registerFinished'),
      alreadyConnect: doc.get('alreadyConnect'),
      emailVerified: doc.get('emailVerified'),
    );
  }
}
