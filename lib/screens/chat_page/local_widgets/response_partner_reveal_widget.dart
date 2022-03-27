import 'package:college_match/core/values/colors.dart';
import 'package:college_match/screens/global_widgets/glow_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResponsePartnerRevealWidget extends StatelessWidget {
  final VoidCallback onTap;
  const ResponsePartnerRevealWidget({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 300,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(
              Radius.circular(16),
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
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 8),
              Text(
                'Your partner ask to reveal identity',
                style: Get.textTheme.subtitle1,
              ),
              SizedBox(height: 4),
              Text(
                'Ignore to decline',
                style: Get.textTheme.caption,
              ),
              SizedBox(height: 16),
              GlowButtonWidget(
                height: 50,
                width: double.infinity,
                child: Center(
                  child: Text(
                    "Accept",
                    style: Get.textTheme.subtitle1!.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
                backgroundColor: Color(0xFFA989FF),
                glowColor: AppColor.kPrimaryPurple[100]!,
                glowOffset: const Offset(0, 6),
                borderRadius: 12,
                blurRadius: 22,
                onPressed: onTap,
              ),
            ],
          ),
        )
      ],
    );
  }
}
