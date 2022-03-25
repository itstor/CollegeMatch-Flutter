import 'package:college_match/core/values/colors.dart';
import 'package:college_match/data/services/auth_service.dart';
import 'package:college_match/screens/global_widgets/notification_button_widget.dart';
import 'package:college_match/screens/global_widgets/rounded_icon_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';

class ChatPage extends StatelessWidget {
  static String routeName = '/chat-page';

  final _authService = Get.find<AuthService>();

  ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background-1.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Container(
                    height: 155,
                    child: Column(
                      children: [
                        const SizedBox(height: 27),
                        _buildHeader(),
                        Expanded(
                          child: Center(
                              child: Container(
                            width: Get.size.width * 0.8,
                            height: 40,
                            // color: Colors.amber,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                              //TODO Inner Shadow
                            ),
                          )),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32),
                      ),
                    ),
                    padding: EdgeInsets.only(top: 32),
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 32),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Chat',
                              style: Get.textTheme.headline1,
                            ),
                            const SizedBox(height: 25),
                            Container(
                              height: 44,
                              child: Row(
                                children: [
                                  Container(
                                    height: 44,
                                    width: 44,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Carl Johson',
                                          style: Get.textTheme.bodyText1,
                                        ),
                                        Text(
                                          'Halo Selamat  Pagi',
                                          style:
                                              Get.textTheme.caption!.copyWith(
                                            color: Colors.grey[600],
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          '12:30',
                                          style:
                                              Get.textTheme.caption!.copyWith(
                                            color: Colors.grey[600],
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                        Text(
                                          'Today',
                                          style:
                                              Get.textTheme.caption!.copyWith(
                                            color: Colors.grey[600],
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 25),
                            ElevatedButton(
                                onPressed: () => _authService.signOut(),
                                child: Text("Logout"))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: Get.size.width,
              height: 60,
              // color: Colors.amber,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 50,
                    spreadRadius: 0,
                    offset: const Offset(0, -5),
                  )
                ],
              ),
              child: Row(),
            ),
          )
        ],
      ),
    );
  }

  Row _buildHeader() {
    return Row(
      children: [
        Container(
          height: 45,
          width: 45,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(22),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Good Evening',
                style: Get.textTheme.caption!.copyWith(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w300,
                  fontSize: 12,
                ),
              ),
              Text(
                'John Doe',
                style: Get.textTheme.subtitle1!.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        NotficationButtonWidget(
          size: 32,
          color: AppColor.kPrimaryPink[100]!,
          icon: const Icon(
            IconlyLight.notification,
            color: Colors.white,
            size: 16,
          ),
          onPressed: () {},
          notificationColor: AppColor.kAccentColor['red']!,
          notificationSize: 18,
          number: 10,
        ),
        SizedBox(width: 8),
        Container(
          height: 32,
          width: 32,
          decoration: BoxDecoration(
            color: Color(0xFFC4B1F8),
            borderRadius: BorderRadius.circular(20),
          ),
          child: IconButton(
            onPressed: () {
              //TODO Notification Button
              print("Hllo");
            },
            icon: const Icon(
              IconlyLight.search,
              color: Colors.white,
              size: 16,
            ),
          ),
        )
      ],
    );
  }
}
