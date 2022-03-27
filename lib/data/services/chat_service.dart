import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_match/core/utils.dart';
import 'package:college_match/core/values/firebase_constants.dart';
import 'package:college_match/data/model/message_chat_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ChatService {
  Stream<QuerySnapshot> getChatStream(String groupChatId, int limit) {
    return firebaseFirestore
        .collection('groupMessages')
        .doc(groupChatId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .limit(limit)
        .snapshots();
  }

  void sendMessage(String content, MessageType type, String groupChatId,
      String currentUserId) {
    DocumentReference documentReference = firebaseFirestore
        .collection('groupMessages')
        .doc(groupChatId)
        .collection('messages')
        .doc(DateTime.now().millisecondsSinceEpoch.toString());

    int timestamp = DateTime.now().millisecondsSinceEpoch.toInt();

    MessageChatModel messageChat = MessageChatModel(
      idFrom: currentUserId,
      timestamp: timestamp,
      content: content,
      type: type,
    );

    firebaseFirestore.runTransaction((transaction) async {
      transaction.set(
        documentReference,
        messageChat.toMap(),
      );
    }).then((_) async {
      await updateLastMessage(
          groupChatId, content, type, currentUserId, timestamp);
      // print('Message sent');
    });
  }

  Future updateLastMessage(String groupChatId, String content, MessageType type,
      String currentUserId, int timestamp) async {
    DocumentReference documentReference =
        firebaseFirestore.collection('groupMessages').doc(groupChatId);

    await documentReference.update({
      'lastMessage': content,
      'lastMessageType': type.index,
      'lastMessageTimestamp': timestamp,
      'lastMessageFrom': currentUserId,
    });
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getGroupInfoStream(
      String groupChatId) {
    return firebaseFirestore
        .collection('groupMessages')
        .doc(groupChatId)
        .snapshots();
  }

  Stream<QuerySnapshot> getMainChatStream(
      String currentUserId, int limit, bool? revealed) {
    if (revealed == null) {
      return firebaseFirestore
          .collection('groupMessages')
          .where('of', arrayContains: currentUserId)
          .orderBy('lastMessageTimestamp', descending: true)
          .snapshots();
    } else if (revealed) {
      return firebaseFirestore
          .collection('groupMessages')
          .where('of', arrayContains: currentUserId)
          .where('revealed', isEqualTo: true)
          .orderBy('lastMessageTimestamp', descending: true)
          .snapshots();
    } else {
      return firebaseFirestore
          .collection('groupMessages')
          .where('of', arrayContains: currentUserId)
          .where('revealed', isEqualTo: false)
          .orderBy('lastMessageTimestamp', descending: true)
          .snapshots();
    }
  }

  Future acceptRevealRequest(String groupChatId) async {
    await firebaseFirestore
        .collection('groupMessages')
        .doc(groupChatId)
        .update({'revealed': true});
  }

  Future<String> connectUser(String userA, String userB) async {
    String groupChatId = '';
    if (userA.compareTo(userB) > 0) {
      groupChatId = '$userA-$userB';
    } else {
      groupChatId = '$userB-$userA';
    }

    DocumentReference documentReference =
        firebaseFirestore.collection('groupMessages').doc(groupChatId);

    await documentReference.set({
      'revealed': false,
      'of': [userA, userB],
      'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
      'lastmessage': '',
    });

    return groupChatId;
  }

  Future<String?> uploadImage(String groupId, File imagefile) async {
    List<String> splitPath = imagefile.path.split('.');
    String filetype = splitPath[splitPath.length - 1];
    String filename = Utils.generateRandomString(10) +
        DateTime.now().millisecondsSinceEpoch.toString() +
        '.' +
        filetype;

    try {
      await firebaseStorage
          .ref()
          .child('images')
          .child(groupId)
          .child('images')
          .child(filetype)
          .putFile(imagefile);

      String downloadURL = await firebaseStorage
          .ref()
          .child('images')
          .child(groupId)
          .child('images')
          .child(filetype)
          .getDownloadURL();

      return downloadURL;
    } on FirebaseException catch (e) {
      print(e);
    }

    return null;
  }
}
