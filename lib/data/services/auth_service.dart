import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_match/core/values/firebase_constants.dart';
import 'package:college_match/data/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<UserCredential?> signInWithGoogle() async {
    try {
      GoogleSignInAccount? googleSignInAccount = await googleSign.signIn();

      if (googleSignInAccount != null) {
        GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        UserCredential authResult = await auth
            .signInWithCredential(credential)
            .catchError((onErr) => print(onErr));

        if (authResult.additionalUserInfo!.isNewUser) {
          await users.doc(auth.currentUser?.uid).set(UserModel(
                  uid: auth.currentUser!.uid,
                  answerId: '',
                  photoUrl: auth.currentUser!.photoURL!,
                  email: auth.currentUser!.email!,
                  username: '',
                  phone: '',
                  name: '',
                  major: '',
                  questionaireFilled: false,
                  registerFinished: false,
                  alreadyConnect: [],
                  emailVerified: false)
              .toMap());
        }

        return authResult;
      }
    } on FirebaseAuthException {
      rethrow;
    }

    return null;
  }

  Future<UserCredential?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential authResult = await auth.signInWithEmailAndPassword(
          email: email, password: password);

      return authResult;
    } on FirebaseAuthException {
      rethrow;
    }
  }

  Future<UserCredential?> registerWithEmailAndPassword(
      String email, password) async {
    try {
      UserCredential authResult = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      await users.doc(auth.currentUser?.uid).set(UserModel(
              uid: auth.currentUser!.uid,
              answerId: '',
              photoUrl: '',
              email: email,
              username: '',
              phone: '',
              name: '',
              major: '',
              questionaireFilled: false,
              registerFinished: false,
              alreadyConnect: [],
              emailVerified: false)
          .toMap());

      return authResult;
    } catch (firebaseAuthException) {
      rethrow;
    }
  }

  void signOut() async {
    await auth.signOut();
  }

  Future<bool> isUserFinishedRegister(String uid) async {
    try {
      DocumentSnapshot user = await users.doc(uid).get();

      return user.get('registerFinished');
    } catch (firebaseAuthException) {
      rethrow;
    }
  }

  Future<bool> isUserFilledQuestionaire(String uid) async {
    try {
      DocumentSnapshot user = await users.doc(uid).get();

      return user.get('questionaireFilled');
    } catch (firebaseAuthException) {
      rethrow;
    }
  }

  Future<bool> isUserPhoneNumberVerified(String uid) async {
    try {
      DocumentSnapshot user = await users.doc(uid).get();

      return user.get('phoneNumberVerified');
    } catch (firebaseAuthException) {
      rethrow;
    }
  }

  Future verifyPhoneNumber(
      {required String phoneNumber,
      required void Function(PhoneAuthCredential) verificationCompleted,
      required void Function(FirebaseAuthException) verificationFailed,
      required void Function(String, int?) codeSent,
      required void Function(String) codeAutoRetrievalTimeout}) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }
}
