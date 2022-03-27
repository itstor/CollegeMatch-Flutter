import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_match/core/values/api_contants.dart';
import 'package:college_match/core/values/api_key.dart';
import 'package:college_match/core/values/firebase_constants.dart';
import 'package:college_match/data/model/user_model.dart';
import 'package:dio/dio.dart';

class UserService {
  final Dio _dio = Dio();
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future registerSecondStep({
    required uid,
    required String username,
    required String phone,
  }) async {
    return await users.doc(uid).update({
      'username': username,
      'phone': phone,
      'registerFinished': true,
      'mbti': 'ISTP',
    });
  }

  Future registerThirdStep({
    required uid,
    required String name,
    required DateTime birthday,
    required String major,
    required String gender,
    required List<String> interests,
    required String photoUrl,
    required String mbti,
  }) async {
    return await users.doc(uid).update({
      'name': name,
      'birthday': birthday,
      'major': major,
      'gender': gender,
      'interests': interests,
      'photoUrl': photoUrl,
      'mbti': mbti,
      'questionaireFilled': true,
    });
  }

  Future<bool> checkUsernameAvailability(String username) async {
    QuerySnapshot snapshot =
        await users.where('username', isEqualTo: username).get();
    return snapshot.docs.isEmpty;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserAnswers(
      String uid) async {
    return await FirebaseFirestore.instance
        .collection('userAnswers')
        .doc(uid)
        .get();
  }

  Future<UserModel> getUser(String uid) async {
    var user = await users.doc(uid).get();

    return UserModel.fromDocument(user);
  }

  Future addUserAnswers({
    required String uid,
    required Map<String, dynamic> answers,
  }) async {
    return await FirebaseFirestore.instance
        .collection('userAnswers')
        .doc(uid)
        .set(answers..['updatedAt'] = FieldValue.serverTimestamp());
  }

  Future addUserInterest({
    required String uid,
    required List<String> interests,
  }) async {
    return await users.doc(uid).update({
      'interests': interests,
    });
  }

  Future<String> calculateUserMBTI(String uid) async {
    _dio.options.headers['X-Api-Key'] = apiKey;
    var response = await _dio
        .get(ApiConstants.apiUrl + ApiConstants.mbtiEdp, queryParameters: {
      'id': uid,
    });

    return response.data['mbti'];
  }

  Future<String?> uploadProfileImage(String uid, File imagefile) async {
    List<String> splitPath = imagefile.path.split('.');
    String filetype = splitPath[splitPath.length - 1];
    String filename = uid + '.' + filetype;

    try {
      await firebaseStorage
          .ref()
          .child('images')
          .child('profile-picture')
          .child(filename)
          .putFile(imagefile);

      String downloadURL = await firebaseStorage
          .ref()
          .child('images')
          .child('profile-picture')
          .child(filename)
          .getDownloadURL();

      return downloadURL;
    } on FirebaseException catch (e) {
      print(e);
    }

    return null;
  }

  Future<Map<String, dynamic>> searchPartner(String uid) async {
    _dio.options.headers['X-Api-Key'] = apiKey;
    _dio.options.followRedirects = false;
    _dio.options.validateStatus = (status) {
      return true;
    };

    var response = await _dio
        .get(ApiConstants.apiUrl + ApiConstants.partnerEdp, queryParameters: {
      'id': uid,
    });
    print(response.data);
    return response.data;
  }
}
