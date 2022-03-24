import 'package:college_match/core/values/colors.dart';
import 'package:college_match/data/model/lifestyle_question_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MarkCardWidget extends FormField<bool> {
  final LifestyleQuestionModel text;
  final Function(bool) onTap;

  MarkCardWidget({
    Key? key,
    required this.text,
    required this.onTap,
    required FormFieldSetter<bool> onSaved,
    required FormFieldValidator<bool> validator,
    bool initialValue = false,
    AutovalidateMode autovalidate = AutovalidateMode.disabled,
    bool enabled = true,
  }) : super(
            key: key,
            initialValue: initialValue,
            onSaved: onSaved,
            validator: validator,
            autovalidateMode: autovalidate,
            enabled: enabled,
            builder: (state) {
              return InkWell(
                onTap: () {
                  state.didChange(state.value == true ? false : true);
                  onTap(state.value ?? false);
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Row(
                      children: [
                        const SizedBox(
                          width: 19,
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(
                              right: 18,
                              left: 32,
                              top: 16,
                              bottom: 16,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 4,
                                  offset: Offset(2, 0),
                                ),
                              ],
                            ),
                            child: Text(
                              text.question,
                              style: Get.textTheme.subtitle2!.copyWith(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      left: 0,
                      child: Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(19),
                          color: state.value ?? false
                              ? AppColor.kPrimaryPurple[100]
                              : Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4,
                              offset: Offset(2, 0),
                            ),
                          ],
                        ),
                        child: state.value ?? false
                            ? const Icon(Icons.check_rounded,
                                color: Colors.white)
                            : Container(),
                      ),
                    )
                  ],
                ),
              );
            });
}
