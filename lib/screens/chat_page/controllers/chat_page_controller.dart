import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_match/core/values/colors.dart';
import 'package:college_match/core/values/firebase_constants.dart';
import 'package:college_match/data/model/message_chat_model.dart';
import 'package:college_match/data/model/user_model.dart';
import 'package:college_match/data/services/chat_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ChatPageController extends GetxController {
  final chatService = Get.find<ChatService>();

  UserModel peerUser = Get.arguments['peerUser'] as UserModel;
  Rx<bool> isRevealed = RxBool(Get.arguments['isRevealed']);
  final String currentUserId = auth.currentUser!.uid;

  List<QueryDocumentSnapshot> listMessage = [];
  Rx<int> limit = 20.obs;
  int limitIncrement = 20;
  String groupChatId = Get.arguments['groupChatId'];

  File? imageFile;
  bool isLoading = false;
  bool isShowSticker = false;

  final TextEditingController messageTextController = TextEditingController();
  late ScrollController listScrollController;
  final FocusNode focusNode = FocusNode();

  @override
  void onInit() {
    super.onInit();

    listScrollController = ScrollController();

    chatService.getGroupInfoStream(groupChatId).listen((snapshot) {
      if (snapshot.data() != null) {
        isRevealed.value = snapshot.data()!['revealed'];
      }
    });

    print(groupChatId);
    listScrollController.addListener(() {
      if (listScrollController.offset >=
              listScrollController.position.maxScrollExtent &&
          !listScrollController.position.outOfRange &&
          limit <= listMessage.length) {
        limit.value += limitIncrement;
      }
    });
  }

  void sendMessage(MessageType type, String content) {
    if (content.trim().isNotEmpty) {
      print('sending');
      chatService.sendMessage(content, type, groupChatId, currentUserId);
      messageTextController.clear();
      listScrollController.animateTo(0,
          duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    }
  }

  Future getImage() async {
    XFile? imageFile;

    imageFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (imageFile != null) {
      File file = File(imageFile.path);
      String? fileUrl = await chatService.uploadImage(groupChatId, file);
      if (fileUrl != null) {
        sendMessage(MessageType.image, fileUrl);
      }
    }
  }

  Future showMoreMenu(BuildContext context) async {
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(Get.width, 50, 0, 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 3,
      items: [
        PopupMenuItem(
          onTap: () => sendMessage(MessageType.revealReq, 'ReqRev'),
          child: Row(
            children: [
              Container(
                height: 32,
                width: 32,
                decoration: BoxDecoration(
                  color: AppColor.kPrimaryPurple[100],
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  IconlyLight.show,
                  color: Colors.white,
                  size: 16,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Ask to reveal',
                style: Get.textTheme.bodyText2!.copyWith(
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
