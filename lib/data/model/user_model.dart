import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  String? answerId;
  String? photoUrl;
  String? email;
  String? username;
  String? phone;
  String? name;
  String? major;
  String? gender;
  String? mbti;
  bool? questionaireFilled;
  bool? registerFinished;
  bool? emailVerified;
  List<String>? alreadyConnect;

  UserModel({
    this.uid,
    this.answerId,
    this.photoUrl,
    this.email,
    this.username,
    this.phone,
    this.name,
    this.major,
    this.questionaireFilled,
    this.registerFinished,
    this.alreadyConnect,
    this.emailVerified,
    this.mbti,
    this.gender,
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
      'mbti': mbti,
      'gender': gender,
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
      mbti: doc.get('mbti'),
      gender: doc.get('gender'),
      questionaireFilled: doc.get('questionaireFilled'),
      registerFinished: doc.get('registerFinished'),
      alreadyConnect: doc.get('alreadyConnect'),
      emailVerified: doc.get('emailVerified'),
    );
  }
}
