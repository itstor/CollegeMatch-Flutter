import 'package:college_match/screens/chat_page/chat_page.dart';
import 'package:college_match/screens/personal_data_page/personal_data_binding.dart';
import 'package:college_match/screens/personal_data_page/personal_data_page.dart';
import 'package:college_match/screens/welcome_page/welcome_page.dart';
import 'package:college_match/screens/welcome_page/welcome_page_binding.dart';
import 'package:get/get.dart';

class AppRoutes {
  static final routes = [
    GetPage(
        name: WelcomePage.routeName,
        page: () => WelcomePage(),
        binding: WelcomePageBinding()),
    GetPage(
      name: ChatPage.routeName,
      page: () => ChatPage(),
    ),
    GetPage(
      name: PersonalDataPage.routeName,
      page: () => PersonalDataPage(),
      binding: PersonalDataBinding(),
    ),
  ];
}
