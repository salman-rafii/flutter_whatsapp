import 'package:flutter/material.dart';
import 'package:flutter_whatsapp/colors.dart';
import 'package:flutter_whatsapp/common/widgets/custom_button.dart';
import 'package:flutter_whatsapp/features/auth/screens/login_screen.dart';
import 'package:flutter_whatsapp/widgets/custom_text.dart';
import 'package:flutter_whatsapp/widgets/size_config.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  void navigateToLogin(BuildContext context) {
    Navigator.pushNamed(context, LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Center(
              child: CustomText(
                text: "Welcome to Whatsapp",
                fontSize: MySize.size40,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: size.height / 9,
            ),
            Image.asset(
              "assets/bg.png",
              height: 340,
              width: 340,
              color: tabColor,
            ),
            SizedBox(
              height: size.height / 9,
            ),
            Container(
              padding: const EdgeInsets.all(15.0),
              child: const CustomText(
                text:
                    'Read our privacy policy. Tap "Agree and Continue" to accept the Terms of Service',
                color: greyColor,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: size.width * 0.75,
              child: CustomButton(
                text: "AGREE AND CONTINUE",
                onPressed: () => navigateToLogin(context),
              ),
            )
          ],
        ),
      ),
    );
  }
}
