import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_match/core/values/colors.dart';
import 'package:college_match/data/model/message_chat_model.dart';
import 'package:college_match/data/model/user_model.dart';
import 'package:college_match/screens/chat_page/chat_page.dart';
import 'package:college_match/screens/global_widgets/dot_loading.dart';
import 'package:college_match/screens/main_page/controllers/main_page_controller.dart';
import 'package:college_match/screens/main_page/local_widgets/chat_item_widget.dart';
import 'package:college_match/screens/main_page/local_widgets/chat_load_widget.dart';
import 'package:college_match/screens/main_page/local_widgets/main_page_tabbar_widget.dart';
import 'package:college_match/screens/personal_data_page/personal_data_page.dart';
import 'package:college_match/screens/search_partner_page/search_partner_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class MainPage extends StatelessWidget {
  static String routeName = '/main-page';
  final _controller = Get.find<MainPageController>();

  MainPage({Key? key}) : super(key: key);

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
          SafeArea(
            child: _controller.userData.obx(
              (data) => Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Container(
                      height: 155,
                      child: Column(
                        children: [
                          const SizedBox(height: 27),
                          _buildHeader(data!, context),
                          Expanded(
                            child: Center(
                              child: _buildTabBar(),
                            ),
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
                      child: TabBarView(
                        controller:
                            _controller.mainPageTabBarController.tabController,
                        children: [
                          _buildStreamChat(data, null),
                          _buildStreamChat(data, true),
                          _buildStreamChat(data, false),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: Get.size.width,
                  height: 60,
                  // color: Colors.amber,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(
                            IconlyBold.chat,
                            size: 24,
                            color: Color(0xFFB093FF),
                          ),
                          SizedBox(width: 8),
                          Text(
                            "Chat",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFB093FF),
                            ),
                          )
                        ],
                      ),
                      SizedBox(width: 8),
                      InkWell(
                        onTap: () {
                          Get.toNamed(PersonalDataPage.routeName,
                              arguments: {'retake': true});
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(
                              IconlyLight.document,
                              size: 24,
                              color: Color(0xFFA8ACB9),
                            ),
                            SizedBox(width: 8),
                            Text(
                              "Retest",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFFA8ACB9),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 25,
                  left: Get.width / 2 - 40,
                  child: Container(
                    width: 68,
                    height: 68,
                    decoration: const BoxDecoration(
                        color: Color(0xFFA989FF),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFFB093FF),
                            blurRadius: 15,
                            spreadRadius: 0,
                            offset: Offset(0, 5),
                          )
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 30,
                          height: 30,
                          child: IconButton(
                            icon: Image.asset(
                                'assets/icons/search-partner-icon.png'),
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(),
                            onPressed: () {
                              Get.toNamed(SearchPartnerPage.routeName);
                              print('here');
                            },
                          ),
                        ),
                        Text(
                          'Match',
                          style: Get.textTheme.caption!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 9,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Padding _buildStreamChat(UserModel data, bool? revealed) {
    return Padding(
        padding: const EdgeInsets.only(left: 32, right: 32, top: 18),
        child: StreamBuilder<QuerySnapshot>(
          stream: _controller.chatService
              .getMainChatStream(data.uid!, 20, revealed),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("Error: ${snapshot.error}"),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: DotLoading(),
              );
            }
            if (snapshot.data!.docs.isEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/animations/no-message.gif',
                    width: 300,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ],
              );
            }
            return ListView.separated(
              itemCount: snapshot.data?.docs.length ?? 0,
              separatorBuilder: (context, index) => const SizedBox(
                height: 28,
              ),
              itemBuilder: (BuildContext context, int index) {
                final DocumentSnapshot? document = snapshot.data?.docs[index];

                final ofList = (document!['of'] as List<dynamic>);

                ofList.removeWhere((element) => element == data.uid);

                return FutureBuilder<UserModel>(
                  future: _controller.userService.getUser(ofList[0]),
                  builder: (context, dataFuture) {
                    if (dataFuture.hasData) {
                      late Image profPic;
                      if (document['revealed'] != true) {
                        if (dataFuture.data!.gender! == 'Male') {
                          profPic = Image.asset(
                              'assets/images/default-profile-picture/male.png');
                        } else if (dataFuture.data!.gender! == 'Female') {
                          profPic = Image.asset(
                              'assets/images/default-profile-picture/female.png');
                        }
                      } else {
                        profPic = Image(
                            image: CachedNetworkImageProvider(
                                dataFuture.data!.photoUrl!));
                      }

                      return ChatItemWidget(
                          profileImage: profPic,
                          lastMessageType:
                              MessageType.values[document['lastMessageType']],
                          name: document['revealed']
                              ? dataFuture.data!.name!
                              : dataFuture.data!.major!,
                          lastMessage: document['lastMessage'] as String,
                          time: DateTime.fromMillisecondsSinceEpoch(
                              document['lastMessageTimestamp']),
                          onPressed: () {
                            Get.toNamed(ChatPage.routeName, arguments: {
                              'peerUser': dataFuture.data!,
                              'isRevealed': document['revealed'],
                              'groupChatId': document.id,
                            });
                          });
                    } else {
                      return const ChatLoadWidget();
                    }
                  },
                );
              },
            );
          },
        ));
  }

  Container _buildTabBar() {
    return Container(
      width: Get.size.width * 0.8,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFB2B2B2).withOpacity(0.1),
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.8),
            spreadRadius: -1.0,
            blurRadius: 7.0,
          ),
        ],
      ),
      child: MainPageTabBarWidget(
        tabController: _controller.mainPageTabBarController.tabController,
        tabTitle: const [
          'All',
          'Friends',
          'Stranger',
        ],
      ),
    );
  }

  Widget _buildHeader(UserModel data, BuildContext context) {
    return Container(
      // color: Colors.amber,
      child: Row(
        children: [
          Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(22),
              image: DecorationImage(
                image: CachedNetworkImageProvider(data.photoUrl!),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _controller.getHeaderGreetings(),
                  style: Get.textTheme.caption!.copyWith(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w300,
                    fontSize: 12,
                  ),
                ),
                Text(
                  data.name ?? 'null',
                  style: Get.textTheme.subtitle2!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          // Container(
          //   height: 32,
          //   width: 32,
          //   decoration: BoxDecoration(
          //     color: AppColor.kPrimaryPink[100]!,
          //     shape: BoxShape.circle,
          //   ),
          //   child: IconButton(
          //     onPressed: () {
          //       // print("Notif Icon CLicked");
          //       Get.toNamed(SearchPartnerPage.routeName);
          //     },
          //     icon: const Icon(
          //       IconlyLight.notification,
          //       color: Colors.white,
          //       size: 16,
          //     ),
          //   ),
          // ),
          const SizedBox(width: 8),
          Container(
            height: 32,
            width: 32,
            decoration: const BoxDecoration(
              color: Color(0xFFC4B1F8),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () async {
                await showMenu(
                  context: context,
                  position: RelativeRect.fromLTRB(Get.width, 50, 0, 0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 3,
                  items: [
                    PopupMenuItem(
                        onTap: () => _controller.authService.signOut(),
                        child: Row(
                          children: [
                            Container(
                              height: 32,
                              width: 32,
                              decoration: BoxDecoration(
                                color: AppColor.kPrimaryPurple[100],
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                IconlyLight.logout,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Logout',
                              style: Get.textTheme.bodyText2!.copyWith(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        value: 'logout'),
                  ],
                );
              },
              icon: const Icon(
                Icons.more_vert_rounded,
                color: Colors.white,
                size: 16,
              ),
            ),
          )
        ],
      ),
    );
  }
}
