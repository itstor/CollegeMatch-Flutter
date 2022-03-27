import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RightChatWidget extends StatelessWidget {
  final Widget content;
  final String time;

  const RightChatWidget({
    Key? key,
    required this.content,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: Get.width * 0.6,
            ),
            child: Container(
              padding: EdgeInsets.only(bottom: 8, top: 16, left: 16, right: 16),
              decoration: BoxDecoration(
                color: Color(0xFFDED6F4),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
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
