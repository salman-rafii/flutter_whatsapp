import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_whatsapp/common/enums/message_enum.dart';
import 'package:flutter_whatsapp/common/utils/utils.dart';
import 'package:flutter_whatsapp/models/chat_contact.dart';
import 'package:flutter_whatsapp/models/message.dart';
import 'package:flutter_whatsapp/models/user_model.dart';
import 'package:uuid/uuid.dart';

final chatRepositoryProvider = Provider((ref) => ChatRepository(
    firestore: FirebaseFirestore.instance, auth: FirebaseAuth.instance));

class ChatRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  ChatRepository({
    required this.firestore,
    required this.auth,
  });

  Stream<List<ChatContact>> getChatContacts() {
    return firestore
        .collection("users")
        .doc(auth.currentUser!.uid)
        .collection("chats")
        .snapshots()
        .asyncMap((event) async {
      List<ChatContact> contacts = [];
      for (var documents in event.docs) {
        var chatContact = ChatContact.fromMap(documents.data());
        var userData = await firestore
            .collection('users')
            .doc(chatContact.contactId)
            .get();
        var user = UserModel.fromMap(userData.data()!);
        contacts.add(ChatContact(
            name: user.name,
            profilePic: user.profilePic,
            contactId: chatContact.contactId,
            lastMessage: chatContact.lastMessage,
            timeSent: chatContact.timeSent));
      }
      return contacts;
    });
  }

  void _saveDataToContactSubcollection(
    UserModel senderUserData,
    UserModel receiverUserData,
    String message,
    DateTime timeSent,
    String receiverUserId,
  ) async {
    // users > receiver user id > chats > current user id > set data
    var receiverChatContact = ChatContact(
      name: senderUserData.name,
      profilePic: senderUserData.profilePic,
      contactId: senderUserData.uid,
      lastMessage: message,
      timeSent: timeSent,
    );
    await firestore
        .collection("users")
        .doc(receiverUserId)
        .collection("chats")
        .doc(senderUserData.uid)
        .set(receiverChatContact.toMap());
    // users > current user id  > chats > receiver user id > set data
    var senderChatContact = ChatContact(
      name: receiverUserData.name,
      profilePic: receiverUserData.profilePic,
      contactId: receiverUserData.uid,
      lastMessage: message,
      timeSent: timeSent,
    );
    await firestore
        .collection("users")
        .doc(senderUserData.uid)
        .collection("chats")
        .doc(receiverUserId)
        .set(senderChatContact.toMap());
  }

  void _saveMessagetoMessageSubCollection({
    required String receiverUserid,
    required String text,
    required DateTime timeSent,
    required String messageId,
    required String username,
    required String receiverUsername,
    required MessageEnum messageType,
  }) async {
    final message = Message(
      senderId: auth.currentUser!.uid,
      recieverid: receiverUserid,
      text: text,
      type: messageType,
      timeSent: timeSent,
      messageId: messageId,
      isSeen: false,
    );
    // users -> senderid > receiverid >messages > messageid > storemessage

    await firestore
        .collection("users")
        .doc(auth.currentUser!.uid)
        .collection("chats")
        .doc(receiverUserid)
        .collection("messages")
        .doc(messageId)
        .set(message.toMap());

    // users -> receiverid > senderid >messages > messageid > storemessage

    await firestore
        .collection("users")
        .doc(receiverUserid)
        .collection("chats")
        .doc(auth.currentUser!.uid)
        .collection("messages")
        .doc(messageId)
        .set(message.toMap());
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
      var messageId = const Uuid().v1();
      // users > receiver user id > chats > current user id > set data
      _saveDataToContactSubcollection(
        senderUser,
        receiverUserData,
        text,
        timeSent,
        receiverUserId,
      );

      _saveMessagetoMessageSubCollection(
        receiverUserid: receiverUserId,
        text: text,
        timeSent: timeSent,
        messageType: MessageEnum.text,
        messageId: messageId,
        receiverUsername: receiverUserData.name,
        username: senderUser.name,
      );
    } catch (e) {
      showSnackbar(context: context, content: e.toString());
    }
  }
}
