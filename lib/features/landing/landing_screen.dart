import 'package:flutter/material.dart';
import 'package:flutter_whatsapp/widgets/custom_text.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: const [
            SizedBox(
              height: 50,
            ),
            CustomText(
              text: "Welcome to Whatsapp",
              fontSize: 33,
              fontWeight: FontWeight.w600,
            )
          ],
        ),
      ),
    );
  }
}
