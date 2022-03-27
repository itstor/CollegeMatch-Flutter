import 'package:college_match/core/values/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';

class MessageTextFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final VoidCallback onSendPressed;

  const MessageTextFieldWidget({
    Key? key,
    this.controller,
    required this.onSendPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: null,
      style: Get.textTheme.bodyText2!.copyWith(
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        hintText: 'Type a message...',
        hintStyle: Get.textTheme.caption!.copyWith(
          color: const Color(0xFFADADAD),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: Color(0xFFE6E6E6), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide:
              BorderSide(color: AppColor.kPrimaryPurple[100]!, width: 1),
        ),
        filled: true,
        fillColor: AppColor.kGrayColor[10]!,
        suffixIcon: IconButton(
          icon: Icon(IconlyLight.send),
          onPressed: onSendPressed,
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(),
        ),
      ),
      cursorColor: AppColor.kPrimaryPurple[100]!,
    );
  }
}
