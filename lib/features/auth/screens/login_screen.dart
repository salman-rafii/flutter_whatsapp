// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_whatsapp/colors.dart';
import 'package:flutter_whatsapp/common/widgets/custom_button.dart';
import 'package:flutter_whatsapp/widgets/custom_text.dart';
import 'package:country_picker/country_picker.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "/login-screen";
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final phoneController = TextEditingController();
  Country? country;
  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  void pickCountry() {
    showCountryPicker(
        context: context,
        onSelect: (Country _country) {
          setState(() {
            country = _country;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: backgroundColor,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text("Enter your Phone Number"),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CustomText(
                    text: "Whatsapp will need to verify your phone number"),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: pickCountry,
                  child: const Text(
                    "Pick Country",
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    if (country != null) Text('+${country!.phoneCode}'),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: size.width * 0.7,
                      child: TextField(
                        controller: phoneController,
                        decoration:
                            const InputDecoration(hintText: "Phone Number"),
                      ),
                    )
                  ],
                ),
                SizedBox(height: size.height * 0.6),
                SizedBox(
                  width: 90,
                  child: CustomButton(text: "NEXT", onPressed: () {}),
                ),
              ],
            ),
          ),
        ));
  }
}
