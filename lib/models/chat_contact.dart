import 'dart:convert';

class ChatContact {
  final String name;
  final String profilePic;
  final String contactId;
  final String lastMessage;
  final DateTime timeSent;
  ChatContact({
    required this.name,
    required this.profilePic,
    required this.contactId,
    required this.lastMessage,
    required this.timeSent,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'profilePic': profilePic,
      'contactId': contactId,
      'lastMessage': lastMessage,
      'timeSent': timeSent.millisecondsSinceEpoch,
    };
  }

  factory ChatContact.fromMap(Map<String, dynamic> map) {
    return ChatContact(
      name: map['name'],
      profilePic: map['profilePic'],
      contactId: map['contactId'],
      lastMessage: map['lastMessage'],
      timeSent: DateTime.fromMillisecondsSinceEpoch(map['timeSent']),
    );
  }
}
