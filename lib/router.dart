import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_whatsapp/common/widgets/error.dart';
import 'package:flutter_whatsapp/features/auth/screens/login_screen.dart';
import 'package:flutter_whatsapp/features/auth/screens/otp_screen.dart';
import 'package:flutter_whatsapp/features/auth/screens/user_information_screen.dart';
import 'package:flutter_whatsapp/features/select_contact/screens/select_contact_screen.dart';
import 'package:flutter_whatsapp/features/chat/screens/mobile_chat_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginScreen.routeName:
      return MaterialPageRoute(builder: (context) => const LoginScreen());
    case OTPScreen.routeName:
      final verificationId = settings.arguments as String;
      return MaterialPageRoute(
          builder: (context) => OTPScreen(
                verificationId: verificationId,
              ));
    case UserInformationScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const UserInformationScreen(),
      );
    case SelectContactScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const SelectContactScreen(),
      );
    case MobileChatScreen.routeName:
      final arguments = settings.arguments as Map<String, dynamic>;
      final name = arguments['name'];
      final uid = arguments['uid'];
      return MaterialPageRoute(
        builder: (context) => MobileChatScreen(
          name: name,
          uid: uid,
        ),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: ErrorScreen(error: 'This page doesn\'t exist'),
        ),
      );
  }
}
