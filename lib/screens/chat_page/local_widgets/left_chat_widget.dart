import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeftChatWidget extends StatelessWidget {
  final ImageProvider profileImage;
  final Widget content;
  final String time;

  const LeftChatWidget({
    Key? key,
    required this.profileImage,
    required this.content,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey,
              image: DecorationImage(
                image: profileImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            width: 12,
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: Get.width * 0.6,
            ),
            child: Container(
              padding: EdgeInsets.only(bottom: 8, top: 16, left: 16, right: 16),
              decoration: BoxDecoration(
                color: Color(0xFFFFEAF4),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF8F8F8F).withOpacity(0.15),
                    offset: const Offset(0, 4),
                    blurRadius: 27,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  content,
                  SizedBox(height: 4),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      time,
                      style: Get.textTheme.caption!.copyWith(
                        color: Color(0xFF737373),
                        fontSize: 9,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
