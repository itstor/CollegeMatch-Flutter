import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_match/core/utils.dart';
import 'package:college_match/core/values/colors.dart';
import 'package:college_match/data/model/message_chat_model.dart';
import 'package:college_match/data/model/user_model.dart';
import 'package:college_match/screens/chat_page/controllers/chat_page_controller.dart';
import 'package:college_match/screens/chat_page/local_widgets/left_chat_widget.dart';
import 'package:college_match/screens/chat_page/local_widgets/message_text_field.dart';
import 'package:college_match/screens/chat_page/local_widgets/request_parnet_reveal_widget.dart';
import 'package:college_match/screens/chat_page/local_widgets/response_partner_reveal_widget.dart';
import 'package:college_match/screens/chat_page/local_widgets/right_chat_widget.dart';
import 'package:college_match/screens/global_widgets/dot_loading.dart';
import 'package:college_match/screens/global_widgets/glow_button_widget.dart';
import 'package:college_match/screens/global_widgets/revealed_text_widget.dart';
import 'package:college_match/screens/global_widgets/rounded_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';

class ChatPage extends StatelessWidget {
  static String routeName = '/chat-page';

  final _controller = Get.find<ChatPageController>();

  ChatPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFBFAFF),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Obx(
          () => Container(
            padding: EdgeInsets.only(
              left: 24,
              right: 24,
              bottom: 16,
              top: MediaQuery.of(context).padding.top + 16,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF8F8F8F).withOpacity(0.15),
                  offset: const Offset(0, 4),
                  blurRadius: 27,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: Utils.imageSelector(_controller.isRevealed.value,
                          _controller.peerUser.photoUrl!, 'Male'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RevealedTextWidget(
                        isRevealed: _controller.isRevealed.value,
                        unReveal: _controller.peerUser.major!,
                        reveal: _controller.peerUser.name!,
                        style: Get.textTheme.subtitle1!),
                    // Text(
                    //   'Online',
                    //   style: Get.textTheme.caption,
                    // ),
                  ],
                ),
                // Icon(Icons.more_vert),
                Expanded(child: Container()),
                IconButton(
                  icon: Icon(Icons.more_vert),
                  onPressed: () => _controller.showMoreMenu(context),
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF8F8F8F).withOpacity(0.15),
              offset: const Offset(0, -4),
              blurRadius: 27,
            ),
          ],
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: 100,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Color(0xFFF4F4F4), shape: BoxShape.circle),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                  icon: Icon(IconlyLight.image2),
                  color: Color(0xFFA6A6A6),
                  onPressed: () => _controller.getImage(),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: MessageTextFieldWidget(
                  controller: _controller.messageTextController,
                  onSendPressed: () {
                    _controller.sendMessage(MessageType.text,
                        _controller.messageTextController.text);
                  },
                ),
              )
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 60),
        child: Obx(() => buildListMessage(_controller.isRevealed.value)),
      ),
    );
  }

  Widget buildListMessage(bool revealed) {
    return _controller.groupChatId.isNotEmpty
        ? StreamBuilder<QuerySnapshot>(
            stream: _controller.chatService.getChatStream(
                _controller.groupChatId, _controller.limit.value),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                _controller.listMessage = snapshot.data!.docs;
                if (_controller.listMessage.isNotEmpty) {
                  return ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    separatorBuilder: (_, __) => SizedBox(height: 24),
                    padding: const EdgeInsets.all(24),
                    itemBuilder: (context, index) => buildItem(
                        context, snapshot.data?.docs[index], revealed),
                    itemCount: snapshot.data?.docs.length ?? 0,
                    reverse: true,
                    controller: _controller.listScrollController,
                  );
                } else {
                  return Container();
                }
              } else {
                return const Center(child: DotLoading());
              }
            },
          )
        : const Center(child: DotLoading());
  }

  Widget buildItem(
      BuildContext context, DocumentSnapshot? document, bool revealed) {
    if (document != null) {
      Widget content;
      MessageChatModel chatData = MessageChatModel.fromDocument(document);
      final bool isAm = chatData.idFrom == _controller.currentUserId;

      if (chatData.type != MessageType.revealReq) {
        if (chatData.type == MessageType.text) {
          content = Text(chatData.content);
        } else if (chatData.type == MessageType.image) {
          content = Image(image: CachedNetworkImageProvider(chatData.content));
        } else {
          content = Text('This message type is not supported');
        }

        if (isAm) {
          return RightChatWidget(
            content: content,
            time: Utils.formatHour(
                DateTime.fromMillisecondsSinceEpoch(chatData.timestamp)),
          );
        } else {
          return LeftChatWidget(
              profileImage: Utils.imageSelector(revealed,
                  _controller.peerUser.photoUrl!, _controller.peerUser.gender!),
              content: content,
              time: Utils.formatHour(
                  DateTime.fromMillisecondsSinceEpoch(chatData.timestamp)));
        }
      } else {
        if (isAm) {
          return RequestPartnerRevealWidget();
        } else {
          return ResponsePartnerRevealWidget(
              onTap: () => _controller.chatService
                  .acceptRevealRequest(_controller.groupChatId));
        }
      }
    }
    return Container();
  }
}
