import 'package:college_match/core/utils.dart';
import 'package:college_match/data/model/message_chat_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';

class ChatItemWidget extends StatelessWidget {
  final Image profileImage;
  final String name;
  final String lastMessage;
  final DateTime time;
  final MessageType lastMessageType;
  final VoidCallback onPressed;

  const ChatItemWidget({
    Key? key,
    required this.profileImage,
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.onPressed,
    required this.lastMessageType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: SizedBox(
        height: 44,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 44,
              width: 44,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: profileImage.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: Get.textTheme.bodyText1,
                  ),
                  _buildLastMessage(),
                ],
              ),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    Utils.formatHour(time),
                    style: Get.textTheme.caption!.copyWith(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Text(
                    Utils.determineTime(time),
                    style: Get.textTheme.caption!.copyWith(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLastMessage() {
    if (lastMessageType == MessageType.text) {
      return Text(
        lastMessage,
        style: Get.textTheme.caption!.copyWith(
          color: Colors.grey[600],
          fontWeight: FontWeight.w300,
        ),
      );
    } else if (lastMessageType == MessageType.image) {
      return Row(
        children: [
          Icon(
            IconlyLight.image,
            size: 14,
            color: Colors.grey[600],
          ),
          const SizedBox(width: 4),
          Text(
            'Image',
            style: Get.textTheme.caption!.copyWith(
              color: Colors.grey[600],
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      );
    } else {
      return Row(
        children: [
          Icon(
            IconlyLight.show,
            size: 14,
            color: Colors.grey[600],
          ),
          const SizedBox(width: 4),
          Text(
            'Reveal request',
            style: Get.textTheme.caption!.copyWith(
              color: Colors.grey[600],
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      );
    }
  }
}
