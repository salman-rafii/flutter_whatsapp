import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_whatsapp/colors.dart';
import 'package:flutter_whatsapp/common/widgets/loader.dart';
import 'package:flutter_whatsapp/features/auth/controller/auth_controller.dart';
import 'package:flutter_whatsapp/features/chat/widgets/bottom_chat_field.dart';
import 'package:flutter_whatsapp/models/user_model.dart';
import 'package:flutter_whatsapp/widgets/chat_list.dart';

class MobileChatScreen extends ConsumerWidget {
  static const String routeName = "/mobile-chat-screen";
  final String name;
  final String uid;
  const MobileChatScreen({
    Key? key,
    required this.name,
    required this.uid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: StreamBuilder<UserModel>(
            stream: ref.read(authcontrollerProvider).userDataById(uid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Loader();
              }
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                    ),
                    Text(
                      snapshot.data!.isOnline ? 'online' : 'offline',
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.normal),
                    )
                  ],
                ),
              );
            }),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.video_call),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.call),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Column(
        children: const [
          Expanded(
            child: ChatList(),
          ),
          BottomChatField(),
        ],
      ),
    );
  }
}
