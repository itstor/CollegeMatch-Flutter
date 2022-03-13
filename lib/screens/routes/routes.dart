import 'package:college_match/screens/chat_page/chat_page.dart';
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
    )
  ];
}
