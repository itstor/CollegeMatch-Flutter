import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future registerSecondStep(
      {required uid, required String username, required String phone}) async {
    users.doc(uid).set({
      'username': username,
      'phone': phone,
      'registerFinished': true,
    }, SetOptions(merge: true));
  }

  Future<bool> checkUsernameAvailability(String username) async {
    QuerySnapshot snapshot =
        await users.where('username', isEqualTo: username).get();
    return snapshot.docs.isEmpty;
  }
}
