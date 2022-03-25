import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
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
  }) async {
    return await users.doc(uid).update({
      'name': name,
      'birthday': birthday,
      'major': major,
      'gender': gender,
      'interests': interests,
      'photoUrl': photoUrl,
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

  Future<DocumentSnapshot<Object?>> getUser(String uid) async {
    return await users.doc(uid).get();
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

  // Future calculateUserMBTI(String uid){

  // }
}
