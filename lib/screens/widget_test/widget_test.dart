import 'package:college_match/screens/global_widgets/circle_logo_widget.dart';
import 'package:college_match/screens/global_widgets/button_logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WidgetTest extends StatelessWidget {
  const WidgetTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 11,
          horizontal: 11,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            signInWithGoogleButton(),
            SizedBox(height: 10),
            signInWithEmail(),
            SizedBox(height: 10),
            OutlinedButton(
              onPressed: () {},
              child: Text('Elevated Button'),
              style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  primary: Colors.white,
                  backgroundColor: Colors.black,
                  shadowColor: Colors.purple),
            ),
          ],
        ),
      )),
    );
  }

  ButtonLogoWidget signInWithGoogleButton() {
    return ButtonLogoWidget(
      height: 60,
      width: 300,
      padding: EdgeInsets.all(11),
      logo: CircleLogoWidget(
          diameter: 38,
          color: Colors.white,
          image: Image.asset("assets/icons/google-icon.png"),
          padding: 8),
      color: Colors.white.withOpacity(0.58),
      text: "Sign in with Google",
      onTap: () {},
    );
  }

  ButtonLogoWidget signInWithEmail() {
    return ButtonLogoWidget(
      height: 60,
      width: 300,
      padding: EdgeInsets.all(11),
      logo: CircleLogoWidget(
        diameter: 38,
        color: Colors.white,
        image: Image.asset("assets/icons/mail-icon.png"),
        padding: 8,
      ),
      color: Colors.black,
      text: "Sign in with Email",
      textColor: Colors.white,
      onTap: () {
        Get.toNamed("/welcome");
      },
    );
  }
}
