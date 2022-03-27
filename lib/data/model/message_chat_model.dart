import 'package:cloud_firestore/cloud_firestore.dart';

enum MessageType {
  text,
  image,
  revealReq,
}

class MessageChatModel {
  String idFrom;
  int timestamp;
  String content;
  MessageType type;

  MessageChatModel({
    required this.idFrom,
    required this.timestamp,
    required this.content,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return {
      'idFrom': idFrom,
      'timestamp': timestamp,
      'content': content,
      'type': type.index,
    };
  }

  factory MessageChatModel.fromDocument(DocumentSnapshot doc) {
    return MessageChatModel(
      idFrom: doc.get('idFrom'),
      timestamp: doc.get('timestamp'),
      content: doc.get('content'),
      type: MessageType.values[doc.get('type')],
    );
  }
}
