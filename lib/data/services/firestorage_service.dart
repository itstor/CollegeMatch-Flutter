import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class FirestorageService {
  Future<String?> uploadProfileImage(String uid, File imagefile) async {
    List<String> splitPath = imagefile.path.split('.');
    String filetype = splitPath[splitPath.length - 1];
    String filename = uid + '.' + filetype;

    try {
      await firebase_storage.FirebaseStorage.instance
          .ref()
          .child('images')
          .child('profile-picture')
          .child(filename)
          .putFile(imagefile);

      String downloadURL = await firebase_storage.FirebaseStorage.instance
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
}
