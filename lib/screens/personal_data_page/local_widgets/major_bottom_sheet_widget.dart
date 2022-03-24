import 'package:college_match/data/model/major_model.dart';
import 'package:college_match/screens/global_widgets/rounded_text_field_widget.dart';
import 'package:college_match/screens/personal_data_page/controllers/majors_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';

class MajorBottomSheetWidget {
  static Future<dynamic> majorBottomSheetWidget(
    BuildContext context, {
    required TextEditingController majorTextController,
    required TextEditingController searchTextController,
    required List<MajorModel> data,
  }) {
    List<MajorModel> _tempMajorList = [];

    return showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
      ),
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return DraggableScrollableSheet(
              expand: false,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RoundedTextFieldWidget(
                        hintText: 'Search',
                        controller: searchTextController,
                        suffixIcon: const Icon(
                          IconlyLight.search,
                          color: Colors.grey,
                        ),
                        onChanged: (value) {
                          setState(() {
                            _tempMajorList.clear();
                            _tempMajorList.addAll(data.where((element) =>
                                element.major.toLowerCase().contains(value)));
                          });
                        },
                      ),
                      SizedBox(height: 16),
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                majorTextController.text = (_tempMajorList
                                            .isNotEmpty ||
                                        searchTextController.text.isNotEmpty)
                                    ? _tempMajorList[index].major
                                    : data[index].major;

                                Get.back();
                              },
                              child: (_tempMajorList.isNotEmpty ||
                                      searchTextController.text.isNotEmpty)
                                  ? ListTile(
                                      title: Text(
                                        _tempMajorList[index].major,
                                        style:
                                            Get.textTheme.bodyText2!.copyWith(
                                          fontSize: 16,
                                        ),
                                      ),
                                    )
                                  : ListTile(
                                      title: Text(
                                        data[index].major,
                                        style:
                                            Get.textTheme.bodyText2!.copyWith(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                            );
                          },
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 1),
                          itemCount: (_tempMajorList.isNotEmpty ||
                                  searchTextController.text.isNotEmpty)
                              ? _tempMajorList.length
                              : data.length,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
