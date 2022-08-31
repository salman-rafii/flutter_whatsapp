import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_whatsapp/common/utils/utils.dart';
import 'package:flutter_whatsapp/models/chat_contact.dart';
import 'package:flutter_whatsapp/models/user_model.dart';

class ChatRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  ChatRepository({
    required this.firestore,
    required this.auth,
  });

  void _saveDataToContactSubcollection(
      UserModel senderUserData,
      UserModel receiverUserData,
      String message,
      DateTime timeSent,
      String receiverUserId) async {
    // users > receiver user id > chats > current user id > set data
    var receiverChatContact = ChatContact(
        name: senderUserData.name,
        profilePic: senderUserData.profilePic,
        contactId: senderUserData.uid,
        lastMessage: message,
        timeSent: timeSent);
    await firestore
        .collection("users")
        .doc(receiverUserId)
        .collection("chats")
        .doc(auth.currentUser!.uid)
        .set(receiverChatContact.toMap());
    // users > current user id  > chats > receiver user id > set data
  }

  void sendTextMessage({
    required BuildContext context,
    required String text,
    required String receiverUserId,
    required UserModel senderUser,
  }) async {
    try {
      // users -> senderid > receiverid >messages > messageid > storemessage
      var timeSent = DateTime.now();
      UserModel receiverUserData;
      var receiverUserDataMap =
          await firestore.collection("users").doc(receiverUserId).get();
      receiverUserData = UserModel.fromMap(receiverUserDataMap.data()!);

      // users > receiver user id > chats > current user id > set data
      _saveDataToContactSubcollection(
          senderUser, receiverUserData, text, timeSent, receiverUserId);
    } catch (e) {
      showSnackbar(context: context, content: e.toString());
    }
  }
}
