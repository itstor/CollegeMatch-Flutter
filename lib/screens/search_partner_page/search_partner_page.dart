import 'package:college_match/screens/search_partner_page/local_widgets/finding_widget.dart';
import 'package:college_match/screens/search_partner_page/search_partner_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchPartnerPage extends StatelessWidget {
  static String routeName = '/search-partner';
  final _controller = Get.find<SearchPartnerController>();

  SearchPartnerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background-2.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          FindingWidget()
        ],
      ),
    );
  }
}
