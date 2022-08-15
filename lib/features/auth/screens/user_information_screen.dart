import 'package:flutter/material.dart';

class UserInformationScreen extends StatelessWidget {
  static const String routeName = "/user-information";
  const UserInformationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("User Information Screen"),
      ),
    );
  }
}
