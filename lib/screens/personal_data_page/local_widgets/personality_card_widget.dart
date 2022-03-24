import 'package:college_match/screens/personal_data_page/local_widgets/slider_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PersonalityCardWidget extends StatelessWidget {
  final String question;
  final ValueChanged<double?> onChanged;
  final double initialValue;

  const PersonalityCardWidget({
    Key? key,
    required this.question,
    required this.onChanged,
    this.initialValue = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: Get.textTheme.subtitle2!.copyWith(
              fontSize: 14,
            ),
          ),
          SizedBox(height: 18),
          SliderWidget(
            min: 0,
            max: 5,
            onChanged: onChanged,
            value: initialValue,
          ),
        ],
      ),
    );
  }
}
