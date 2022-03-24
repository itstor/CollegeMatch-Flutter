import 'package:college_match/controller/auth_controller.dart';
import 'package:college_match/core/themes/app_theme.dart';
import 'package:college_match/core/values/firebase_constants.dart';
import 'package:college_match/data/services/auth_service.dart';
import 'package:college_match/screens/routes/routes.dart';
import 'package:college_match/screens/welcome_page/welcome_page.dart';
import 'package:college_match/screens/widget_test/widget_test.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await firebaseInitialization.then((_) {
    Get.lazyPut(() => AuthService());
    // Get.put(AuthController());
  });
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'College Match',
      theme: AppThemes.lightTheme,
      // initialRoute: '/welcome-page',
      initialRoute: '/personal-data-page',
      getPages: AppRoutes.routes,
    );
  }
}
