import 'package:college_match/screens/chat_page/chat_page.dart';
import 'package:college_match/screens/chat_page/chat_page_binding.dart';
import 'package:college_match/screens/chat_page/controllers/chat_page_controller.dart';
import 'package:college_match/screens/main_page/main_page.dart';
import 'package:college_match/screens/main_page/main_page_binding.dart';
import 'package:college_match/screens/personal_data_page/personal_data_binding.dart';
import 'package:college_match/screens/personal_data_page/personal_data_page.dart';
import 'package:college_match/screens/search_partner_page/search_partner_binding.dart';
import 'package:college_match/screens/search_partner_page/search_partner_page.dart';
import 'package:college_match/screens/welcome_page/welcome_page.dart';
import 'package:college_match/screens/welcome_page/welcome_page_binding.dart';
import 'package:get/get.dart';

class AppRoutes {
  static final routes = [
    GetPage(
      name: WelcomePage.routeName,
      page: () => WelcomePage(),
      binding: WelcomePageBinding(),
    ),
    GetPage(
      name: MainPage.routeName,
      page: () => MainPage(),
      binding: MainPageBinding(),
    ),
    GetPage(
      name: PersonalDataPage.routeName,
      page: () => PersonalDataPage(),
      binding: PersonalDataBinding(),
    ),
    GetPage(
      name: ChatPage.routeName,
      page: () => ChatPage(),
      binding: ChatPageBinding(),
    ),
    GetPage(
      name: SearchPartnerPage.routeName,
      page: () => SearchPartnerPage(),
      binding: SeacrhPartnerBinding(),
      transition: Transition.fade,
    )
  ];
}
