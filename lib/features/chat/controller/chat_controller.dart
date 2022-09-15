import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_whatsapp/features/auth/controller/auth_controller.dart';
import 'package:flutter_whatsapp/features/chat/repositories/chat_repository.dart';
import 'package:flutter_whatsapp/models/chat_contact.dart';

final chatControllerProvider = Provider((ref) {
  final chatRepository = ref.watch(chatRepositoryProvider);
  return ChatController(chatRepository: chatRepository, ref: ref);
});

class ChatController {
  ChatRepository chatRepository;
  ProviderRef ref;
  ChatController({required this.chatRepository, required this.ref});

  Stream<List<ChatContact>> chatContacts() {
    return chatRepository.getChatContacts();
  }

  void sendTextMessage(
      BuildContext context, String text, String receiverUserId) {
    ref.read(userDataAuthProvider).whenData(
          (value) => chatRepository.sendTextMessage(
            context: context,
            text: text,
            receiverUserId: receiverUserId,
            senderUser: value!,
          ),
        );
  }
}
