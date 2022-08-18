import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_whatsapp/common/utils/utils.dart';

class UserInformationScreen extends StatefulWidget {
  static const String routeName = "/user-information";
  const UserInformationScreen({Key? key}) : super(key: key);

  @override
  State<UserInformationScreen> createState() => _UserInformationScreenState();
}

class _UserInformationScreenState extends State<UserInformationScreen> {
  final TextEditingController nameController = TextEditingController();
  File? image;
  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
  }

  void selectImage() async {
    image = await pickImageFromGallery(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(children: [
            Stack(
              children: [
                image == null
                    ? const CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://png.pngitem.com/pimgs/s/649-6490124_katie-notopoulos-katienotopoulos-i-write-about-tech-round.png'),
                        radius: 64,
                      )
                    : CircleAvatar(
                        backgroundImage: FileImage(image!),
                        radius: 64,
                      ),
                Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                        onPressed: selectImage,
                        icon: const Icon(Icons.add_a_photo)))
              ],
            ),
            Row(
              children: [
                Container(
                  width: size.width * 0.85,
                  padding: const EdgeInsets.all(20),
                  child: TextField(
                    controller: nameController,
                    decoration:
                        const InputDecoration(hintText: "Enter your Name"),
                  ),
                ),
                IconButton(onPressed: () {}, icon: const Icon(Icons.done))
              ],
            )
          ]),
        ),
      ),
    );
  }
}
