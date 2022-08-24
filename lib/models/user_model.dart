// To parse this JSON data, do
//
//     final userModel = userModelFromMap(jsonString);

import 'dart:convert';

List<UserModel> userModelFromMap(String str) =>
    List<UserModel>.from(json.decode(str).map((x) => UserModel.fromMap(x)));

String userModelToMap(List<UserModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class UserModel {
  String name;
  String uid;
  String profilePic;
  bool isOnline;
  String phoneNumber;
  List<String> groupId;

  UserModel({
    required this.name,
    required this.uid,
    required this.profilePic,
    required this.isOnline,
    required this.phoneNumber,
    required this.groupId,
  });

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        name: json["name"],
        uid: json["uid"],
        profilePic: json["profilePic"],
        isOnline: json["isOnline"],
        phoneNumber: json["phoneNumber"],
        groupId: List<String>.from(json["groupId"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "uid": uid,
        "profilePic": profilePic,
        "isOnline": isOnline,
        "phoneNumber": phoneNumber,
        "groupId": List<dynamic>.from(groupId.map((x) => x)),
      };
}
