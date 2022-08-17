import 'package:flutter/material.dart';

class UserInformationScreen extends StatelessWidget {
  static const String routeName = "/user-information";
  const UserInformationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(children: [
          Stack(
            children: [
              const CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://png.pngitem.com/pimgs/s/649-6490124_katie-notopoulos-katienotopoulos-i-write-about-tech-round.png'),
              ),
              Positioned(
                  bottom: -10,
                  left: 80,
                  child: IconButton(
                      onPressed: () {}, icon: const Icon(Icons.add_a_photo)))
            ],
          ),
          Row(
            children: [
              Container(
                width: size.width * 0.85,
              )
            ],
          )
        ]),
      ),
    );
  }
}
